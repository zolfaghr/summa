
module wrapper_summa_data

use, intrinsic :: iso_c_binding
use data_type
use updateVar,only:updateSummaData

implicit none
  
! pointer-to-opaque-handle technique
  
contains
  
!********************************************	
  subroutine update_summa_data(handle_var_i, handle_var_d, handle_dlength, handle_var_dlength)bind(C,name='update_summa_data')
	
    type(c_ptr), value      :: handle_var_i, handle_var_d, handle_dlength, handle_var_dlength          
    type(var_i), pointer    :: p_var_i
    type(var_d), pointer    :: p_var_d
    type(dlength), pointer  :: p_dlength
    type(var_dlength), pointer :: p_var_dlength
                   	
    call c_f_pointer(handle_var_i, p_var_i)
    call c_f_pointer(handle_var_d, p_var_d)
    call c_f_pointer(handle_dlength, p_dlength)
    call c_f_pointer(handle_var_dlength, p_var_dlength)
    
    call updateSummaData(p_var_i, p_var_d, p_dlength, p_var_dlength)

  end subroutine update_summa_data

!=====================================================================

end module wrapper_summa_data


