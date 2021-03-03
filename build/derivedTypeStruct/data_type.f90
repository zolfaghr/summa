
module data_type
use nrtype

  implicit none
  
  type, public :: var_i
    integer(i4b), allocatable :: var(:)
  end type var_i
  
  type, public :: var_d
    real(dp), allocatable :: var(:)
  end type var_d
  
  type, public :: dlength
  	real(dp), allocatable   :: dat(:)   
  end type dlength
  
  type, public :: var_dlength
  	type(dlength), allocatable	 :: var(:)
  end type var_dlength

end module data_type


