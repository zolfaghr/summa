

module cppwrap_summa


  !======= Inclusions ===========
  use, intrinsic :: iso_c_binding
  USE nrtype
  use data_types

  ! privacy
  implicit none
  public::Initialize
  public::SetupParam
  public::Restart
  public::Forcing
  public::RunPhysics


contains

  ! **********************************************************************************************************
  ! public subroutine Initialize: 
  ! **********************************************************************************************************
  subroutine Initialize(&
    					! statistics structures
  						handle_forcStat, 				 & !  model forcing data
  						handle_progStat,				 & !  model prognostic (state) variables
  						handle_diagStat,				 & !  model diagnostic variables
  						handle_fluxStat,				 & !  model fluxes
  						handle_indxStat,				 & !  model indices
  						handle_bvarStat,				 & !  basin-average variables
  						! primary data structures (scalars)
  						handle_timeStruct,				 & !  model time data
  						handle_forcStruct,				 & !  model forcing data
  						handle_attrStruct,				 & !  local attributes for each HRU
  						handle_typeStruct,				 & !  local classification of soil veg etc. for each HRU
  						handle_idStruct,				 & ! 
						! primary data structures (variable length vectors)
  						handle_indxStruct,				 & !  model indices
  						handle_mparStruct,				 & !  model parameters
  						handle_progStruct,				 & !  model prognostic (state) variables
  						handle_diagStruct,				 & !  model diagnostic variables
  						handle_fluxStruct,				 & !  model fluxes
  						! basin-average structures
  						handle_bparStruct,				 & !  basin-average parameters
  						handle_bvarStruct,				 & !  basin-average variables
  						! ancillary data structures
  						handle_dparStruct,				 & !  default model parameters
  						! miscellaneous variables
  					    file_manager_path,			     & ! path of file defining directories and files)
  						err) bind(C,name='Initialize')
  
  use summa4chm_init,only:summa4chm_initialize           
  
  implicit none
  ! calling variables
  
  ! statistics structures
  type(c_ptr), intent(in), value    :: 	handle_forcStat !  model forcing data
  type(c_ptr), intent(in), value    ::	handle_progStat !  model prognostic (state) variables
  type(c_ptr), intent(in), value    ::	handle_diagStat !  model diagnostic variables
  type(c_ptr), intent(in), value    ::	handle_fluxStat !  model fluxes
  type(c_ptr), intent(in), value    ::	handle_indxStat !  model indices
  type(c_ptr), intent(in), value    ::	handle_bvarStat !  basin-average variables
  ! primary data structures (scalars)
  type(c_ptr), intent(in), value    ::	handle_timeStruct !  model time data
  type(c_ptr), intent(in), value    ::	handle_forcStruct !  model forcing data
  type(c_ptr), intent(in), value    ::	handle_attrStruct !  local attributes for each HRU
  type(c_ptr), intent(in), value    ::	handle_typeStruct !  local classification of soil veg etc. for each HRU
  type(c_ptr), intent(in), value    ::	handle_idStruct ! 
  ! primary data structures (variable length vectors)
  type(c_ptr), intent(in), value    ::	handle_indxStruct !  model indices
  type(c_ptr), intent(in), value    ::	handle_mparStruct !  model parameters
  type(c_ptr), intent(in), value    ::	handle_progStruct !  model prognostic (state) variables
  type(c_ptr), intent(in), value    ::	handle_diagStruct !  model diagnostic variables
  type(c_ptr), intent(in), value    ::	handle_fluxStruct !  model fluxes
  ! basin-average structures
  type(c_ptr), intent(in), value    ::	handle_bparStruct !  basin-average parameters
  type(c_ptr), intent(in), value    ::	handle_bvarStruct !  basin-average variables
  ! ancillary data structures
  type(c_ptr), intent(in), value    ::	handle_dparStruct !  default model parameters
  character(kind=c_char,len=1),intent(in)		:: file_manager_path(*)
  integer(c_int)				    :: err
 !---------------------------------------------------------------------------------------------------  
 ! local variables
 
 ! statistics structures
 type(var_dlength),pointer          :: forcStat                   !  model forcing data
 type(var_dlength),pointer          :: progStat                   !  model prognostic (state) variables
 type(var_dlength),pointer          :: diagStat                   !  model diagnostic variables
 type(var_dlength),pointer          :: fluxStat                   !  model fluxes
 type(var_dlength),pointer          :: indxStat                   !  model indices
 type(var_dlength),pointer          :: bvarStat                   !  basin-average variabl
 ! primary data structures (scalars)
 type(var_i),pointer                :: timeStruct                 !  model time data
 type(var_d),pointer                :: forcStruct                 !  model forcing data
 type(var_d),pointer                :: attrStruct                 !  local attributes for each HRU
 type(var_i),pointer                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),pointer               :: idStruct                   ! 
 ! primary data structures (variable length vectors)
 type(var_ilength),pointer          :: indxStruct                 !  model indices
 type(var_dlength),pointer          :: mparStruct                 !  model parameters
 type(var_dlength),pointer          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),pointer          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),pointer          :: fluxStruct                 !  model fluxes
 ! basin-average structures
 type(var_d),pointer                :: bparStruct                 !  basin-average parameters
 type(var_dlength),pointer          :: bvarStruct                 !  basin-average variables
 ! ancillary data structures
 type(var_d),pointer                :: dparStruct                 !  default model parameters
 character(len=256)                 :: summaFileManagerFile       ! path/name of file defining directories and files
 character(len=256)                 :: message

  
  ! getting data
  call c_f_pointer(handle_forcStat, forcStat)
  call c_f_pointer(handle_progStat, progStat)
  call c_f_pointer(handle_diagStat, diagStat)
  call c_f_pointer(handle_fluxStat, fluxStat)
  call c_f_pointer(handle_indxStat, indxStat)
  call c_f_pointer(handle_bvarStat, bvarStat)
  call c_f_pointer(handle_timeStruct, timeStruct)
  call c_f_pointer(handle_forcStruct, forcStruct)
  call c_f_pointer(handle_attrStruct, attrStruct)
  call c_f_pointer(handle_typeStruct, typeStruct)
  call c_f_pointer(handle_idStruct, idStruct)
  call c_f_pointer(handle_indxStruct, indxStruct)
  call c_f_pointer(handle_mparStruct, mparStruct)
  call c_f_pointer(handle_progStruct, progStruct)
  call c_f_pointer(handle_diagStruct, diagStruct)
  call c_f_pointer(handle_fluxStruct, fluxStruct)
  call c_f_pointer(handle_bparStruct, bparStruct)
  call c_f_pointer(handle_bvarStruct, bvarStruct)
  call c_f_pointer(handle_dparStruct, dparStruct)
  
  ! define global data (parameters, metadata)
  call summa4chm_initialize(&
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
  
  end subroutine Initialize
  
  
  
  ! **********************************************************************************************************
  ! public subroutine SetupParam: initializes parameter data structures (e.g. vegetation and soil parameters).
  ! **********************************************************************************************************
 
   subroutine SetupParam(&
   							! primary data structures (scalars)
  							handle_attrStruct, 		& !  local attributes for each HRU
  							handle_typeStruct, 		& !  local classification of soil veg etc. for each HRU
  							handle_idStruct, 		& !  local classification of soil veg etc. for each HRU
  							! primary data structures (variable length vectors)
  							handle_mparStruct, 		& !  model parameters
  							handle_bparStruct, 		& !  basin-average parameters
  							handle_bvarStruct, 		& !  basin-average variables
  							handle_dparStruct, 		& !  default model parameters
  							! miscellaneous variables
  							upArea, 			    & ! area upslope of each HRU,
  							err)  bind(C,name='SetupParam')
  
  use summa4chm_setup,only:summa4chm_paramSetup           
  
  implicit none
  ! calling variables
  type(c_ptr), intent(in), value    ::	handle_attrStruct !  local attributes for each HRU
  type(c_ptr), intent(in), value    ::	handle_typeStruct !  local classification of soil veg etc. for each HRU
  type(c_ptr), intent(in), value    ::	handle_idStruct ! 
  type(c_ptr), intent(in), value    ::	handle_mparStruct !  model parameters
  type(c_ptr), intent(in), value    ::	handle_bparStruct !  basin-average parameters
  type(c_ptr), intent(in), value    ::	handle_bvarStruct !  basin-average variables
  type(c_ptr), intent(in), value    ::	handle_dparStruct !  default model parameters
  real(dp),intent(inout)			:: upArea
  integer(c_int)				    :: err
 !---------------------------------------------------------------------------------------------------  
 ! local variables
 type(var_d),pointer                :: attrStruct                 !  local attributes for each HRU
 type(var_i),pointer                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),pointer               :: idStruct                   ! 
 type(var_dlength),pointer          :: mparStruct                 !  model parameters
 type(var_d),pointer                :: bparStruct                 !  basin-average parameters
 type(var_dlength),pointer          :: bvarStruct                 !  basin-average variables
 type(var_d),pointer                :: dparStruct                 !  default model parameters
 character(len=256)                 :: message

  
  ! getting data
  call c_f_pointer(handle_attrStruct, attrStruct)
  call c_f_pointer(handle_typeStruct, typeStruct)
  call c_f_pointer(handle_idStruct, idStruct)
  call c_f_pointer(handle_mparStruct, mparStruct)
  call c_f_pointer(handle_bparStruct, bparStruct)
  call c_f_pointer(handle_bvarStruct, bvarStruct)
  call c_f_pointer(handle_dparStruct, dparStruct)
  
  call summa4chm_paramSetup(&
   							! primary data structures (scalars)
  							attrStruct, 		& !  local attributes for each HRU
  							typeStruct, 		& !  local classification of soil veg etc. for each HRU
  							idStruct, 			& !  local classification of soil veg etc. for each HRU
  							! primary data structures (variable length vectors)
  							mparStruct, 		& !  model parameters
  							bparStruct, 		& !  basin-average parameters
  							bvarStruct, 		& !  basin-average variables
  							dparStruct, 		& !  default model parameters
  							! miscellaneous variables
  							upArea, 			& ! area upslope of each HRU,
  							err, message)
  							
  end subroutine SetupParam
  
  
  ! **********************************************************************************************************
  ! public subroutine Restart: 
  ! **********************************************************************************************************
  subroutine Restart(&
						! primary data structures (variable length vectors)
  						handle_indxStruct,				 & !  model indices
  						handle_mparStruct,				 & !  model parameters
  						handle_progStruct,				 & !  model prognostic (state) variables
  						handle_diagStruct,				 & !  model diagnostic variables
  						handle_fluxStruct,				 & !  model fluxes
  						! basin-average structures
  						handle_bvarStruct,				 & !  basin-average variables
						dt_init,						 &		
  						err) bind(C,name='Restart')
  
  use summa4chm_restart,only:summa4chm_readRestart           
  
  implicit none
  ! calling variables
  
  ! primary data structures (variable length vectors)
  type(c_ptr), intent(in), value    ::	handle_indxStruct !  model indices
  type(c_ptr), intent(in), value    ::	handle_mparStruct !  model parameters
  type(c_ptr), intent(in), value    ::	handle_progStruct !  model prognostic (state) variables
  type(c_ptr), intent(in), value    ::	handle_diagStruct !  model diagnostic variables
  type(c_ptr), intent(in), value    ::	handle_fluxStruct !  model fluxes
  ! basin-average structures
  type(c_ptr), intent(in), value    ::	handle_bvarStruct !  basin-average variables
  real(dp), intent(inout)			::  dt_init
  integer(c_int)				    :: err
 !---------------------------------------------------------------------------------------------------  
 ! local variables
 
 ! define the primary data structures (variable length vectors)
 type(var_ilength),pointer          :: indxStruct                 !  model indices
 type(var_dlength),pointer          :: mparStruct                 !  model parameters
 type(var_dlength),pointer          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),pointer          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),pointer          :: fluxStruct                 !  model fluxes
 ! define the basin-average structures
 type(var_dlength),pointer          :: bvarStruct                 !  basin-average variables
 character(len=256)                 :: message

  
  ! getting data
  call c_f_pointer(handle_indxStruct, indxStruct)
  call c_f_pointer(handle_mparStruct, mparStruct)
  call c_f_pointer(handle_progStruct, progStruct)
  call c_f_pointer(handle_diagStruct, diagStruct)
  call c_f_pointer(handle_fluxStruct, fluxStruct)
  call c_f_pointer(handle_bvarStruct, bvarStruct)
  
  ! define global data (parameters, metadata)
  call summa4chm_readRestart(&
   							! primary data structures (variable length vectors)
  							indxStruct, & ! x%var(:)%dat -- model indices
  							mparStruct, & ! x%var(:)%dat -- model parameters
  							progStruct, & ! x%var(:)%dat -- model prognostic (state) variables
  							diagStruct, & ! x%var(:)%dat -- model diagnostic variables
  							fluxStruct, & ! x%var(:)%dat -- model fluxes
  							! basin-average structures
  							bvarStruct, & ! x%var(:)%dat        -- basin-average variables
  							dt_init,    & ! used to initialize the length of the sub-step for each HRU
 							err, message)
  
  end subroutine Restart
  
  
  
  ! **********************************************************************************************************
  ! public subroutine Forcing: 
  ! **********************************************************************************************************
  subroutine Forcing(& 
  					step_index,		    	&
  					handle_timeStruct, 		&
  					handle_forcStruct, 		&
  					err) bind(C,name='Forcing')
  
  use summa4chm_forcing,only:summa4chm_readForcing           
  
  implicit none
  ! calling variables
  
  ! primary data structures (variable length vectors)
  integer(c_int), intent(in)    	::  step_index
  type(c_ptr), intent(in), value    ::	handle_timeStruct !  model indices
  type(c_ptr), intent(in), value    ::	handle_forcStruct !  model parameters
  integer(c_int)				    :: err
 !---------------------------------------------------------------------------------------------------  
 ! local variables
 
 ! define the primary data structures (variable length vectors)
 type(var_i),pointer                :: timeStruct                 !  model time data
 type(var_d),pointer                :: forcStruct                 !  model forcing data
 character(len=256)                 :: message

  
  ! getting data
  call c_f_pointer(handle_timeStruct, timeStruct)
  call c_f_pointer(handle_forcStruct, forcStruct)
  
  ! define global data (parameters, metadata)
  call summa4chm_readForcing(&
  							step_index,		    &
  							timeStruct, 		&
  							forcStruct, 		&
 							err, message)
  
  end subroutine Forcing
  
  
  ! **********************************************************************************************************
  ! public subroutine RunPhysics: solving coupled energy-mass equations for one timestep
  ! **********************************************************************************************************
  subroutine RunPhysics(& 
  					    step_index,		    	&
 					    ! primary data structures (scalars)
  						handle_timeStruct, 		& ! x%var(:)                   -- model time data
  						handle_forcStruct, 		& ! x%var(:)     -- model forcing data
  						handle_attrStruct, 		& ! x%var(:)     -- local attributes for each HRU
  						handle_typeStruct, 		& ! x%var(:)     -- local classification of soil veg etc. for each HRU
  						handle_idStruct, 			& ! x%var(:)     -- local classification of soil veg etc. for each HRU
  						! primary data structures (variable length vectors)
  						handle_indxStruct, 		& ! x%var(:)%dat -- model indices
  						handle_mparStruct, 		& ! x%var(:)%dat -- model parameters
  						handle_progStruct, 		& ! x%var(:)%dat -- model prognostic (state) variables
  						handle_diagStruct, 		& ! x%var(:)%dat -- model diagnostic variables
  						handle_fluxStruct, 		& ! x%var(:)%dat -- model fluxes
  						! basin-average structures
  						handle_bparStruct, 		& ! x%var(:)            -- basin-average parameters
  						handle_bvarStruct, 		& ! x%var(:)%dat        -- basin-average variables
  						! run time variables
  						computeVegFlux, 	    & ! flag to indicate if we are computing fluxes over vegetation
  						dt_init, 			    & ! used to initialize the length of the sub-step for each HRU
  					  	err) bind(C, name='RunPhysics')
  
  use summa4chm_modelRun,only:summa4chm_runPhysics

    !======= Declarations =========
    implicit none
   ! calling variables  
  integer(c_int), intent(in)    	::  step_index
  ! primary data structures (scalars)
  type(c_ptr), intent(in), value    ::	handle_timeStruct !  model time data
  type(c_ptr), intent(in), value    ::	handle_forcStruct !  model forcing data
  type(c_ptr), intent(in), value    ::	handle_attrStruct !  local attributes for each HRU
  type(c_ptr), intent(in), value    ::	handle_typeStruct !  local classification of soil veg etc. for each HRU
  type(c_ptr), intent(in), value    ::	handle_idStruct ! 
  ! primary data structures (variable length vectors)
  type(c_ptr), intent(in), value    ::	handle_indxStruct !  model indices
  type(c_ptr), intent(in), value    ::	handle_mparStruct !  model parameters
  type(c_ptr), intent(in), value    ::	handle_progStruct !  model prognostic (state) variables
  type(c_ptr), intent(in), value    ::	handle_diagStruct !  model diagnostic variables
  type(c_ptr), intent(in), value    ::	handle_fluxStruct !  model fluxes
  ! basin-average structures
  type(c_ptr), intent(in), value    ::	handle_bparStruct !  basin-average parameters
  type(c_ptr), intent(in), value    ::	handle_bvarStruct !  basin-average variables
  integer(i4b),intent(inout)        ::  computeVegFlux             ! flag to indicate if we are computing fluxes over vegetation
  real(dp),intent(inout)			::  dt_init
  integer(c_int), intent(out)		::  err

 ! local variables
 ! primary data structures (scalars)
 type(var_i),pointer                :: timeStruct                 !  model time data
 type(var_d),pointer                :: forcStruct                 !  model forcing data
 type(var_d),pointer                :: attrStruct                 !  local attributes for each HRU
 type(var_i),pointer                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),pointer               :: idStruct                   ! 
 ! primary data structures (variable length vectors)
 type(var_ilength),pointer          :: indxStruct                 !  model indices
 type(var_dlength),pointer          :: mparStruct                 !  model parameters
 type(var_dlength),pointer          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),pointer          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),pointer          :: fluxStruct                 !  model fluxes
 ! basin-average structures
 type(var_d),pointer                :: bparStruct                 !  basin-average parameters
 type(var_dlength),pointer          :: bvarStruct                 !  basin-average variables 
 character(len=256)                     :: message
    
  call c_f_pointer(handle_timeStruct, timeStruct)
  call c_f_pointer(handle_forcStruct, forcStruct)
  call c_f_pointer(handle_attrStruct, attrStruct)
  call c_f_pointer(handle_typeStruct, typeStruct)
  call c_f_pointer(handle_idStruct, idStruct)
  call c_f_pointer(handle_indxStruct, indxStruct)
  call c_f_pointer(handle_mparStruct, mparStruct)
  call c_f_pointer(handle_progStruct, progStruct)
  call c_f_pointer(handle_diagStruct, diagStruct)
  call c_f_pointer(handle_fluxStruct, fluxStruct)
  call c_f_pointer(handle_bparStruct, bparStruct)
  call c_f_pointer(handle_bvarStruct, bvarStruct)
  
    
 call summa4chm_runPhysics(&
 						step_index,			&
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
  						computeVegFlux, 	  & ! flag to indicate if we are computing fluxes over vegetation
  						dt_init, 			& ! used to initialize the length of the sub-step for each HRU
  						err, message)
    

 end subroutine RunPhysics


end module cppwrap_summa
