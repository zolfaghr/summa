
module updateVar
use data_type

implicit none

public::updateVar_i
public::updateVar_d

contains
!********************************************
	subroutine updateVar_i(v) 
	implicit none

		type(var_i), intent(inout)  :: v

		v%var = 200

	end subroutine updateVar_i

!******************************************** 
	subroutine updateVar_d(v) 
	implicit none

		type(var_d), intent(inout)  :: v

		v%var = 3.5

	end subroutine updateVar_d

!********************************************     

end module updateVar
