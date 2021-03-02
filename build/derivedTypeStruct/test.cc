#include <iostream>
#include <vector>
#include "var_i.h"

int main()  {
  

  std::vector<int> vec_in{2,5,-3,0}, vec_out;
  var_i x(vec_in);
  
  // or 
  // var_i x;
  // x.set_data(vec_in);
  
  vec_out = x.get_data();
  std::cout << "before update" << std::endl;
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  std::cout << std::endl;
  
  
  x.update_var_i();
  
  std::cout << "after update" << std::endl;
  vec_out = x.get_data();
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  std::cout << std::endl;

  return 0;
}
