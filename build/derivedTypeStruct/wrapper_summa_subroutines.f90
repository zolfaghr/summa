
module wrapper_summa_subroutines

use, intrinsic :: iso_c_binding
use data_type
use updateVar,only:updateSummaData

implicit none
  
! pointer-to-opaque-handle technique
  
contains
  
!********************************************	
  subroutine update_summa_data(handle_ilength)bind(C,name='update_summa_data')
	
    type(c_ptr), value      :: handle_ilength         
    type(i8length), pointer  :: ptr_ilength
                   	
    call c_f_pointer(handle_ilength, ptr_ilength)
    
    call updateSummaData(ptr_ilength)

  end subroutine update_summa_data

!=====================================================================

end module wrapper_summa_subroutines


