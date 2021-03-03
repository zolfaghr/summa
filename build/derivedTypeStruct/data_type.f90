
module data_type

  implicit none
  
  type, public :: var_i
    integer, allocatable :: var(:)
  end type var_i
  
  type, public :: var_d
    real, allocatable :: var(:)
  end type var_d
  
  type, public :: dlength
  	real, allocatable   :: dat(:)   
  end type dlength
  
  type, public :: var_dlength
  	type(dlength), allocatable	 :: var(:)
  end type var_dlength

end module data_type


