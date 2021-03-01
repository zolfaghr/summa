
module user_type

use, intrinsic :: iso_c_binding
use data_type, only:var_i

  implicit none
  
  type :: f_user
    type(var_i)		:: vf
  end type f_user
  
contains

!**************************************************
! get C address of the object
  function get_opaque_handle2(handle_vari) result(handle) bind(C, name='get_opaque_handle2')
    
    type(c_ptr)           :: handle
    type(c_ptr), value 	  :: handle_vari
    type(f_user), pointer :: p
    type(var_i), pointer  :: p_vari
    
    
    allocate(p_vari)
    call c_f_pointer(handle_vari, p_vari)

    allocate(p) 
    p%vf = p_vari
    handle = c_loc(p)   

  end function get_opaque_handle2
  
!**************************************************
  subroutine free_opaque_handle2(handle) bind(C, name='free_opaque_handle2')
    
    type(c_ptr), intent(in), value :: handle
    type(f_user), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine free_opaque_handle2

!===================================================

end module user_type


