

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
  							handle_mpar,		&
  							handle_bvar,		&
  							handle_prog,		&
  							handle_diag,		&
  							handle_flux 		&
  							) bind(C,name='solveCoupledEM')
  
  use coupled_em_module,only:coupled_em

    !======= Declarations =========
    implicit none

    ! calling variables
    type(c_ptr), intent(in), value         :: handle_type
    type(c_ptr), intent(in), value		   :: handle_attr 
    type(c_ptr), intent(in), value		   :: handle_forc  
    type(c_ptr), intent(in), value		   :: handle_mpar
    type(c_ptr), intent(in), value		   :: handle_bvar 
    type(c_ptr), intent(in), value		   :: handle_prog
    type(c_ptr), intent(in), value		   :: handle_diag
    type(c_ptr), intent(in), value		   :: handle_flux      
    
    ! local variables
    type(var_i), pointer				   :: type_data
    type(var_d), pointer				   :: attr_data
    type(var_d), pointer				   :: forc_data
    type(var_dlength), pointer			   :: mpar_data
    type(var_dlength), pointer			   :: bvar_data 
    type(var_dlength), pointer			   :: prog_data 
    type(var_dlength), pointer			   :: diag_data 
    type(var_dlength), pointer			   :: flux_data  

    !======= Internals ============
    
    
    call c_f_pointer(handle_type, type_data) 
    call c_f_pointer(handle_attr, attr_data)
    call c_f_pointer(handle_forc, forc_data)
    call c_f_pointer(handle_mpar, mpar_data)
    call c_f_pointer(handle_bvar, bvar_data)
    call c_f_pointer(handle_bvar, prog_data)
    call c_f_pointer(handle_bvar, diag_data)
    call c_f_pointer(handle_bvar, flux_data)
    
    call coupled_em(type_data, attr_data, forc_data, mpar_data, bvar_data, prog_data, diag_data, flux_data)
    

 end subroutine solveCoupledEM


end module wrapper_coupled_em
