
module summa4chm_init
! used to declare and allocate summa data structures and initialize model state to known values

! access missing values
USE globalData,only:integerMissing   ! missing integer
USE globalData,only:realMissing      ! missing double precision number


! metadata structures
USE globalData,only:time_meta,forc_meta,attr_meta,type_meta ! metadata structures
USE globalData,only:prog_meta,diag_meta,flux_meta,id_meta   ! metadata structures
USE globalData,only:mpar_meta,indx_meta                     ! metadata structures
USE globalData,only:bpar_meta,bvar_meta                     ! metadata structures
USE globalData,only:averageFlux_meta                        ! metadata for time-step average fluxes

! statistics metadata structures
USE globalData,only:statForc_meta                           ! child metadata for stats
USE globalData,only:statProg_meta                           ! child metadata for stats
USE globalData,only:statDiag_meta                           ! child metadata for stats
USE globalData,only:statFlux_meta                           ! child metadata for stats
USE globalData,only:statIndx_meta                           ! child metadata for stats
USE globalData,only:statBvar_meta                           ! child metadata for stats


! safety: set private unless specified otherwise
implicit none
private
public::summa_initialize
contains

 ! used to declare and allocate summa data structures and initialize model state to known values
 subroutine summa_initialize(summa1_struc, err, message)
 ! ---------------------------------------------------------------------------------------
 ! * desired modules
 ! ---------------------------------------------------------------------------------------
 ! data types
 USE nrtype                                                  ! variable types, etc.
 USE summa_type, only:summa1_type_dec                        ! master summa data type
 ! subroutines and functions: initial priming
 USE summa_globalData,only:summa_defineGlobalData            ! used to define global summa data structures
 ! subroutines and functions: allocate space
 USE allocspace_module,only:allocGlobal                      ! module to allocate space for global data structures
 USE allocspace_module,only:allocLocal                       ! module to allocate space for local data structures
 USE globalData,only:structInfo                              ! information on the data structures
 ! ---------------------------------------------------------------------------------------
 ! * variables
 ! ---------------------------------------------------------------------------------------
 implicit none
 ! dummy variables
 type(summa1_type_dec),intent(inout)   :: summa1_struc       ! master summa data structure
 integer(i4b),intent(out)              :: err                ! error code
 character(*),intent(out)              :: message            ! error message
 ! local variables
 character(LEN=256)                    :: cmessage           ! error message of downwind routine
 integer(i4b)                          :: iStruct,iGRU       ! looping variables
 ! ---------------------------------------------------------------------------------------
 ! associate to elements in the data structure
 summaVars: associate(&

  ! statistics structures
  forcStat             => summa1_struc%forcStat            , & ! x%gru(:)%hru(:)%var(:)%dat -- model forcing data
  progStat             => summa1_struc%progStat            , & ! x%gru(:)%hru(:)%var(:)%dat -- model prognostic (state) variables
  diagStat             => summa1_struc%diagStat            , & ! x%gru(:)%hru(:)%var(:)%dat -- model diagnostic variables
  fluxStat             => summa1_struc%fluxStat            , & ! x%gru(:)%hru(:)%var(:)%dat -- model fluxes
  indxStat             => summa1_struc%indxStat            , & ! x%gru(:)%hru(:)%var(:)%dat -- model indices
  bvarStat             => summa1_struc%bvarStat            , & ! x%gru(:)%var(:)%dat        -- basin-average variables

  ! primary data structures (scalars)
  timeStruct           => summa1_struc%timeStruct          , & ! x%var(:)                   -- model time data
  forcStruct           => summa1_struc%forcStruct          , & ! x%gru(:)%hru(:)%var(:)     -- model forcing data
  attrStruct           => summa1_struc%attrStruct          , & ! x%gru(:)%hru(:)%var(:)     -- local attributes for each HRU
  typeStruct           => summa1_struc%typeStruct          , & ! x%gru(:)%hru(:)%var(:)     -- local classification of soil veg etc. for each HRU
  idStruct             => summa1_struc%idStruct            , & ! x%gru(:)%hru(:)%var(:)     --

  ! primary data structures (variable length vectors)
  indxStruct           => summa1_struc%indxStruct          , & ! x%gru(:)%hru(:)%var(:)%dat -- model indices
  mparStruct           => summa1_struc%mparStruct          , & ! x%gru(:)%hru(:)%var(:)%dat -- model parameters
  progStruct           => summa1_struc%progStruct          , & ! x%gru(:)%hru(:)%var(:)%dat -- model prognostic (state) variables
  diagStruct           => summa1_struc%diagStruct          , & ! x%gru(:)%hru(:)%var(:)%dat -- model diagnostic variables
  fluxStruct           => summa1_struc%fluxStruct          , & ! x%gru(:)%hru(:)%var(:)%dat -- model fluxes

  ! basin-average structures
  bparStruct           => summa1_struc%bparStruct          , & ! x%gru(:)%var(:)            -- basin-average parameters
  bvarStruct           => summa1_struc%bvarStruct          , & ! x%gru(:)%var(:)%dat        -- basin-average variables

  ! ancillary data structures
  dparStruct           => summa1_struc%dparStruct          , & ! x%gru(:)%hru(:)%var(:)     -- default model parameters

  ! run time variables
  computeVegFlux       => summa1_struc%computeVegFlux      , & ! flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
  dt_init              => summa1_struc%dt_init             , & ! used to initialize the length of the sub-step for each HRU
  upArea               => summa1_struc%upArea              , & ! area upslope of each HRU

  ! miscellaneous variables
  summa1open           => summa1_struc%summa1open          , & ! flag to define if the summa file is open??
  numout               => summa1_struc%numout              , & ! number of output variables??
  ts                   => summa1_struc%ts                  , & ! model time step ??
  nGRU                 => summa1_struc%nGRU                , & ! number of grouped response units
  nHRU                 => summa1_struc%nHRU                , & ! number of global hydrologic response units
  hruCount             => summa1_struc%hruCount            , & ! number of local hydrologic response units
  greenVegFrac_monthly => summa1_struc%greenVegFrac_monthly, & ! fraction of green vegetation in each month (0-1)
  summaFileManagerFile => summa1_struc%summaFileManagerFile  & ! path/name of file defining directories and files

 ) ! assignment to variables in the data structures
 ! ---------------------------------------------------------------------------------------
 ! initialize error control
 err=0; message='summa_initialize/'

 ! define global data (parameters, metadata)
 call summa_defineGlobalData(err, cmessage)
 if(err/=0)then; message=trim(message)//trim(cmessage); return; endif


 ! *****************************************************************************
 ! *** allocate space for data structures
 ! *****************************************************************************

 ! allocate time structures
 do iStruct=1,4
  select case(iStruct)
   case(1); call allocLocal(time_meta, startTime, err=err, message=cmessage)  ! start time for the model simulation
   case(2); call allocLocal(time_meta, finshTime, err=err, message=cmessage)  ! end time for the model simulation
   case(3); call allocLocal(time_meta, refTime,   err=err, message=cmessage)  ! reference time for the model simulation
   case(4); call allocLocal(time_meta, oldTime,   err=err, message=cmessage)  ! time from the previous step
  end select
  if(err/=0)then; message=trim(message)//trim(cmessage); return; endif
 end do  ! looping through time structures

 ! allocate other data structures
 do iStruct=1,size(structInfo)
  ! allocate space
  select case(trim(structInfo(iStruct)%structName))
   case('time'); call allocGlobal(time_meta,  timeStruct,  err, cmessage)   ! model forcing data
   case('forc'); call allocGlobal(forc_meta,  forcStruct,  err, cmessage)   ! model forcing data
   case('attr'); call allocGlobal(attr_meta,  attrStruct,  err, cmessage)   ! local attributes for each HRU
   case('type'); call allocGlobal(type_meta,  typeStruct,  err, cmessage)   ! local classification of soil veg etc. for each HRU
   case('id'  ); call allocGlobal(id_meta,    idStruct,    err, message)    ! local values of hru and gru IDs
   case('mpar'); call allocGlobal(mpar_meta,  mparStruct,  err, cmessage)   ! model parameters
   case('indx'); call allocGlobal(indx_meta,  indxStruct,  err, cmessage)   ! model variables
   case('prog'); call allocGlobal(prog_meta,  progStruct,  err, cmessage)   ! model prognostic (state) variables
   case('diag'); call allocGlobal(diag_meta,  diagStruct,  err, cmessage)   ! model diagnostic variables
   case('flux'); call allocGlobal(flux_meta,  fluxStruct,  err, cmessage)   ! model fluxes
   case('bpar'); call allocGlobal(bpar_meta,  bparStruct,  err, cmessage)   ! basin-average parameters
   case('bvar'); call allocGlobal(bvar_meta,  bvarStruct,  err, cmessage)   ! basin-average variables
   case('deriv'); cycle
   case default; err=20; message='unable to find structure name: '//trim(structInfo(iStruct)%structName)
  end select
  ! check errors
  if(err/=0)then
   message=trim(message)//trim(cmessage)//'[structure =  '//trim(structInfo(iStruct)%structName)//']'
   return
  endif
 end do  ! looping through data structures

 ! allocate space for default model parameters
 ! NOTE: This is done here, rather than in the loop above, because dpar is not one of the "standard" data structures
 call allocGlobal(mpar_meta,dparStruct,err,cmessage)   ! default model parameters
 if(err/=0)then
  message=trim(message)//trim(cmessage)//' [problem allocating dparStruct]'
  return
 endif

 ! allocate space for the time step and computeVegFlux flags (recycled for each GRU for subsequent model calls)
 allocate(dt_init%gru(nGRU),upArea%gru(nGRU),computeVegFlux%gru(nGRU),stat=err)
 if(err/=0)then
  message=trim(message)//'problem allocating space for dt_init, upArea, or computeVegFlux [GRU]'
  return
 endif

 ! allocate space for the HRUs
 do iGRU=1,nGRU
  hruCount = gru_struc(iGRU)%hruCount  ! gru_struc populated in "read_dimension"
  allocate(dt_init%gru(iGRU)%hru(hruCount),upArea%gru(iGRU)%hru(hruCount),computeVegFlux%gru(iGRU)%hru(hruCount),stat=err)
  if(err/=0)then
   message='problem allocating space for dt_init, upArea, or computeVegFlux [HRU]'
   return
  endif
 end do

 ! *****************************************************************************
 ! *** allocate space for output statistics data structures
 ! *****************************************************************************

 ! loop through data structures
 do iStruct=1,size(structInfo)

  ! allocate space
  select case(trim(structInfo(iStruct)%structName))
   case('forc'); call allocGlobal(statForc_meta(:)%var_info,forcStat,err,cmessage)   ! model forcing data
   case('prog'); call allocGlobal(statProg_meta(:)%var_info,progStat,err,cmessage)   ! model prognostic (state) variables
   case('diag'); call allocGlobal(statDiag_meta(:)%var_info,diagStat,err,cmessage)   ! model diagnostic variables
   case('flux'); call allocGlobal(statFlux_meta(:)%var_info,fluxStat,err,cmessage)   ! model fluxes
   case('indx'); call allocGlobal(statIndx_meta(:)%var_info,indxStat,err,cmessage)   ! index vars
   case('bvar'); call allocGlobal(statBvar_meta(:)%var_info,bvarStat,err,cmessage)   ! basin-average variables
   case default; cycle
  end select

  ! check errors
  if(err/=0)then
   message=trim(message)//trim(cmessage)//'[statistics for =  '//trim(structInfo(iStruct)%structName)//']'
   return
  endif

 end do ! iStruct

 ! *****************************************************************************
 ! *** define the suffix for the model output file
 ! *****************************************************************************

 ! set up the output file names as: OUTPUT_PREFIX'_'output_fileSuffix'_'startGRU-endGRU_outfreq.nc or OUTPUT_PREFIX'_'output_fileSuffix'_'HRU_outfreq.nc;
 if (output_fileSuffix(1:1) /= '_') output_fileSuffix='_'//trim(output_fileSuffix)   ! separate output_fileSuffix from others by underscores
 if (output_fileSuffix(len_trim(output_fileSuffix):len_trim(output_fileSuffix)) == '_') output_fileSuffix(len_trim(output_fileSuffix):len_trim(output_fileSuffix)) = ' '
 select case (iRunMode)
  case(iRunModeGRU)
   ! left zero padding for startGRU and endGRU
   write(fmtGruOutput,"(i0)") ceiling(log10(real(fileGRU)+0.1))                      ! maximum width of startGRU and endGRU
   fmtGruOutput = "i"//trim(fmtGruOutput)//"."//trim(fmtGruOutput)                   ! construct the format string for startGRU and endGRU
   fmtGruOutput = "('_G',"//trim(fmtGruOutput)//",'-',"//trim(fmtGruOutput)//")"
   write(output_fileSuffix((len_trim(output_fileSuffix)+1):len(output_fileSuffix)),fmtGruOutput) startGRU,startGRU+nGRU-1
  case(iRunModeHRU)
   write(output_fileSuffix((len_trim(output_fileSuffix)+1):len(output_fileSuffix)),"('_H',i0)") checkHRU
 end select

 ! identify the end of the initialization
 call date_and_time(values=endInit)

 ! aggregate the elapsed time for the initialization
 elapsedInit = elapsedSec(startInit, endInit)

 ! end associate statements
 end associate summaVars

 end subroutine summa_initialize

end module summa4chm_init
