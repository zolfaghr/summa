
module module_updateVar
use, intrinsic :: iso_c_binding
use data_type
use user_type

implicit none

public::update_fvar
public::update_cvar

contains
	!********************************************
	subroutine update_fvar(v) 
	implicit none

		type(var_i), intent(inout)  :: v

        print *, ' in update_fvar doing nothing'

	end subroutine update_fvar
	
	!********************************************	
	subroutine update_cvar(user_data) bind(C,name='update_cvar')
	use data_type
	use user_type
	implicit none
	
    	type(c_ptr), value      :: user_data     ! user-defined data  
    	type(f_user), pointer    :: v             ! user data
  
    	call c_f_pointer(user_data, v)
    	
    	print *, 'var(:) in update_cvar before updating = ',  v%vf%var(1)
    
    	call update_fvar(v%vf)

    end subroutine update_cvar

!********************************************    

end module module_updateVar
