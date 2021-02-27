#include <iostream>
#include <vector>
#include "cpp_class.h"

int main()
{
  var_i x;

  std::vector<int> vec_in{2,5,-3,0};
  x.set_var_i(vec_in);
  
  // call functions to update x
  
  std::vector<int> vec_out;
  vec_out = x.get_var_data();
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  std::cout << std::endl;

  return 0;
}
