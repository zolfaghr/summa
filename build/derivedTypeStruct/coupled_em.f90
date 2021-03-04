
module coupled_em_module
use data_type

implicit none

public::coupled_em

contains

!********************************************   
	subroutine coupled_em(type_data, attr_data, forc_data, mpar_data) 
	implicit none
	
		type(var_i), intent(inout)::   type_data
		type(var_d), intent(inout)::   attr_data
		type(var_d), intent(inout)::   forc_data
		type(var_dlength), intent(inout)::   mpar_data
		integer :: i,j
 
        do i=1,size(mpar_data%var)
        	do j=1,size(mpar_data%var(i)%dat)
		  		mpar_data%var(i)%dat(j) = mpar_data%var(i)%dat(j) * 3
		  	end do
		end do

        do i=1,size(type_data%var)
        	type_data%var(i) = type_data%var(i) * 2
        end do
        
        do i=1,size(attr_data%var)
        	attr_data%var(i) = attr_data%var(i) * 0.1
        end do
        
        do i=1,size(forc_data%var)
        	forc_data%var(i) = forc_data%var(i) * 0.2
        end do

	end subroutine coupled_em

!********************************************   

end module coupled_em_module
