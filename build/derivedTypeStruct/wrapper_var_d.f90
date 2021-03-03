
module wrapper_var_d

use, intrinsic :: iso_c_binding
use data_type

implicit none
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function new_handle_var_d() result(handle) bind(C, name='new_handle_var_d')
    
    type(c_ptr) :: handle
    type(var_d), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_var_d

!**************************************************
  subroutine delete_handle_var_d(handle) bind(C, name='delete_handle_var_d')
    
    type(c_ptr), intent(in), value :: handle
    type(var_d), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_var_d

!**************************************************
  subroutine set_data_var_d(handle, array, arr_size) bind(C, name='set_data_var_d')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(in), value :: arr_size
    real(c_double), intent(in) :: array(arr_size)
    type(var_d), pointer :: p
    
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
    
  end subroutine set_data_var_d

!**************************************************
  subroutine get_size_data_var_d(handle, arr_size) bind(C, name='get_size_data_var_d')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: arr_size
    type(var_d), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      arr_size = size(p%var, kind=c_int)
    else
      arr_size = 0_c_int
    end if
    
  end subroutine get_size_data_var_d

!**************************************************
  subroutine get_data_var_d(handle, array) bind(C, name='get_data_var_d')
    
    type(c_ptr), intent(in), value :: handle
    real(c_double), intent(out) :: array(*)
    type(var_d), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      array(:size(p%var)) = p%var
    end if
    
  end subroutine get_data_var_d

!=====================================================================

end module wrapper_var_d


