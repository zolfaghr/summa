#include <vector>
#include <iostream>
#include "cpp_class.h"

int main()
{
  var_i x;

  std::vector<int> testvector{2,5};
  x.set_var_i(testvector);
  std::cout << x.get_var_data()[0] << ' ' << x.get_var_data()[1] << std::endl;

  return 0;
}
