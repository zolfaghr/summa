module simple
  implicit none
  
  type :: var_i
    integer, allocatable :: b(:)
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
  ! if you create objects, you need to be able to destroy them.
  subroutine free_opaque_handle(handle) bind(c, name='free_opaque_handle')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer
    
    type(c_ptr), intent(in), value :: handle
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine free_opaque_handle

!**************************************************
  subroutine SetB(handle, array, array_size) bind(c, name='SetB')
    use, intrinsic :: iso_c_binding, only:  c_ptr, c_f_pointer, c_int
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(in), value :: array_size
    integer(c_int), intent(in) :: array(array_size)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)    
    if (allocated(p%b)) then
      if (size(p%b) /= array_size) then
        deallocate(p%b)
        allocate(p%b(array_size))
      end if
    else
      allocate(p%b(array_size))
    end if
    p%b = array
    
  end subroutine SetB

!**************************************************
  subroutine QueryBSize(handle, array_size) bind(c, name='QueryBSize')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer, c_int
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array_size
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%b)) then
      array_size = size(p%b, kind=c_int)
    else
      array_size = 0_c_int
    end if
    
  end subroutine QueryBSize

!**************************************************
  subroutine QueryBData(handle, array) bind(c, name='QueryBData')
    use, intrinsic :: iso_c_binding, only:  c_ptr, c_f_pointer, c_int
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array(*)
    type(var_i), pointer :: p
    
    call c_f_pointer(handle, p)
    if (allocated(p%b)) then
      array(:size(p%b)) = p%b
    end if
    
  end subroutine QueryBData

end module simple
