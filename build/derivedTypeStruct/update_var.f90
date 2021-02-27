
module module_updateVar
use, intrinsic :: iso_c_binding
use data_type

implicit none

public::update_fvar
public::update_cvar

contains
	!********************************************
	subroutine update_fvar(v) 
	implicit none

		type(var_i), intent(inout)  :: v

		v%var(:) = 1

	end subroutine update_fvar
	
	!********************************************	
	subroutine update_cvar(user_data) bind(C,name='update_cvar')
	implicit none
	
    	type(c_ptr), value      :: user_data     ! user-defined data  
    	! pointers to data 
    	type(var_i), pointer    :: v             ! var_i data
    
    	! get var_i from user-defined data
    	call c_f_pointer(user_data, v)
    
    	call update_fvar(v)

    end subroutine update_cvar

!********************************************    

end module module_updateVar
