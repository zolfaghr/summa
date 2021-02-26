module data_type
  implicit none
  
  type :: var_i
    integer, allocatable :: var(:)
  end type var_i
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
  function get_opaque_handle() result(handle) bind(c, name='get_opaque_handle')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_loc
    
    type(c_ptr) :: handle
    type(var_i), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   ! c address of the object as an opaque handle.
    
  end function get_opaque_handle

!**************************************************
  subroutine free_opaque_handle(handle) bind(c, name='free_opaque_handle')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer
    
    type(c_ptr), intent(in), value :: handle
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine free_opaque_handle

!**************************************************
  subroutine set_var_i(handle, array, arr_size) bind(c, name='set_var_i')
    use, intrinsic :: iso_c_binding, only:  c_ptr, c_f_pointer, c_int
    
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
  subroutine QueryBSize(handle, arr_size) bind(c, name='QueryBSize')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer, c_int
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: arr_size
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      arr_size = size(p%var, kind=c_int)
    else
      arr_size = 0_c_int
    end if
    
  end subroutine QueryBSize

!**************************************************
  subroutine QueryBData(handle, array) bind(c, name='QueryBData')
    use, intrinsic :: iso_c_binding, only:  c_ptr, c_f_pointer, c_int
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array(*)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      array(:size(p%var)) = p%var
    end if
    
  end subroutine QueryBData

end module data_type
