
module coupled_em_module
use data_type

implicit none

public::coupled_em

contains

!********************************************   
	subroutine coupled_em(v) 
	implicit none
	
		type(var_i), intent(inout):: v
		integer :: i,j
 
!        do i=1,size(v%var)
!        	do j=1,size(v%var(i)%dat)
!		  		v%var(i)%dat(j) = .not.v%var(i)%dat(j)
!		  	end do
!		end do

        do i=1,size(v%var)
        	v%var(i) = v%var(i) * 2
        end do

	end subroutine coupled_em

!********************************************   

end module coupled_em_module
