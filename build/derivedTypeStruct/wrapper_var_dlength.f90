
module wrapper_var_dlength

use, intrinsic :: iso_c_binding
use data_type

implicit none
  
! pointer-to-opaque-handle technique
  
contains

!**************************************************
! get C address of the object
  function new_handle_var_dlength() result(handle) bind(C, name='new_handle_var_dlength')
    
    type(c_ptr) :: handle
    type(var_dlength), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_var_dlength

!**************************************************
  subroutine delete_handle_var_dlength(handle) bind(C, name='delete_handle_var_dlength')
    
    type(c_ptr), intent(in), value :: handle
    type(var_dlength), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_var_dlength

!**************************************************
  subroutine set_data_var_dlength(handle, array, num_row, num_col, num_elements) bind(C, name='set_data_var_dlength')
    
    type(c_ptr), intent(in), value    :: handle
    integer(c_int), intent(in), value :: num_row
    integer(c_int), intent(in), value :: num_elements
    integer(c_int), intent(in)   	  :: num_col(num_row) 
    real(c_double), intent(in)        :: array(num_elements)
    type(var_dlength), pointer :: p
    integer(c_int)  :: i,j,sum_elem
    
    print *, 'num_row = ', num_row
    print *, 'num_col = ', num_col
    print *, 'num_elem = ', num_elements
    
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
    
    print *, 'sum_elem = ', sum_elem
    
  end subroutine set_data_var_dlength

!=====================================================================

end module wrapper_var_dlength


