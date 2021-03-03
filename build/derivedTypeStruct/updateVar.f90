
module updateVar
use data_type

implicit none

public::updateSummaData

contains

!********************************************   
	subroutine updateSummaData(v_i, v_d, v_dlength, v_vardlength) 
	implicit none
	
		type(var_i), intent(inout)  :: v_i
		type(var_d), intent(inout)  :: v_d
		type(dlength), intent(inout):: v_dlength
		type(var_dlength), intent(inout):: v_vardlength
		integer  :: i

		v_i%var = 40
		v_d%var = 3.5
		v_dlength%dat = -2.4
		do i=1,size(v_vardlength%var)
			v_vardlength%var(i)%dat = i*10 + 0.1
		end do

	end subroutine updateSummaData

!********************************************   

end module updateVar
