
module data_type
use nrtype

  implicit none
  
  type, public :: var_i
    integer(i4b), allocatable :: var(:)
  end type var_i
  
 type, public :: var_i8
  integer(8),allocatable              :: var(:) 
 endtype var_i8
  
  type, public :: var_d
    real(dp), allocatable :: var(:)
  end type var_d

 type, public :: ilength
  integer(i4b), allocatable            :: dat(:)    
 end type ilength
 
 type, public :: i8length
  integer(8),allocatable              :: dat(:)    
 end type i8length
   
  type, public :: dlength
  	real(dp), allocatable   :: dat(:)   
  end type dlength
  
  type, public :: var_dlength
  	type(dlength), allocatable	 :: var(:)
  end type var_dlength

end module data_type


