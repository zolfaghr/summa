#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"


int main()  {

  Summa S;
  
  std::vector<int>  vec_i2, vec_i3, vec_i4, vec_i5;
  
  S.summa_initialize();
  std::cout << "initialization done" << std::endl;
  
  vec_i2 = S.get_timeStruct();
  std::cout << "size of timeStruct after summa_init = " <<  vec_i2.size() << std::endl;
  
  S.summa_paramSetup();
  std::cout << "paramSetup done" << std::endl;
  
  vec_i3 = S.get_timeStruct();
  std::cout << "size of timeStruct after summa_setup = " <<  vec_i3.size() << std::endl;
  
  S.summa_readRestart();
  std::cout << "readRestart done" << std::endl;
  
  vec_i4 = S.get_timeStruct();
  std::cout << "size of timeStruct after summa_restart = " <<  vec_i4.size() << std::endl;
  
  S.summa_readForcing(2);
  std::cout << "readForcing done" << std::endl;
  
  
  exit(0);
  

  
//  std::vector<int>  vec_i2;
  std::vector<double>  vec_d2, vec_d3;
  std::vector<std::vector<int>>  mat_i2;
  std::vector<std::vector<double>>  mat_d2, mat_d3, mat_d4, mat_d5, mat_d6;

  
//  S.coupled_em();
  
  
   
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
