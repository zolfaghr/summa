
module wrapper_summa_subroutines

use, intrinsic :: iso_c_binding
use data_type
use updateVar,only:updateSummaData

implicit none
  
! pointer-to-opaque-handle technique
  
contains
  
!********************************************	
  subroutine update_summa_data(handle)bind(C,name='update_summa_data')
	
    type(c_ptr), value      :: handle         
    type(var_i8length), pointer  :: ptr
                   	
    call c_f_pointer(handle, ptr)
    
    call updateSummaData(ptr)

  end subroutine update_summa_data

!=====================================================================

end module wrapper_summa_subroutines


