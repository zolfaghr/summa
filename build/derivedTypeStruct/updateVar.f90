
module updateVar
use data_type

implicit none

public::updateSummaData

contains

!********************************************   
	subroutine updateSummaData(v) 
	implicit none
	
		type(var_flagVec), intent(inout):: v
		integer :: i,j
 
        do i=1,size(v%var)
        	do j=1,size(v%var(i)%dat)
		  		v%var(i)%dat(j) = .not.v%var(i)%dat(j)
		  	end do
		end do

!        do i=1,size(v%dat)
!        	v%dat(i) = .false.
!        end do

	end subroutine updateSummaData

!********************************************   

end module updateVar
