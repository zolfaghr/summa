
module data_type

use, intrinsic :: iso_c_binding

  implicit none
  
  type :: var_i
    integer, allocatable :: var(:)
  end type var_i
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function get_opaque_handle() result(handle) bind(C, name='get_opaque_handle')
    
    type(c_ptr) :: handle
    type(var_i), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function get_opaque_handle

!**************************************************
  subroutine free_opaque_handle(handle) bind(C, name='free_opaque_handle')
    
    type(c_ptr), intent(in), value :: handle
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine free_opaque_handle

!**************************************************
  subroutine set_var_i(handle, array, arr_size) bind(C, name='set_var_i')
    
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
    
  end subroutine set_var_i

!**************************************************
  subroutine get_var_size(handle, arr_size) bind(C, name='get_var_size')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: arr_size
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      arr_size = size(p%var, kind=c_int)
    else
      arr_size = 0_c_int
    end if
    
  end subroutine get_var_size

!**************************************************
  subroutine get_var_data(handle, array) bind(C, name='get_var_data')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array(*)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      array(:size(p%var)) = p%var
    end if
    
  end subroutine get_var_data

!=====================================================================

end module data_type


