#include <iostream>
#include <vector>
#include "summa.h"


int main()  {
  

//  std::vector<int> vec_in{1,-2,3,-4,5}, vec_out;
  std::vector<std::vector<int>> mat_in{ { 11, 12 }, { 21, 22, 23 }, {31} }, mat_out;

  Summa S;

  S.set_var_ilength(mat_in);
  
 // update data
  S.update();
   
  mat_out = S.get_data_var_ilength();  
   
  for(size_t i=0; i<mat_out.size(); i++) {
  	for(size_t j=0; j<mat_out[i].size(); j++)
  		std::cout << mat_out[i][j] << " ";
  	std::cout << std::endl;
  }
 
  

  return 0;
}
