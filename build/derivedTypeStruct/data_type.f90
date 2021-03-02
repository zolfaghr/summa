
module data_type

  implicit none
  
  type, public :: var_i
    integer, allocatable :: var(:)
  end type var_i
  
  type, public :: var_d
    real, allocatable :: var(:)
  end type var_d
  
  type, public :: dlength
  	real, allocatable   :: var(:)   
  end type dlength

end module data_type


