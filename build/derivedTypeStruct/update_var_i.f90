
module module_updateVar
use data_type,only: var_i

implicit none

public::update_fvar

contains
	!********************************************
	subroutine update_fvar(v) 
	implicit none

		type(var_i), intent(inout)  :: v

		v%var = 200

	end subroutine update_fvar

!********************************************    

end module module_updateVar
