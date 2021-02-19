

module solveCoupledEM_module


  !======= Inclusions ===========
  use, intrinsic :: iso_c_binding
  USE nrtype

  ! privacy
  implicit none
  public::solveCoupledEM


contains

  ! **********************************************************************************************************
  ! public function solveCoupledEM: solving coupled energy-mass equations for one timestep
  ! **********************************************************************************************************
  ! Return values:
  !    0 = success,
  !    1 = recoverable error,
  !   -1 = non-recoverable error
  ! ----------------------------------------------------------------
  integer(c_int) function solveCoupledEM(user_data) result(ierr) bind(C,name='solveCoupledEM')

    USE coupled_em_module,only:coupled_em
    USE summadata_module

    !======= Declarations =========
    implicit none

    ! calling variables
    type(c_ptr), value         :: user_data         ! user-defined data  
    
    ! local variables
    type(summaData), pointer   :: summa_data 		! summa data
    character(len=256)         :: message           ! error message
    integer(i4b)               :: err               ! error code

    !======= Internals ============
    
    ! get summa data from user-defined data
    call c_f_pointer(user_data, summa_data)
    
    
 ! ************************************************************************************************
 !   run the coupled energy-mass model for one timestep
 ! ************************************************************************************************
 	call coupled_em(&
                       ! model control
                       summa_data%hruId,             & ! intent(in):    hruId
                       summa_data%dt_init,           & ! intent(inout): used to initialize the size of the sub-step
                       summa_data%computeVegFlux,    & ! intent(inout): flag to indicate if we are computing fluxes over vegetation
                       ! data structures (input)
                       summa_data%type_data,         & ! intent(in):    local classification of soil veg etc. for each HRU
                       summa_data%attr_data,         & ! intent(in):    local attributes for each HRU
                       summa_data%forc_data,         & ! intent(in):    model forcing data
                       summa_data%mpar_data,         & ! intent(in):    model parameters
                       summa_data%bvar_data,         & ! intent(in):    basin-average variables
                       ! data structures (input-output)
                       summa_data%indx_data,         & ! intent(inout): model indices
                       summa_data%prog_data,         & ! intent(inout): prognostic variables for a local HRU
                       summa_data%diag_data,         & ! intent(inout): diagnostic variables for a local HRU
                       summa_data%flux_data,         & ! intent(inout): model fluxes for a local HRU
                       ! error control
                       err,message)         ! intent(out):   error control
                 
 	if(err > 0)then; summa_data%message=trim(message); ierr=-1; return; endif 
 	if(err < 0)then; summa_data%message=trim(message); ierr=1; return; endif 
 
   ! return success
   ierr = 0
   return

 end function solveCoupledEM


end module solveCoupledEM_module
