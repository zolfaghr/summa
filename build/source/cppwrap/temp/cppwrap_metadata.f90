
module cppwrap_metadata

use, intrinsic :: iso_c_binding
use data_types

implicit none
  
contains

! ***************** Auxiliary functions and subroutines ***********************

  function comp_len_string(c_str) result(length)
  	character(kind=c_char,len=1),intent(in)		:: c_str(*)
  	integer 									:: length
  	
  	length=0
    do
       if (c_str(length+1) == C_NULL_CHAR) exit
       length = length + 1
    end do 
    
  end function comp_len_string
  
! -----------------------------------------------------------  	
  subroutine c_f_string(c_str, f_str, l)
  
  	character(kind=c_char,len=1),intent(in)		:: c_str(*)
  	integer, intent(in)							:: l
  	character(len=l),intent(out)				:: f_str
  
  	character(len=:), allocatable 				:: temp
  	integer 									:: length   
      
    length = comp_len_string(c_str)
    
    allocate(character(len=length) :: temp)    
    temp = transfer(c_str(1:length), temp)
    
    f_str = temp
    
    deallocate(temp)
    
  end subroutine c_f_string
  

! **************************** var_info ********************************

  function new_handle_var_info() result(handle) bind(C, name='new_handle_var_info')
    
    type(c_ptr) 			:: handle
    type(var_info), pointer :: p
    
    allocate(p)    
    handle = c_loc(p)   
    
  end function new_handle_var_info

!-----------------------------------
  subroutine delete_handle_var_info(handle) bind(C, name='delete_handle_var_info')
    
    type(c_ptr), intent(in), value :: handle
    type(var_info), pointer :: p
    
    call c_f_pointer(handle, p)
    deallocate(p)
    
  end subroutine delete_handle_var_info
  
!-----------------------------------
  subroutine set_data_var_info(handle, varname, vardesc, varunit, vartype, varDesire) bind(C, name='set_data_var_info')
    
    type(c_ptr), intent(in), 	value 			:: handle
  	character(kind=c_char,len=1),intent(in)		:: varname(*), vardesc(*), varunit(*)
  	integer(c_int),intent(in),  value       	:: vartype   
  	integer(c_int),intent(in),  value       	:: varDesire
  	
    type(var_info), pointer 					:: p
    character(len=:), allocatable 				:: temp
	    
    call c_f_pointer(handle, p)
    
    call c_f_string(varname, p%varname, 64)
    call c_f_string(vardesc, p%vardesc, 128)
    call c_f_string(varunit, p%varunit, 64)
    p%vartype = vartype
    if(varDesire == 0)then; p%varDesire = .false.; else; p%varDesire = .true.; endif
    
    print *, p%varname
    print *, p%vardesc
    print *, p%varunit
    print *, p%vartype
    print *, p%varDesire
    
    stop 1
    

    
  end subroutine set_data_var_info


     
end module cppwrap_metadata


