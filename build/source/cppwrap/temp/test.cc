#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"


int main()  {

  Summa S;
  
  std::vector<int> vec_i1{1,-2,3,-4,5}, vec_i2;
  std::vector<double> vec_d1{1.1,-2.2,3.3,-4.4,5.5}, vec_d2, vec_d3;
  std::vector<std::vector<int>> mat_i1{ { 11, 12, 13, 14 }, { 21, 22, 23 }, {31} }, mat_i2;
  std::vector<std::vector<double>> mat_d1{ { 1.1, 1.2, 1.3, 1.4 }, { 2.1, 2.2, 2.3 }, {3.1} }, mat_d2, mat_d3, mat_d4, mat_d5, mat_d6;
  VarInfo  vfo1;
 
  vfo1.varname="this is varname variable we passed from C++";
  vfo1.vartype = 4; vfo1.varDesire = true;



  S.set_dt(60);
  S.set_veg_fluxflag(true);
  
  S.set_type(vec_i1);
  S.set_attr(vec_d1);
  S.set_forc(vec_d1);
  S.set_mpar(mat_d1);
  S.set_bvar(mat_d1);
  S.set_indx(mat_i1);
  S.set_prog(mat_d1);
  S.set_diag(mat_d1);
  S.set_flux(mat_d1);
  
  S.set_indxmeta(vfo1);

  
  S.coupled_em();
  
   
  vec_i2 = S.get_type();
  vec_d2 = S.get_attr();
  vec_d3 = S.get_forc();
  mat_d3 = S.get_mpar();
  mat_d4 = S.get_bvar();
  mat_i2 = S.get_indx(); 
  mat_d5 = S.get_prog();
  mat_d2 = S.get_diag();
  mat_d6 = S.get_flux(); 
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
