
module coupled_em_module
use data_type

implicit none

public::coupled_em

contains

!********************************************   
	subroutine coupled_em(type_data, attr_data, forc_data, mpar_data, bvar_data, prog_data, diag_data, flux_data)
	implicit none
	
		type(var_i), intent(inout)::   type_data
		type(var_d), intent(inout)::   attr_data
		type(var_d), intent(inout)::   forc_data
		type(var_dlength), intent(inout)::   mpar_data
		type(var_dlength), intent(inout)::   bvar_data
		type(var_dlength), intent(inout)::   prog_data
		type(var_dlength), intent(inout)::   diag_data
		type(var_dlength), intent(inout)::   flux_data
		integer :: i,j
 
        do i=1,size(flux_data%var)
        	do j=1,size(flux_data%var(i)%dat)
		  		flux_data%var(i)%dat(j) = flux_data%var(i)%dat(j) * 100
		  	end do
		end do
		
        do i=1,size(diag_data%var)
        	do j=1,size(diag_data%var(i)%dat)
		  		diag_data%var(i)%dat(j) = diag_data%var(i)%dat(j) * 0.01
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
