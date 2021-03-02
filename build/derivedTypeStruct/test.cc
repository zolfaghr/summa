#include <iostream>
#include <vector>
#include "summa_data.h"


int main()  {
  

  std::vector<int> vec_in_i{2,5,-3,0}, vec_out_i;
  std::vector<double> vec_in_d{2.4,5.12,-3.1,0.8}, vec_out_d;
  std::vector<double> vec_in_dlength{2.0,1}, vec_out_dlength;
  
  summa_data s(vec_in_i, vec_in_d, vec_in_dlength);

  
  // or 
  // summa_data s;
  // s.set_data(vec_in_i, vec_in_d);
  
  // test get data 
  vec_out_i = s.get_data_var_i();
  std::cout << "before update" << std::endl;
  for(size_t i=0; i<vec_out_i.size(); i++)
  	std::cout << vec_out_i[i] << "   ";
  std::cout << std::endl;
  
  vec_out_d = s.get_data_var_d();
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl;
  
  vec_out_dlength = s.get_data_dlength();
  for(size_t i=0; i<vec_out_dlength.size(); i++)
  	std::cout << vec_out_dlength[i] << "   ";
  std::cout << std::endl;
  
  
  // update data
  s.update();
  
  // print after update  
  vec_out_i = s.get_data_var_i();
  std::cout << "after update" << std::endl;
  for(size_t i=0; i<vec_out_i.size(); i++)
  	std::cout << vec_out_i[i] << "   ";
  std::cout << std::endl;
  
  vec_out_d = s.get_data_var_d();
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl; 
  
  vec_out_dlength = s.get_data_dlength();
  for(size_t i=0; i<vec_out_dlength.size(); i++)
  	std::cout << vec_out_dlength[i] << "   ";
  std::cout << std::endl;
 
  

  return 0;
}
