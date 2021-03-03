
module updateVar
use data_type

implicit none

public::updateSummaData

contains

!********************************************   
	subroutine updateSummaData(v) 
	implicit none
	
		type(var_i8), intent(inout):: v
		integer :: i
 
        do i=1,size(v%var)
		  v%var(i) = v%var(i) * 3
		end do

	end subroutine updateSummaData

!********************************************   

end module updateVar
