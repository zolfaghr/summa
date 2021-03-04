
module wrapper_var_flagVec

use, intrinsic :: iso_c_binding
use data_type

implicit none
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function new_handle_var_flagVec() result(handle) bind(C, name='new_handle_var_flagVec')
    
    type(c_ptr) :: handle
    type(var_flagVec), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_var_flagVec

!**************************************************
  subroutine delete_handle_var_flagVec(handle) bind(C, name='delete_handle_var_flagVec')
    
    type(c_ptr), intent(in), value :: handle
    type(var_flagVec), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_var_flagVec

!**************************************************
  subroutine set_data_var_flagVec(handle, array, num_row, num_col, num_elements) bind(C, name='set_data_var_flagVec')
    
    type(c_ptr), intent(in), value    :: handle
    integer(c_int), intent(in), value :: num_row
    integer(c_int), intent(in), value :: num_elements
    integer(c_int), intent(in)   	  :: num_col(num_row) 
    integer(c_int), intent(in)        :: array(num_elements)
    type(var_flagVec), pointer :: p
    integer(c_int)  :: i,j,sum_elem
    
   
    call c_f_pointer(handle, p)    
    if (allocated(p%var)) then
      if (size(p%var) /= num_row) then
        deallocate(p%var)
        allocate(p%var(num_row))
        do i=1,num_row
        	allocate( p%var(i)%dat(num_col(i)) )
        end do
      end if
    else
        allocate(p%var(num_row))
        do i=1,num_row
        	allocate( p%var(i)%dat(num_col(i)) )
        end do
    end if
    
    sum_elem = 0
    do i=1,num_row
    	do j=1,num_col(i)
    		p%var(i)%dat(j) = array(sum_elem + j)
    	end do
    	sum_elem = sum_elem + num_col(i)
    end do
    
  end subroutine set_data_var_flagVec
  
!**************************************************
  subroutine get_size_data_var_flagVec(handle, var_size, dat_size) bind(C, name='get_size_data_var_flagVec')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: var_size
    integer(c_int), intent(out) :: dat_size(*)
    type(var_flagVec), pointer :: p
    integer(c_int)  :: i,j
    
    call c_f_pointer(handle, p)
    if (allocated(p%var)) then
      var_size = size(p%var, kind=c_int)
      do i=1,var_size
      	dat_size(i) = size(p%var(i)%dat, kind=c_int)
      end do
    else
      var_size = 0_c_int
    end if
    
  end subroutine get_size_data_var_flagVec
  
!**************************************************
  subroutine get_data_var_flagVec(handle, array) bind(C, name='get_data_var_flagVec')
    
    type(c_ptr), intent(in), value :: handle
    integer(c_int), intent(out) :: array(*)
    type(var_flagVec), pointer :: p
    integer(c_int)  :: i,j,size_var,size_dat,size_array
    
    call c_f_pointer(handle, p)
    
    size_array = 0
    if (allocated(p%var)) then
      size_var = size(p%var)
      do i=1,size_var
      	size_dat = size(p%var(i)%dat)
      	do j=1,size_dat
      		array(size_array+j) = p%var(i)%dat(j)
      	end do
      	size_array = size_array + size_dat
      end do
      
    end if
    
  end subroutine get_data_var_flagVec

!=====================================================================

end module wrapper_var_flagVec


