
module wrapper_ilength

use, intrinsic :: iso_c_binding
use data_type

implicit none
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function new_handle_ilength() result(handle) bind(C, name='new_handle_ilength')
    
    type(c_ptr) :: handle
    type(ilength), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_ilength

!**************************************************
  subroutine delete_handle_ilength(handle) bind(C, name='delete_handle_ilength')
    
    type(c_ptr), intent(in), value :: handle
    type(ilength), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_ilength

!**************************************************
  subroutine set_data_ilength(handle, array, arr_size) bind(C, name='set_data_ilength')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(in), value :: arr_size
    real(c_double), intent(in) :: array(arr_size)
    type(ilength), pointer :: p
    
    call c_f_pointer(handle, p)    
    if (allocated(p%dat)) then
      if (size(p%dat) /= arr_size) then
        deallocate(p%dat)
        allocate(p%dat(arr_size))
      end if
    else
      allocate(p%dat(arr_size))
    end if
    p%dat = array
    
  end subroutine set_data_ilength

!**************************************************
  subroutine get_size_data_ilength(handle, arr_size) bind(C, name='get_size_data_ilength')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: arr_size
    type(ilength), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%dat)) then
      arr_size = size(p%dat, kind=c_int)
    else
      arr_size = 0_c_int
    end if
    
  end subroutine get_size_data_ilength

!**************************************************
  subroutine get_data_ilength(handle, array) bind(C, name='get_data_ilength')
    
    type(c_ptr), intent(in), value :: handle
    real(c_double), intent(out) :: array(*)
    type(ilength), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%dat)) then
      array(:size(p%dat)) = p%dat
    end if
    
  end subroutine get_data_ilength
  
!=====================================================================

end module wrapper_ilength


