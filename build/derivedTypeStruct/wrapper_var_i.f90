
module wrapper_var_i

use, intrinsic :: iso_c_binding
use data_type
use updateVar,only:updateVar_i

implicit none
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function new_handle_var_i() result(handle) bind(C, name='new_handle_var_i')
    
    type(c_ptr) :: handle
    type(var_i), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_var_i

!**************************************************
  subroutine delete_handle_var_i(handle) bind(C, name='delete_handle_var_i')
    
    type(c_ptr), intent(in), value :: handle
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_var_i

!**************************************************
  subroutine set_data_var_i(handle, array, arr_size) bind(C, name='set_data_var_i')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(in), value :: arr_size
    integer(c_int), intent(in) :: array(arr_size)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)    
    if (allocated(p%var)) then
      if (size(p%var) /= arr_size) then
        deallocate(p%var)
        allocate(p%var(arr_size))
      end if
    else
      allocate(p%var(arr_size))
    end if
    p%var = array
    
  end subroutine set_data_var_i

!**************************************************
  subroutine get_size_data_var_i(handle, arr_size) bind(C, name='get_size_data_var_i')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: arr_size
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      arr_size = size(p%var, kind=c_int)
    else
      arr_size = 0_c_int
    end if
    
  end subroutine get_size_data_var_i

!**************************************************
  subroutine get_data_var_i(handle, array) bind(C, name='get_data_var_i')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array(*)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      array(:size(p%var)) = p%var
    end if
    
  end subroutine get_data_var_i
  
!********************************************	
  subroutine update_var_i(handle)bind(C,name='update_var_i')
	
    type(c_ptr), value      :: handle      
    type(var_i), pointer    :: p           
    	
    call c_f_pointer(handle, p)
    
    call updateVar_i(p)

  end subroutine update_var_i

!=====================================================================

end module wrapper_var_i


