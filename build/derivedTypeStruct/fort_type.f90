module simple
  implicit none
  
  type :: simplef
    integer, pointer :: b(:) => null()
  end type simplef
  
contains
  function GetHandle() result(handle) bind(c, name='GetHandle')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_loc
    type(c_ptr) :: handle
    type(simplef), pointer :: p
    allocate(p)
    ! use the c address of the object as an opaque handle.
    handle = c_loc(p)
  end function GetHandle

  ! if you create objects, you need to be able to destroy them.
  subroutine ReleaseHandle(handle) bind(c, name='ReleaseHandle')
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer
    type(c_ptr), intent(in), value :: handle
    type(simplef), pointer :: p
    !***
    call c_f_pointer(handle, p)
    deallocate(p)
  end subroutine ReleaseHandle

  subroutine SetB(handle, data, data_size) bind(c, name='SetB')
    use, intrinsic :: iso_c_binding, only:  &
        c_ptr, c_f_pointer, c_int
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(in), value :: data_size
    integer(c_int), intent(in) :: data(data_size)
    type(simplef), pointer :: p
    !***
    call c_f_pointer(handle, p)
    ! allocate p%b to appropriate size.
    !
    ! assuming here the pointer association status of p%b is always 
    ! defined or dissociated, never undefined.  this is much easier 
    ! with allocatable components.
    if (associated(p%b)) then
      if (size(p%b) /= data_size) then
        deallocate(p%b)
        allocate(p%b(data_size))
      end if
    else
      allocate(p%b(data_size))
    end if
    p%b = data
  end subroutine SetB

  subroutine QueryBSize(handle, data_size) bind(c, name='QueryBSize')
    use, intrinsic :: iso_c_binding, only:  &
        c_ptr, c_f_pointer, c_int
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: data_size
    type(simplef), pointer :: p
    !***
    call c_f_pointer(handle, p)
    ! see comments about assumed association status above.
    if (associated(p%b)) then
      data_size = size(p%b, kind=c_int)
    else
      data_size = 0_c_int
    end if
  end subroutine QueryBSize

  subroutine QueryBData(handle, data) bind(c, name='QueryBData')
    use, intrinsic :: iso_c_binding, only:  &
        c_ptr, c_f_pointer, c_int
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: data(*)
    type(simplef), pointer :: p
    !***
    call c_f_pointer(handle, p)
    ! see comments about assumed association status above.
    if (associated(p%b)) then
      data(:size(p%b)) = p%b
    else
      ! someone is being silly.
    end if
  end subroutine QueryBData

  ! ...etc...
end module simple
