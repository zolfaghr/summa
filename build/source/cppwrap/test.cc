#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"


int main()  {

  Summa S;
  
  // define global data
  //S.summa_defineGlobalData();
  
  S.summa_initialize();
  
  exit(0);
  
  std::vector<int> vec_i1{1,-2,3,-4,5}, vec_i2;
  std::vector<double> vec_d1{1.1,-2.2,3.3,-4.4,5.5}, vec_d2, vec_d3;
  std::vector<std::vector<int>> mat_i1{ { 11, 12, 13, 14 }, { 21, 22, 23 }, {31} }, mat_i2;
  std::vector<std::vector<double>> mat_d1{ { 1.1, 1.2, 1.3, 1.4 }, { 2.1, 2.2, 2.3 }, {3.1} }, mat_d2, mat_d3, mat_d4, mat_d5, mat_d6;

  S.set_dt(60);
  S.set_veg_fluxflag(true); 
  
  S.set_typeStruct(vec_i1);
  S.set_attrStruct(vec_d1);
  S.set_forcStruct(vec_d1);
  S.set_mparStruct(mat_d1);
  S.set_bvarStruct(mat_d1);
  S.set_indxStruct(mat_i1);
  S.set_progStruct(mat_d1);
  S.set_diagStruct(mat_d1);
  S.set_fluxStruct(mat_d1);

  
  S.coupled_em();
  
  
   
  vec_i2 = S.get_typeStruct();
  vec_d2 = S.get_attrStruct();
  vec_d3 = S.get_forcStruct();
  mat_d3 = S.get_mparStruct();
  mat_d4 = S.get_bvarStruct();
  mat_i2 = S.get_indxStruct(); 
  mat_d5 = S.get_progStruct();
  mat_d2 = S.get_diagStruct();
  mat_d6 = S.get_fluxStruct(); 
  int err = S.get_err();
  
   
 
  std::cout << "type_data = ";
  for(size_t i=0; i<vec_i2.size(); i++)
        std::cout << vec_i2[i] << "  ";
  std::cout << std::endl;
  std::cout << "-----------------------" << std::endl;
  
  std::cout << "attr_data = ";
  for(size_t i=0; i<vec_d2.size(); i++)
        std::cout << vec_d2[i] << "  ";
  std::cout << std::endl;
  std::cout << "-----------------------" << std::endl;
  
  std::cout << "forc_data =  ";
  for(size_t i=0; i<vec_d3.size(); i++)
        std::cout  << vec_d3[i] << "  ";
  std::cout << std::endl;
  std::cout << "-----------------------" << std::endl;
  
  std::cout << "mpar_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_d3.size(); i++) {
  	for(size_t j=0; j<mat_d3[i].size(); j++)
  		std::cout << mat_d3[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  
  std::cout << "bvar_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_d4.size(); i++) {
  	for(size_t j=0; j<mat_d4[i].size(); j++)
  		std::cout << mat_d4[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  
  std::cout << "indx_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_i2.size(); i++) {
  	for(size_t j=0; j<mat_i2[i].size(); j++)
  		std::cout << mat_i2[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  
  std::cout << "prog_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_d5.size(); i++) {
  	for(size_t j=0; j<mat_d5[i].size(); j++)
  		std::cout << mat_d5[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  
  std::cout << "diag_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_d2.size(); i++) {
  	for(size_t j=0; j<mat_d2[i].size(); j++)
  		std::cout << mat_d2[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  
  std::cout << "flux_data = " << std::endl;
  std::cout << "\t";
  for(size_t i=0; i<mat_d6.size(); i++) {
  	for(size_t j=0; j<mat_d6[i].size(); j++)
  		std::cout << mat_d6[i][j] << "  ";
  	std::cout << std::endl << "\t";
  } 
  std::cout << "\n" << "-----------------------" << std::endl;
  

  return 0;
}
