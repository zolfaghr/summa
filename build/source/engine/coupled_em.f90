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

module coupled_em_module

! numerical recipes data types
USE nrtype

! physical constants
USE multiconst,only:&
                    Tfreeze,      & ! temperature at freezing              (K)
                    LH_fus,       & ! latent heat of fusion                (J kg-1)
                    LH_sub,       & ! latent heat of sublimation           (J kg-1)
                    iden_ice,     & ! intrinsic density of ice             (kg m-3)
                    iden_water      ! intrinsic density of liquid water    (kg m-3)

! data types
USE data_types,only:&
                    var_i,               & ! x%var(:)            (i4b)
                    var_d,               & ! x%var(:)            (dp)
                    var_ilength,         & ! x%var(:)%dat        (i4b)
                    var_dlength            ! x%var(:)%dat        (dp)

! named variables for parent structures
USE var_lookup,only:iLookDECISIONS         ! named variables for elements of the decision structure
USE var_lookup,only:iLookPROG              ! named variables for structure elements
USE var_lookup,only:iLookDIAG              ! named variables for structure elements
USE var_lookup,only:iLookFLUX              ! named variables for structure elements
USE var_lookup,only:iLookPARAM             ! named variables for structure elements
USE var_lookup,only:iLookINDEX             ! named variables for structure elements
USE globalData,only:iname_snow             ! named variables for snow
USE globalData,only:iname_soil             ! named variables for soil

! named variables for child structures
USE var_lookup,only:childFLUX_MEAN

! metadata
USE globalData,only:indx_meta              ! metadata on the model index variables
USE globalData,only:diag_meta              ! metadata on the model diagnostic variables
USE globalData,only:prog_meta              ! metadata on the model prognostic variables
USE globalData,only:averageFlux_meta       ! metadata on the timestep-average model flux structure

! global data
USE globalData,only:data_step              ! time step of forcing data (s)
USE globalData,only:model_decisions        ! model decision structure
USE globalData,only:globalPrintFlag        ! the global print flag

! look-up values for the numerical method
USE mDecisions_module,only:         &
 iterative,                         &      ! iterative
 nonIterative,                      &      ! non-iterative
 iterSurfEnergyBal                         ! iterate only on the surface energy balance

! look-up values for the maximum interception capacity
USE mDecisions_module,only:         &
                      stickySnow,   &      ! maximum interception capacity an increasing function of temerature
                      lightSnow            ! maximum interception capacity an inverse function of new snow density

! look-up values for the groundwater parameterization
USE mDecisions_module,only:         &
                      qbaseTopmodel,&      ! TOPMODEL-ish baseflow parameterization
                      bigBucket    ,&      ! a big bucket (lumped aquifer model)
                      noExplicit           ! no explicit groundwater parameterization

! look-up values for the spatial representation of groundwater
USE mDecisions_module,only:         &
                      localColumn  ,&      ! separate groundwater representation in each local soil column
                      singleBasin          ! single groundwater store over the entire basin

! privacy
implicit none
private
public::coupled_em
! algorithmic parameters
real(dp),parameter     :: valueMissing=-9999._dp  ! missing value, used when diagnostic or state variables are undefined
real(dp),parameter     :: verySmall=1.e-6_dp   ! used as an additive constant to check if substantial difference among real numbers
real(dp),parameter     :: mpe=1.e-6_dp         ! prevents overflow error if division by zero
real(dp),parameter     :: dx=1.e-6_dp          ! finite difference increment
contains


 ! ************************************************************************************************
 ! public subroutine coupled_em: run the coupled energy-mass model for one timestep
 ! ************************************************************************************************
 subroutine coupled_em(&
                       ! model control
                       hruId,             & ! intent(in):    hruId
                       dt_init,           & ! intent(inout): used to initialize the size of the sub-step
                       computeVegFlux,    & ! intent(inout): flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
                       ! data structures (input)
                       type_data,         & ! intent(in):    local classification of soil veg etc. for each HRU
                       attr_data,         & ! intent(in):    local attributes for each HRU
                       forc_data,         & ! intent(in):    model forcing data
                       mpar_data,         & ! intent(in):    model parameters
                       bvar_data,         & ! intent(in):    basin-average variables
                       ! data structures (input-output)
                       indx_data,         & ! intent(inout): model indices
                       prog_data,         & ! intent(inout): prognostic variables for a local HRU
                       diag_data,         & ! intent(inout): diagnostic variables for a local HRU
                       flux_data,         & ! intent(inout): model fluxes for a local HRU
                       ! error control
                       err,message)         ! intent(out):   error control
 ! structure allocations
 USE allocspace_module,only:allocLocal      ! allocate local data structures
 USE allocspace_module,only:resizeData      ! clone a data structure
 ! preliminary subroutines
 USE vegPhenlgy_module,only:vegPhenlgy      ! compute vegetation phenology
 USE vegNrgFlux_module,only:wettedFrac      ! compute wetted fraction of the canopy (used in sw radiation fluxes)
 USE snowAlbedo_module,only:snowAlbedo      ! compute snow albedo
 USE vegSWavRad_module,only:vegSWavRad      ! compute canopy sw radiation fluxes
 USE canopySnow_module,only:canopySnow      ! compute interception and unloading of snow from the vegetation canopy
 USE volicePack_module,only:newsnwfall      ! compute change in the top snow layer due to throughfall and unloading
 USE volicePack_module,only:volicePack      ! merge and sub-divide snow layers, if necessary
 USE diagn_evar_module,only:diagn_evar      ! compute diagnostic energy variables -- thermal conductivity and heat capacity
 ! the model solver
 USE indexState_module,only:indexState      ! define indices for all model state variables and layers
 USE opSplittin_module,only:opSplittin      ! solve the system of thermodynamic and hydrology equations for a given substep
 ! additional subroutines
 USE tempAdjust_module,only:tempAdjust      ! adjust snow temperature associated with new snowfall
 USE snwDensify_module,only:snwDensify      ! snow densification (compaction and cavitation)
 USE var_derive_module,only:calcHeight      ! module to calculate height at layer interfaces and layer mid-point
 ! look-up values for the numerical method
 USE mDecisions_module,only:         &
  iterative,                         &      ! iterative
  nonIterative,                      &      ! non-iterative
  iterSurfEnergyBal                         ! iterate only on the surface energy balance
 ! look-up values for the maximum interception capacity
 USE mDecisions_module,only:          &
                       stickySnow,    &      ! maximum interception capacity an increasing function of temerature
                       lightSnow             ! maximum interception capacity an inverse function of new snow density
 implicit none
 ! model control
 integer(8),intent(in)                :: hruId                  ! hruId
 real(dp),intent(inout)               :: dt_init                ! used to initialize the size of the sub-step
 logical(lgt),intent(inout)           :: computeVegFlux         ! flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
 ! data structures (input)
 type(var_i),intent(in)               :: type_data              ! type of vegetation and soil
 type(var_d),intent(in)               :: attr_data              ! spatial attributes
 type(var_d),intent(in)               :: forc_data              ! model forcing data
 type(var_dlength),intent(in)         :: mpar_data              ! model parameters
 type(var_dlength),intent(in)         :: bvar_data              ! basin-average model variables
 ! data structures (input-output)
 type(var_ilength),intent(inout)      :: indx_data              ! state vector geometry
 type(var_dlength),intent(inout)      :: prog_data              ! prognostic variables for a local HRU
 type(var_dlength),intent(inout)      :: diag_data              ! diagnostic variables for a local HRU
 type(var_dlength),intent(inout)      :: flux_data              ! model fluxes for a local HRU
 ! error control
 integer(i4b),intent(out)             :: err                    ! error code
 character(*),intent(out)             :: message                ! error message
 ! =====================================================================================================================================================
 ! =====================================================================================================================================================
 ! local variables
 character(len=256)                   :: cmessage               ! error message
 integer(i4b)                         :: nSnow                  ! number of snow layers
 integer(i4b)                         :: nSoil                  ! number of soil layers
 integer(i4b)                         :: nLayers                ! total number of layers
 integer(i4b)                         :: nState                 ! total number of state variables
 real(dp)                             :: dtSave                 ! length of last input model sub-step (seconds)
 real(dp)                             :: dt_sub                 ! length of model sub-step (seconds)
 real(dp)                             :: dt_wght                ! weight applied to model sub-step (dt_sub/data_step)
 real(dp)                             :: dt_solv                ! seconds in the data step that have been completed
 real(dp)                             :: dtMultiplier           ! time step multiplier (-) based on what happenned in "opSplittin"
 real(dp)                             :: minstep,maxstep        ! minimum and maximum time step length (seconds)
 integer(i4b)                         :: nsub                   ! number of substeps
 logical(lgt)                         :: computeVegFluxOld      ! flag to indicate if we are computing fluxes over vegetation on the previous sub step
 logical(lgt)                         :: includeAquifer         ! flag to denote that an aquifer is included
 logical(lgt)                         :: modifiedLayers         ! flag to denote that snow layers were modified
 logical(lgt)                         :: modifiedVegState       ! flag to denote that vegetation states were modified
 type(var_dlength)                    :: flux_mean              ! timestep-average model fluxes for a local HRU
 integer(i4b)                         :: nLayersRoots           ! number of soil layers that contain roots
 real(dp)                             :: exposedVAI             ! exposed vegetation area index
 real(dp)                             :: dCanopyWetFraction_dWat ! derivative in wetted fraction w.r.t. canopy total water (kg-1 m2)
 real(dp)                             :: dCanopyWetFraction_dT   ! derivative in wetted fraction w.r.t. canopy temperature (K-1)
 real(dp),parameter                   :: varNotUsed1=-9999._dp  ! variables used to calculate derivatives (not needed here)
 real(dp),parameter                   :: varNotUsed2=-9999._dp  ! variables used to calculate derivatives (not needed here)
 integer(i4b)                         :: iSnow                  ! index of snow layers
 integer(i4b)                         :: iLayer                 ! index of model layers
 real(dp)                             :: massLiquid             ! mass liquid water (kg m-2)
 real(dp)                             :: superflousSub          ! superflous sublimation (kg m-2 s-1)
 real(dp)                             :: superflousNrg          ! superflous energy that cannot be used for sublimation (W m-2 [J m-2 s-1])
 integer(i4b)                         :: ixSolution             ! solution method used by opSplitting
 logical(lgt)                         :: firstSubStep           ! flag to denote if the first time step
 logical(lgt)                         :: stepFailure            ! flag to denote the need to reduce length of the coupled step and try again
 logical(lgt)                         :: tooMuchMelt            ! flag to denote that there was too much melt in a given time step
 logical(lgt)                         :: doLayerMerge           ! flag to denote the need to merge snow layers
 logical(lgt)                         :: pauseFlag              ! flag to pause execution
 logical(lgt),parameter               :: backwardsCompatibility=.true.  ! flag to denote a desire to ensure backwards compatibility with previous branches.
 type(var_ilength)                    :: indx_temp              ! temporary model index variables
 type(var_dlength)                    :: prog_temp              ! temporary model prognostic variables
 type(var_dlength)                    :: diag_temp              ! temporary model diagnostic variables
 ! check SWE
 real(dp)                             :: oldSWE                 ! SWE at the start of the substep
 real(dp)                             :: newSWE                 ! SWE at the end of the substep
 real(dp)                             :: delSWE                 ! change in SWE over the subtep
 real(dp)                             :: effRainfall            ! effective rainfall (kg m-2 s-1)
 real(dp)                             :: effSnowfall            ! effective snowfall (kg m-2 s-1)
 real(dp)                             :: sfcMeltPond            ! surface melt pond (kg m-2)
 real(dp)                             :: massBalance            ! mass balance error (kg m-2)
 ! balance checks
 integer(i4b)                         :: iVar                   ! loop through model variables
 real(dp)                             :: totalSoilCompress      ! total soil compression (kg m-2)
 real(dp)                             :: scalarCanopyWatBalError ! water balance error for the vegetation canopy (kg m-2)
 real(dp)                             :: scalarSoilWatBalError  ! water balance error (kg m-2)
 real(dp)                             :: scalarInitCanopyLiq    ! initial liquid water on the vegetation canopy (kg m-2)
 real(dp)                             :: scalarInitCanopyIce    ! initial ice          on the vegetation canopy (kg m-2)
 real(dp)                             :: balanceCanopyWater0    ! total water stored in the vegetation canopy at the start of the step (kg m-2)
 real(dp)                             :: balanceCanopyWater1    ! total water stored in the vegetation canopy at the end of the step (kg m-2)
 real(dp)                             :: balanceSoilWater0      ! total soil storage at the start of the step (kg m-2)
 real(dp)                             :: balanceSoilWater1      ! total soil storage at the end of the step (kg m-2)
 real(dp)                             :: balanceSoilInflux      ! input to the soil zone
 real(dp)                             :: balanceSoilBaseflow    ! output from the soil zone
 real(dp)                             :: balanceSoilDrainage    ! output from the soil zone
 real(dp)                             :: balanceSoilET          ! output from the soil zone
 real(dp)                             :: balanceAquifer0        ! total aquifer storage at the start of the step (kg m-2)
 real(dp)                             :: balanceAquifer1        ! total aquifer storage at the end of the step (kg m-2)
 ! test balance checks
 logical(lgt), parameter              :: printBalance=.false.   ! flag to print the balance checks
 real(dp), allocatable                :: liqSnowInit(:)         ! volumetric liquid water conetnt of snow at the start of the time step
 real(dp), allocatable                :: liqSoilInit(:)         ! soil moisture at the start of the time step
 integer :: i,j
 ! ----------------------------------------------------------------------------------------------------------------------------------------------
 ! initialize error control
 err=0; message="coupled_em/"

		
		
 
        do i=1,size(indx_data%var)
        	do j=1,size(indx_data%var(i)%dat)
		  		indx_data%var(i)%dat(j) = indx_data%var(i)%dat(j) * 100
		  	end do
		end do
		
        do i=1,size(diag_data%var)
        	do j=1,size(diag_data%var(i)%dat)
		  		diag_data%var(i)%dat(j) = diag_data%var(i)%dat(j) * 0.01
		  	end do
		end do

 end subroutine coupled_em


 ! *********************************************************************************************************
 ! private subroutine implctMelt: compute melt of the "snow without a layer"
 ! *********************************************************************************************************
 subroutine implctMelt(&
                       ! input/output: integrated snowpack properties
                       scalarSWE,         & ! intent(inout): snow water equivalent (kg m-2)
                       scalarSnowDepth,   & ! intent(inout): snow depth (m)
                       scalarSfcMeltPond, & ! intent(inout): surface melt pond (kg m-2)
                       ! input/output: properties of the upper-most soil layer
                       soilTemp,          & ! intent(inout): surface layer temperature (K)
                       soilDepth,         & ! intent(inout): surface layer depth (m)
                       soilHeatcap,       & ! intent(inout): surface layer volumetric heat capacity (J m-3 K-1)
                       ! output: error control
                       err,message        ) ! intent(out): error control
 implicit none
 ! input/output: integrated snowpack properties
 real(dp),intent(inout)    :: scalarSWE          ! snow water equivalent (kg m-2)
 real(dp),intent(inout)    :: scalarSnowDepth    ! snow depth (m)
 real(dp),intent(inout)    :: scalarSfcMeltPond  ! surface melt pond (kg m-2)
 ! input/output: properties of the upper-most soil layer
 real(dp),intent(inout)    :: soilTemp           ! surface layer temperature (K)
 real(dp),intent(inout)    :: soilDepth          ! surface layer depth (m)
 real(dp),intent(inout)    :: soilHeatcap        ! surface layer volumetric heat capacity (J m-3 K-1)
 ! output: error control
 integer(i4b),intent(out)  :: err                ! error code
 character(*),intent(out)  :: message            ! error message
 ! local variables
 real(dp)                  :: nrgRequired        ! energy required to melt all the snow (J m-2)
 real(dp)                  :: nrgAvailable       ! energy available to melt the snow (J m-2)
 real(dp)                  :: snwDensity         ! snow density (kg m-3)
 ! initialize error control
 err=0; message='implctMelt/'

 if(scalarSWE > 0._dp)then
  ! only melt if temperature of the top soil layer is greater than Tfreeze
  if(soilTemp > Tfreeze)then
   ! compute the energy required to melt all the snow (J m-2)
   nrgRequired     = scalarSWE*LH_fus
   ! compute the energy available to melt the snow (J m-2)
   nrgAvailable    = soilHeatcap*(soilTemp - Tfreeze)*soilDepth
   ! compute the snow density (not saved)
   snwDensity      = scalarSWE/scalarSnowDepth
   ! compute the amount of melt, and update SWE (kg m-2)
   if(nrgAvailable > nrgRequired)then
    scalarSfcMeltPond  = scalarSWE
    scalarSWE          = 0._dp
   else
    scalarSfcMeltPond  = nrgAvailable/LH_fus
    scalarSWE          = scalarSWE - scalarSfcMeltPond
   end if
   ! update depth
   scalarSnowDepth = scalarSWE/snwDensity
   ! update temperature of the top soil layer (K)
   soilTemp =  soilTemp - (LH_fus*scalarSfcMeltPond/soilDepth)/soilHeatcap
  else  ! melt is zero if the temperature of the top soil layer is less than Tfreeze
   scalarSfcMeltPond = 0._dp  ! kg m-2
  end if ! (if the temperature of the top soil layer is greater than Tfreeze)
 else  ! melt is zero if the "snow without a layer" does not exist
  scalarSfcMeltPond = 0._dp  ! kg m-2
 end if ! (if the "snow without a layer" exists)

 end subroutine implctMelt

end module coupled_em_module
