
module data_type

  implicit none
  
  type :: var_i
    integer, allocatable :: var(:)
  end type var_i

end module data_type


