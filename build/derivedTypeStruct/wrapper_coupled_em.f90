

module wrapper_coupled_em


  !======= Inclusions ===========
  use, intrinsic :: iso_c_binding
  USE nrtype
  use data_type

  ! privacy
  implicit none
  public::solveCoupledEM


contains

  ! **********************************************************************************************************
  ! public subroutine solveCoupledEM: solving coupled energy-mass equations for one timestep
  ! **********************************************************************************************************
  subroutine solveCoupledEM(handle_type,		&
  							handle_attr,		&
  							handle_forc,		&
  							handle_mpar			&
  							) bind(C,name='solveCoupledEM')
  
  use coupled_em_module,only:coupled_em

    !======= Declarations =========
    implicit none

    ! calling variables
    type(c_ptr), intent(in), value         :: handle_type
    type(c_ptr), intent(in), value		   :: handle_attr 
    type(c_ptr), intent(in), value		   :: handle_forc  
    type(c_ptr), intent(in), value		   :: handle_mpar       
    
    ! local variables
    type(var_i), pointer				   :: type_data
    type(var_d), pointer				   :: attr_data
    type(var_d), pointer				   :: forc_data
    type(var_dlength), pointer			   :: mpar_data  

    !======= Internals ============
    
    
    call c_f_pointer(handle_type, type_data) 
    call c_f_pointer(handle_attr, attr_data)
    call c_f_pointer(handle_forc, forc_data)
    call c_f_pointer(handle_mpar, mpar_data)
    
    call coupled_em(type_data, attr_data, forc_data, mpar_data)
    

 end subroutine solveCoupledEM


end module wrapper_coupled_em
