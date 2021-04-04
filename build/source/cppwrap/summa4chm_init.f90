module summa4chm_init
! used to declare and allocate summa data structures and initialize model state to known values

! access missing values
USE globalData,only:integerMissing   ! missing integer
USE globalData,only:realMissing      ! missing double precision number

! named variables for run time options
USE globalData,only:iRunModeFull,iRunModeGRU,iRunModeHRU

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

! provide access to file paths
USE summaFileManager,only:SETTINGS_PATH                     ! define path to settings files (e.g., parameters, soil and veg. tables)
USE summaFileManager,only:STATE_PATH                        ! optional path to state/init. condition files (defaults to SETTINGS_PATH)
USE summaFileManager,only:MODEL_INITCOND                    ! name of model initial conditions file
USE summaFileManager,only:LOCAL_ATTRIBUTES                  ! name of model initial attributes file
USE summaFileManager,only:OUTPUT_PATH,OUTPUT_PREFIX         ! define output file

! safety: set private unless specified otherwise
implicit none
private
public::summa4chm_initialize
contains

 ! used to declare and allocate summa data structures and initialize model state to known values
 subroutine summa4chm_initialize(&
  								! statistics structures
  								forcStat, 				 & !  model forcing data
  								progStat,				 & !  model prognostic (state) variables
  								diagStat,				 & !  model diagnostic variables
  								fluxStat,				 & !  model fluxes
  								indxStat,				 & !  model indices
  								bvarStat,				 & !  basin-average variables
  								! primary data structures (scalars)
  								timeStruct,				 & !  model time data
  								forcStruct,				 & !  model forcing data
  								attrStruct,				 & !  local attributes for each HRU
  								typeStruct,				 & !  local classification of soil veg etc. for each HRU
  								idStruct,				 & ! 
								! primary data structures (variable length vectors)
  								indxStruct,				 & !  model indices
  								mparStruct,				 & !  model parameters
  								progStruct,				 & !  model prognostic (state) variables
  								diagStruct,				 & !  model diagnostic variables
  								fluxStruct,				 & !  model fluxes
  								! basin-average structures
  								bparStruct,				 & !  basin-average parameters
  								bvarStruct,				 & !  basin-average variables
  								! ancillary data structures
  								dparStruct,				 & !  default model parameters
  								! miscellaneous variables
  								summaFileManagerFile,	 & ! path/name of file defining directories and files
 								err, message)
 ! ---------------------------------------------------------------------------------------
 ! * desired modules
 ! ---------------------------------------------------------------------------------------
 ! data types
 USE nrtype                                                  ! variable types, etc.
 USE summa4chm_type, only:summa4chm_type_dec                        ! master summa data type
 ! subroutines and functions: initial priming
 USE summa4chm_util, only:getCommandArguments                    ! process command line arguments
 USE summaFileManager,only:summa_SetTimesDirsAndFiles       ! sets directories and filenames
 USE summa_globalData,only:summa_defineGlobalData            ! used to define global summa data structures
 USE time_utils_module,only:elapsedSec                       ! calculate the elapsed time
 ! subroutines and functions: read dimensions (NOTE: NetCDF)
 USE read_attrb_module,only:read_dimension                   ! module to read dimensions of GRU and HRU
 USE read_icond_module,only:read_icond_nlayers               ! module to read initial condition dimensions
 ! subroutines and functions: allocate space
 USE allocspace4chm_module,only:allocGlobal4chm              ! module to allocate space for global data structures
 USE allocspace_module,only:allocLocal                       ! module to allocate space for local data structures
 ! timing variables
 USE globalData,only:startInit,endInit                       ! date/time for the start and end of the initialization
 USE globalData,only:elapsedInit                             ! elapsed time for the initialization
 USE globalData,only:elapsedRead                             ! elapsed time for the data read
 USE globalData,only:elapsedWrite                            ! elapsed time for the stats/write
 USE globalData,only:elapsedPhysics                          ! elapsed time for the physics
 ! model time structures
 USE globalData,only:startTime                               ! start time
 USE globalData,only:finshTime                               ! end time
 USE globalData,only:refTime                                 ! reference time
 USE globalData,only:oldTime                                 ! time from previous step
 ! run time options
 USE globalData,only:startGRU                                ! index of the starting GRU for parallelization run
 USE globalData,only:checkHRU                                ! index of the HRU for a single HRU run
 USE globalData,only:iRunMode                                ! define the current running mode
 ! miscellaneous global data
 USE globalData,only:ncid                                    ! file id of netcdf output file
 USE globalData,only:gru_struc                               ! gru-hru mapping structures
 USE globalData,only:structInfo                              ! information on the data structures
 USE globalData,only:output_fileSuffix                       ! suffix for the output file
 ! ---------------------------------------------------------------------------------------
 ! * variables
 ! ---------------------------------------------------------------------------------------
 implicit none
 ! dummy variables
 ! statistics structures
 type(var_dlength),intent(inout)          :: forcStat                   !  model forcing data
 type(var_dlength),intent(inout)          :: progStat                   !  model prognostic (state) variables
 type(var_dlength),intent(inout)          :: diagStat                   !  model diagnostic variables
 type(var_dlength),intent(inout)          :: fluxStat                   !  model fluxes
 type(var_dlength),intent(inout)          :: indxStat                   !  model indices
 type(var_dlength),intent(inout)          :: bvarStat                   !  basin-average variabl
 ! define the primary data structures (scalars)
 type(var_i),intent(inout)                :: timeStruct                 !  model time data
 type(var_d),intent(inout)                :: forcStruct                 !  model forcing data
 type(var_d),intent(inout)                :: attrStruct                 !  local attributes for each HRU
 type(var_i),intent(inout)                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),intent(inout)               :: idStruct                   ! 
 ! define the primary data structures (variable length vectors)
 type(var_ilength),intent(inout)          :: indxStruct                 !  model indices
 type(var_dlength),intent(inout)          :: mparStruct                 !  model parameters
 type(var_dlength),intent(inout)          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),intent(inout)          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),intent(inout)          :: fluxStruct                 !  model fluxes
 ! define the basin-average structures
 type(var_d),intent(inout)                :: bparStruct                 !  basin-average parameters
 type(var_dlength),intent(inout)          :: bvarStruct                 !  basin-average variables
 ! define the ancillary data structures
 type(var_d),intent(inout)                :: dparStruct                 !  default model parameters
 character(len=256),intent(inout)		  :: summaFileManagerFile       ! path/name of file defining directories and files
 integer(i4b),intent(out)	              :: err                		! error code
 character(*),intent(out)	              :: message            		! error message
 ! local variables
 character(LEN=256)		                  :: cmessage           		! error message of downwind routine
 character(len=256)                    	  :: restartFile        		! restart file name
 integer(i4b)                             :: iStruct           			! looping variables
 ! ---------------------------------------------------------------------------------------
 ! initialize error control
 err=0; message='summa4chm_initialize/'

 ! initialize the start of the initialization
 call date_and_time(values=startInit)

 ! *****************************************************************************
 ! *** inital priming -- get command line arguments, identify files, etc.
 ! *****************************************************************************

 ! initialize the netcdf file id
 ncid(:) = integerMissing

 ! initialize the elapsed time for cumulative quantities
 elapsedRead=0._dp
 elapsedWrite=0._dp
 elapsedPhysics=0._dp

 ! get the command line arguments
 call getCommandArguments(summa1_struc,err,cmessage)
 if(err/=0)then; message=trim(message)//trim(cmessage); return; endif

 ! set directories and files -- summaFileManager used as command-line argument
 call summa_SetTimesDirsAndFiles(summaFileManagerFile,err,cmessage)
 if(err/=0)then; message=trim(message)//trim(cmessage); return; endif

 ! define global data (parameters, metadata)
 call summa_defineGlobalData(err, cmessage)
 if(err/=0)then; message=trim(message)//trim(cmessage); return; endif

 ! *****************************************************************************
 ! *** read the number of snow and soil layers
 ! *****************************************************************************
 ! set restart filename and read the number of snow and soil layers from the initial conditions (restart) file
 if(STATE_PATH == '') then
   restartFile = trim(SETTINGS_PATH)//trim(MODEL_INITCOND)
 else
    restartFile = trim(STATE_PATH)//trim(MODEL_INITCOND)
 endif
 call read_icond_nlayers(trim(restartFile),1,indx_meta,err,cmessage)
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
   case('time'); call allocGlobal4chm(time_meta,  timeStruct,  err, cmessage)   ! model forcing data
   case('forc'); call allocGlobal4chm(forc_meta,  forcStruct,  err, cmessage)   ! model forcing data
   case('attr'); call allocGlobal4chm(attr_meta,  attrStruct,  err, cmessage)   ! local attributes for each HRU
   case('type'); call allocGlobal4chm(type_meta,  typeStruct,  err, cmessage)   ! local classification of soil veg etc. for each HRU
   case('id'  ); call allocGlobal4chm(id_meta,    idStruct,    err, message)    ! local values of hru and gru IDs
   case('mpar'); call allocGlobal4chm(mpar_meta,  mparStruct,  err, cmessage)   ! model parameters
   case('indx'); call allocGlobal4chm(indx_meta,  indxStruct,  err, cmessage)   ! model variables
   case('prog'); call allocGlobal4chm(prog_meta,  progStruct,  err, cmessage)   ! model prognostic (state) variables
   case('diag'); call allocGlobal4chm(diag_meta,  diagStruct,  err, cmessage)   ! model diagnostic variables
   case('flux'); call allocGlobal4chm(flux_meta,  fluxStruct,  err, cmessage)   ! model fluxes
   case('bpar'); call allocGlobal4chm(bpar_meta,  bparStruct,  err, cmessage)   ! basin-average parameters
   case('bvar'); call allocGlobal4chm(bvar_meta,  bvarStruct,  err, cmessage)   ! basin-average variables
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
 call allocGlobal4chm(mpar_meta,dparStruct,err,cmessage)   ! default model parameters
 if(err/=0)then
  message=trim(message)//trim(cmessage)//' [problem allocating dparStruct]'
  return
 endif

 ! *****************************************************************************
 ! *** allocate space for output statistics data structures
 ! *****************************************************************************

 ! loop through data structures
 do iStruct=1,size(structInfo)

  ! allocate space
  select case(trim(structInfo(iStruct)%structName))
   case('forc'); call allocGlobal4chm(statForc_meta(:)%var_info,forcStat,err,cmessage)   ! model forcing data
   case('prog'); call allocGlobal4chm(statProg_meta(:)%var_info,progStat,err,cmessage)   ! model prognostic (state) variables
   case('diag'); call allocGlobal4chm(statDiag_meta(:)%var_info,diagStat,err,cmessage)   ! model diagnostic variables
   case('flux'); call allocGlobal4chm(statFlux_meta(:)%var_info,fluxStat,err,cmessage)   ! model fluxes
   case('indx'); call allocGlobal4chm(statIndx_meta(:)%var_info,indxStat,err,cmessage)   ! index vars
   case('bvar'); call allocGlobal4chm(statBvar_meta(:)%var_info,bvarStat,err,cmessage)   ! basin-average variables
   case default; cycle
  end select

  ! check errors
  if(err/=0)then
   message=trim(message)//trim(cmessage)//'[statistics for =  '//trim(structInfo(iStruct)%structName)//']'
   return
  endif

 end do ! iStruct

 ! identify the end of the initialization
 call date_and_time(values=endInit)

 ! aggregate the elapsed time for the initialization
 elapsedInit = elapsedSec(startInit, endInit)

 end subroutine summa4chm_initialize

end module summa4chm_init
