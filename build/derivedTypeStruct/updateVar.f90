
module updateVar
use data_type

implicit none

public::updateSummaData

contains

!********************************************   
	subroutine updateSummaData(v) 
	implicit none
	
		type(i8length), intent(inout):: v
		integer :: i
 
        do i=1,size(v%dat)
		  v%dat(i) = v%dat(i) * 2
		end do

	end subroutine updateSummaData

!********************************************   

end module updateVar
