#include <iostream>
#include <vector>
#include "summa_data.h"


int main()  {
  

  std::vector<int> vec_in_i{2,5,-3,0}, vec_out_i;
  std::vector<double> vec_in_d{2.4,5.12,-3.1,0.8}, vec_out_d;
  std::vector<double> vec_in_dlength{2.0,1}, vec_out_dlength;
  std::vector<std::vector<double>> vec_in_vardlength{ { 11, 12 }, { 21, 22, 23 }, {31} };
  //std::vector<std::vector<double>> vec_in_vardlength{ { 11, 12, 21, 22, 23 }};
  
  
  summa_data S;
  
  S.set_var_i(vec_in_i);
  S.set_var_d(vec_in_d);
  S.set_dlength(vec_in_dlength);
  S.set_var_dlength(vec_in_vardlength);
  
  // or 
  // summa_data S(vec_in_i, vec_in_d, vec_in_dlength);

  
  // test get data 
  vec_out_i = S.get_data_var_i();
  vec_out_d = S.get_data_var_d();
  vec_out_dlength = S.get_data_dlength();
  
  std::cout << "before update" << std::endl;
  for(size_t i=0; i<vec_out_i.size(); i++)
  	std::cout << vec_out_i[i] << "   ";
  std::cout << std::endl;
  
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl;
 
  for(size_t i=0; i<vec_out_dlength.size(); i++)
  	std::cout << vec_out_dlength[i] << "   ";
  std::cout << std::endl;
  
  
  // update data
  S.update();
  
  // print after update  
  vec_out_i = S.get_data_var_i();
  vec_out_d = S.get_data_var_d();
  vec_out_dlength = S.get_data_dlength();
  
  
  std::cout << "after update" << std::endl;
  for(size_t i=0; i<vec_out_i.size(); i++)
  	std::cout << vec_out_i[i] << "   ";
  std::cout << std::endl;
    
  for(size_t i=0; i<vec_out_d.size(); i++)
  	std::cout << vec_out_d[i] << "   ";
  std::cout << std::endl; 
   
  for(size_t i=0; i<vec_out_dlength.size(); i++)
  	std::cout << vec_out_dlength[i] << "   ";
  std::cout << std::endl;
 
  

  return 0;
}
