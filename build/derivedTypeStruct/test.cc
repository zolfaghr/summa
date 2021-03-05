#include <iostream>
#include <vector>
#include "summa.h"


int main()  {
  

  std::vector<int> vec_in{1,-2,3,-4,5}, vec_out;
  std::vector<double> vec_ind{1,-2,3,-4,5}, vec_outd, vec_outd2;
  std::vector<std::vector<double>> mat_in{ { 11, 12, 13, 14 }, { 21, 22, 23 }, {31} }, mat_out, mat_out2;
  std::vector<std::vector<int>> mat_in3{ { 11, 12, 13, 14 }, { 21, 22, 23 }, {31} }, mat_out3;
//    std::vector<int> vec_in{true,false,false,true}, vec_out;
//    std::vector<std::vector<int>> mat_in{ { true, false }, { true, false, false }, {false} }, mat_out;

  Summa S;
  
  S.set_dt(4.5);
  S.set_veg_fluxflag(true);
  S.set_type(vec_in);
  S.set_attr(vec_ind);
  S.set_forc(vec_ind);
  S.set_indx(mat_in3);
  S.set_diag(mat_in);

  
  S.coupled_em();
   
  vec_out = S.get_type();
  vec_outd = S.get_attr();
  vec_outd2 = S.get_forc();
  mat_out3 = S.get_indx(); 
  mat_out2 = S.get_diag(); 
  int err = S.get_err();
  
  std::cout << "error code = " << err << std::endl;
  
  
  
   
  for(size_t i=0; i<mat_out3.size(); i++) {
  	for(size_t j=0; j<mat_out3[i].size(); j++)
  		std::cout << mat_out3[i][j] << " ";
  	std::cout << std::endl;
  }
 
  for(size_t i=0; i<mat_out2.size(); i++) {
  	for(size_t j=0; j<mat_out2[i].size(); j++)
  		std::cout << mat_out2[i][j] << " ";
  	std::cout << std::endl;
  } 
  for(size_t i=0; i<vec_out.size(); i++)
        std::cout << vec_out[i] << " ";
  std::cout << std::endl;
  
  for(size_t i=0; i<vec_outd.size(); i++)
        std::cout << vec_outd[i] << " ";
  std::cout << std::endl;
  
  for(size_t i=0; i<vec_outd2.size(); i++)
        std::cout << vec_outd2[i] << " ";
  std::cout << std::endl;

  return 0;
}
