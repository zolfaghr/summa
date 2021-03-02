#include <iostream>
#include <vector>
#include "var_i.h"
#include "var_d.h"
#include "summa_data.h"

int main()  {
  
 // test var_i ************************************************
  std::cout << "-------test var_i--------" << std::endl;
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
  
  
  x.update();
  
  std::cout << "after update" << std::endl;
  vec_out = x.get_data();
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  std::cout << std::endl;
  
  
 // test var_d ************************************************ 
  std::cout << "-------test var_d--------" << std::endl;
  std::vector<double> vec_in_d{2.4,5.12,-3.1,0.8}, vec_out_d;
  var_d y(vec_in_d);
  
  // or 
  // var_d y;
  // y.set_data(vec_in);
  
  vec_out_d = y.get_data();
  std::cout << "before update" << std::endl;
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl;
  
  
  y.update();
  
  std::cout << "after update" << std::endl;
  vec_out_d = y.get_data();
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl;
  
  // test summa_data ************************************************

  return 0;
}
