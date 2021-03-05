

module cppwrap_summa


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
  subroutine solveCoupledEM(&
  							dt_init,			&
  							veg_fluxflag,		&
  							handle_type,		&
  							handle_attr,		&
  							handle_forc,		&
  							handle_mpar,		&
  							handle_bvar,		&
  							handle_indx,		&
  							handle_prog,		&
  							handle_diag,		&
  							handle_flux, 		&
  							err					&
  							) bind(C,name='solveCoupledEM')
  
  use coupled_em_module,only:coupled_em

    !======= Declarations =========
    implicit none

    ! calling variables
    real(c_double), intent(in)			   :: dt_init
    integer(c_int), intent(in)			   :: veg_fluxflag
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
    
    call coupled_em(hruId, dt_init, computeVegFlux, &
    				type_data, attr_data, forc_data, mpar_data, bvar_data, &
    				indx_data, prog_data, diag_data, flux_data, &
    				err, message)
    

 end subroutine solveCoupledEM


end module cppwrap_summa
