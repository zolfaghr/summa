#include <iostream>
#include <vector>
#include "summa.h"


int main()  {
  

  std::vector<int> vec_in{1,-2,3,-4,5}, vec_out;
//  std::vector<std::vector<int>> mat_in{ { 11, 12 }, { 21, 22, 23 }, {31} }, mat_out;
//    std::vector<int> vec_in{true,false,false,true}, vec_out;
//    std::vector<std::vector<int>> mat_in{ { true, false }, { true, false, false }, {false} }, mat_out;

  Summa S;

  S.set_type(vec_in);

  
 // update data
  S.coupled_em();
   
  vec_out = S.get_type();  
   
//  for(size_t i=0; i<mat_out.size(); i++) {
//  	for(size_t j=0; j<mat_out[i].size(); j++)
//  		std::cout << mat_out[i][j] << " ";
//  	std::cout << std::endl;
//  }
 
  for(size_t i=0; i<vec_out.size(); i++)
        std::cout << vec_out[i] << " ";
  std::cout << std::endl;

  return 0;
}
