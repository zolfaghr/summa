
module updateVar
use data_type,only: var_i

implicit none

public::updateVar_i

contains
	!********************************************
	subroutine updateVar_i(v) 
	implicit none

		type(var_i), intent(inout)  :: v

		v%var = 200

	end subroutine updateVar_i

!********************************************    

end module updateVar
