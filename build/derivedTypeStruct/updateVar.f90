
module updateVar
use data_type

implicit none

public::updateVar_i
public::updateVar_d
public::updateSummaData

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
	subroutine updateSummaData(v_i, v_d) 
	implicit none
	
		type(var_i), intent(inout)  :: v_i
		type(var_d), intent(inout)  :: v_d

		v_i%var = 40
		v_d%var = 3.5

	end subroutine updateSummaData

!********************************************   

end module updateVar
