! SUMMA - Structure for Unifying Multiple Modeling Alternatives
! Copyright (C) 2014-2020 NCAR/RAL; University of Saskatchewan; University of Washington
!
! This file is part of SUMMA
!
! For more information see: http://www.ral.ucar.edu/projects/summa
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <http://www.gnu.org/licenses/>.

module summa4chm_modelRun
! calls the model physics

USE data_types,only:&
                    ! no spatial dimension
                    var_i,               & ! x%var(:)            (i4b)
                    var_i8,              & ! x%var(:)            (i8b)
                    var_d,               & ! x%var(:)            (dp)
                    var_ilength,         & ! x%var(:)%dat        (i4b)
                    var_dlength            ! x%var(:)%dat        (dp)

! access missing values
USE globalData,only:integerMissing   ! missing integer
USE globalData,only:realMissing      ! missing double precision number

! named variables
USE globalData,only:yes,no           ! .true. and .false.
! provide access to the named variables that describe elements of parameter structures
USE var_lookup,only:iLookTYPE          ! look-up values for classification of veg, soils etc.
USE var_lookup,only:iLookID            ! look-up values for hru and gru IDs
USE var_lookup,only:iLookATTR          ! look-up values for local attributes
USE var_lookup,only:iLookFLUX          ! look-up values for local column model fluxes
USE var_lookup,only:iLookBVAR          ! look-up values for basin-average model variables
USE var_lookup,only:iLookTIME        ! named variables for time data structure
USE var_lookup,only:iLookDIAG        ! look-up values for local column model diagnostic variables
USE var_lookup,only:iLookINDEX       ! look-up values for local column index variables
USE summa4chm_util,only:handle_err

! safety: set private unless specified otherwise
implicit none
private
public::summa4chm_runPhysics
contains

 ! calls the model physics
 subroutine summa4chm_runPhysics(&
 								modelTimeStep,		&
 							    ! primary data structures (scalars)
  								timeStruct, 		& ! x%var(:)                   -- model time data
  								forcStruct, 		& ! x%var(:)     -- model forcing data
  								attrStruct, 		& ! x%var(:)     -- local attributes for each HRU
  								typeStruct, 		& ! x%var(:)     -- local classification of soil veg etc. for each HRU
  								idStruct, 			& ! x%var(:)     -- local classification of soil veg etc. for each HRU
  								! primary data structures (variable length vectors)
  								indxStruct, 		& ! x%var(:)%dat -- model indices
  								mparStruct, 		& ! x%var(:)%dat -- model parameters
  								progStruct, 		& ! x%var(:)%dat -- model prognostic (state) variables
  								diagStruct, 		& ! x%var(:)%dat -- model diagnostic variables
  								fluxStruct, 		& ! x%var(:)%dat -- model fluxes
  								! basin-average structures
  								bparStruct, 		& ! x%var(:)            -- basin-average parameters
  								bvarStruct, 		& ! x%var(:)%dat        -- basin-average variables
  								! run time variables
  								greenVegFrac_monthly, & ! fraction of green vegetation in each month (0-1)
  								computeVegFlux, 	  & ! flag to indicate if we are computing fluxes over vegetation
  								dt_init, 			& ! used to initialize the length of the sub-step for each HRU
  								err, message)
 ! ---------------------------------------------------------------------------------------
 ! * desired modules
 ! ---------------------------------------------------------------------------------------
 ! data types
 USE nrtype                                                     ! variable types, etc.
 ! subroutines and functions
 USE nr_utility_module,only:indexx                              ! sort vectors in ascending order
 USE vegPhenlgy_module,only:vegPhenlgy                          ! module to compute vegetation phenology
 USE time_utils_module,only:elapsedSec                          ! calculate the elapsed time
 ! global data
 USE globalData,only:gru_struc                                  ! gru-hru mapping structures
 USE globalData,only:model_decisions                            ! model decision structure
 USE globalData,only:startPhysics,endPhysics                    ! date/time for the start and end of the initialization
 USE globalData,only:elapsedPhysics                             ! elapsed time for the initialization
 ! ---------------------------------------------------------------------------------------
 ! * variables
 ! ---------------------------------------------------------------------------------------
 implicit none
 ! dummy variables
 integer(i4b),intent(in)               	  :: modelTimeStep              !  time step index
 ! primary data structures (scalars)
 type(var_i),intent(inout)                :: timeStruct                 !  model time data
 type(var_d),intent(inout)                :: forcStruct                 !  model forcing data
 type(var_d),intent(inout)                :: attrStruct                 !  local attributes for each HRU
 type(var_i),intent(inout)                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),intent(inout)               :: idStruct                   ! 
 ! primary data structures (variable length vectors)
 type(var_ilength),intent(inout)          :: indxStruct                 !  model indices
 type(var_dlength),intent(inout)          :: mparStruct                 !  model parameters
 type(var_dlength),intent(inout)          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),intent(inout)          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),intent(inout)          :: fluxStruct                 !  model fluxes
 ! basin-average structures
 type(var_d),intent(inout)                :: bparStruct                 !  basin-average parameters
 type(var_dlength),intent(inout)          :: bvarStruct                 !  basin-average variables
 real(dp),dimension(12),intent(in)        :: greenVegFrac_monthly       ! fraction of green vegetation in each month (0-1)
 integer(i4b),intent(inout)               :: computeVegFlux             ! flag to indicate if we are computing fluxes over vegetation
 real(dp),intent(inout)					  :: dt_init
 integer(i4b),intent(out)              	  :: err                   ! error code
 character(*),intent(out)                 :: message               ! error message
 ! ---------------------------------------------------------------------------------------
 ! local variables: general
 character(LEN=256)                    :: cmessage              ! error message of downwind routine
 ! local variables: veg phenology
 logical(lgt)                          :: computeVegFluxFlag    ! flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
 real(dp)                              :: notUsed_canopyDepth   ! NOT USED: canopy depth (m)
 real(dp)                              :: notUsed_exposedVAI    ! NOT USED: exposed vegetation area index (m2 m-2)
 ! ---------------------------------------------------------------------------------------
 ! initialize error control
 err=0; message='summa4chm_runPhysics/'

 ! *******************************************************************************************
 ! *** initialize computeVegFlux (flag to indicate if we are computing fluxes over vegetation)
 ! *******************************************************************************************

 ! if computeVegFlux changes, then the number of state variables changes, and we need to reoranize the data structures
 if(modelTimeStep==1)then
    ! get vegetation phenology
    ! (compute the exposed LAI and SAI and whether veg is buried by snow)
    call vegPhenlgy(&
                    ! input/output: data structures
                    model_decisions,                & ! intent(in):    model decisions
                    typeStruct, 					& ! intent(in):    type of vegetation and soil
                    attrStruct, 					& ! intent(in):    spatial attributes
                    mparStruct, 					& ! intent(in):    model parameters
                    progStruct, 					& ! intent(in):    model prognostic variables for a local HRU
                    diagStruct, 					& ! intent(inout): model diagnostic variables for a local HRU
                    ! output
                    computeVegFluxFlag,             & ! intent(out): flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
                    notUsed_canopyDepth,            & ! intent(out): NOT USED: canopy depth (m)
                    notUsed_exposedVAI,             & ! intent(out): NOT USED: exposed vegetation area index (m2 m-2)
                    err,cmessage)                     ! intent(out): error control
    if(err/=0)then; message=trim(message)//trim(cmessage); return; endif

    ! save the flag for computing the vegetation fluxes
    if(computeVegFluxFlag)      computeVegFlux = yes
    if(.not.computeVegFluxFlag) computeVegFlux = no

    ! define the green vegetation fraction of the grid box (used to compute LAI)
    diagStruct%var(iLookDIAG%scalarGreenVegFraction)%dat(1) = greenVegFrac_monthly(timeStruct%var(iLookTIME%im))
 end if  ! if the first time step

 ! ****************************************************************************
 ! *** model simulation
 ! ****************************************************************************

 ! initialize the start of the physics
 call date_and_time(values=startPhysics)

 !----- run simulation for a single GRU ----------------------------------------
 ! ----- basin initialization --------------------------------------------------------------------------------------------

 ! initialize runoff variables
 bvarStruct%var(iLookBVAR%basin__SurfaceRunoff)%dat(1)    = 0._dp  ! surface runoff (m s-1)
 bvarStruct%var(iLookBVAR%basin__ColumnOutflow)%dat(1)    = 0._dp  ! outflow from all "outlet" HRUs (those with no downstream HRU)

 ! initialize baseflow variables
 bvarStruct%var(iLookBVAR%basin__AquiferRecharge)%dat(1)  = 0._dp ! recharge to the aquifer (m s-1)
 bvarStruct%var(iLookBVAR%basin__AquiferBaseflow)%dat(1)  = 0._dp ! baseflow from the aquifer (m s-1)
 bvarStruct%var(iLookBVAR%basin__AquiferTranspire)%dat(1) = 0._dp ! transpiration loss from the aquifer (m s-1)

 ! initialize total inflow for each layer in a soil column
 fluxStruct%var(iLookFLUX%mLayerColumnInflow)%dat(:) = 0._dp

  ! check errors
  call handle_err(err, cmessage)

 ! identify the end of the physics
 call date_and_time(values=endPhysics)

 ! aggregate the elapsed time for the physics
 elapsedPhysics = elapsedPhysics + elapsedSec(startPhysics, endPhysics)


 end subroutine summa4chm_runPhysics

end module summa4chm_modelRun
