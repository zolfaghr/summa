

module cppwrap_summa


  !======= Inclusions ===========
  use, intrinsic :: iso_c_binding
  USE nrtype
  use data_types

  ! privacy
  implicit none
  public::SummaInit
  public::SetupParam
  public::Restart
  public::SolveCoupledEM


contains

  ! **********************************************************************************************************
  ! public subroutine SummaInit: 
  ! **********************************************************************************************************
  subroutine SummaInit(&
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
  						! summaFileManagerFile,			 & ! path/name of file defining directories and files) bind(C, name ='SummaInit')
  						err) bind(C,name='SummaInit')
  
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
 ! define the primary data structures (scalars)
 type(var_i),pointer                :: timeStruct                 !  model time data
 type(var_d),pointer                :: forcStruct                 !  model forcing data
 type(var_d),pointer                :: attrStruct                 !  local attributes for each HRU
 type(var_i),pointer                :: typeStruct                 !  local classification of soil veg etc. for each HRU
 type(var_i8),pointer               :: idStruct                   ! 
 ! define the primary data structures (variable length vectors)
 type(var_ilength),pointer          :: indxStruct                 !  model indices
 type(var_dlength),pointer          :: mparStruct                 !  model parameters
 type(var_dlength),pointer          :: progStruct                 !  model prognostic (state) variables
 type(var_dlength),pointer          :: diagStruct                 !  model diagnostic variables
 type(var_dlength),pointer          :: fluxStruct                 !  model fluxes
 ! define the basin-average structures
 type(var_d),pointer                :: bparStruct                 !  basin-average parameters
 type(var_dlength),pointer          :: bvarStruct                 !  basin-average variables
 ! define the ancillary data structures
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
  
  end subroutine SummaInit
  
  
  
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
  
  call summa_paramSetup(&
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
  ! public subroutine SolveCoupledEM: solving coupled energy-mass equations for one timestep
  ! **********************************************************************************************************
  subroutine SolveCoupledEM(&
  							dt_init,			 & ! intent(in):    initial time step
  							veg_fluxflag,		 & ! intent(in):    flag to indicate if we are computing fluxes over vegetation
                 			! data structures (input)
                 			handle_type,         & ! intent(in):    local classification of soil veg etc. for each HRU
                 			handle_attr,         & ! intent(in):    local attributes for each HRU
                 			handle_forc,         & ! intent(in):    model forcing data
                 			handle_mpar,         & ! intent(in):    model parameters
                 			handle_bvar,         & ! intent(in):    basin-average model variables
                 			! data structures (input-output)
                 			handle_indx,         & ! intent(inout): model indices
                 			handle_prog,         & ! intent(inout): model prognostic variables for a local HRU
                 			handle_diag,         & ! intent(inout): model diagnostic variables for a local HRU
                 			handle_flux,         & ! intent(inout): model fluxes for a local HRU
  							err					 & ! intent(out): error control
  							) bind(C,name='SolveCoupledEM')
  
  use coupled_em_module,only:coupled_em

    !======= Declarations =========
    implicit none

    ! calling variables
    real(c_double), intent(inout)		   :: dt_init
    integer(c_int), intent(inout)		   :: veg_fluxflag
    type(c_ptr), intent(in), value         :: handle_type
    type(c_ptr), intent(in), value		   :: handle_attr 
    type(c_ptr), intent(in), value		   :: handle_forc  
    type(c_ptr), intent(in), value		   :: handle_mpar
    type(c_ptr), intent(in), value		   :: handle_bvar
    type(c_ptr), intent(in), value		   :: handle_indx 
    type(c_ptr), intent(in), value		   :: handle_prog
    type(c_ptr), intent(in), value		   :: handle_diag
    type(c_ptr), intent(in), value		   :: handle_flux  
    integer(c_int), intent(out)			   :: err    
    
    ! local variables
    type(var_i), pointer				   :: type_data
    type(var_d), pointer				   :: attr_data
    type(var_d), pointer				   :: forc_data
    type(var_dlength), pointer			   :: mpar_data
    type(var_dlength), pointer			   :: bvar_data 
    type(var_ilength), pointer			   :: indx_data
    type(var_dlength), pointer			   :: prog_data 
    type(var_dlength), pointer			   :: diag_data 
    type(var_dlength), pointer			   :: flux_data  
    logical(lgt)						   :: computeVegFlux
    character(len=256)                     :: message
    integer(8)							   :: hruId

    
    ! getting data
    call c_f_pointer(handle_type, type_data) 
    call c_f_pointer(handle_attr, attr_data)
    call c_f_pointer(handle_forc, forc_data)
    call c_f_pointer(handle_mpar, mpar_data)
    call c_f_pointer(handle_bvar, bvar_data)
    call c_f_pointer(handle_indx, indx_data)
    call c_f_pointer(handle_prog, prog_data)
    call c_f_pointer(handle_diag, diag_data)
    call c_f_pointer(handle_flux, flux_data)
    
    if(veg_fluxflag == 0)then; computeVegFlux = .false.; else; computeVegFlux = .true.; endif
    
    hruId = 1001
    
 	call coupled_em(&
                 ! model control
                 hruId,             & ! intent(in):    hruId
                 dt_init,           & ! intent(inout): initial time step
                 computeVegFlux,    & ! intent(inout): flag to indicate if we are computing fluxes over vegetation
                 ! data structures (input)
                 type_data,         & ! intent(in):    local classification of soil veg etc. for each HRU
                 attr_data,         & ! intent(in):    local attributes for each HRU
                 forc_data,         & ! intent(in):    model forcing data
                 mpar_data,         & ! intent(in):    model parameters
                 bvar_data,         & ! intent(in):    basin-average model variables
                 ! data structures (input-output)
                 indx_data,         & ! intent(inout): model indices
                 prog_data,         & ! intent(inout): model prognostic variables for a local HRU
                 diag_data,         & ! intent(inout): model diagnostic variables for a local HRU
                 flux_data,         & ! intent(inout): model fluxes for a local HRU
                 ! error control
                 err,message)       ! intent(out): error control
    

 end subroutine SolveCoupledEM


end module cppwrap_summa
