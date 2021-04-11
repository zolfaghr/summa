#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"

using namespace std;


int main()  {

  Summa S;
  
  S.summa_initialize();
  
  S.summa_paramSetup();
  
  S.summa_readRestart();

  S.summa_readForcing(1);

  S.set_dt(60);
  S.set_veg_fluxflag(false);
  S.summa_runPhysics(1);
  
  vector<vector<double>> prog;
  prog = S.get_progStruct();
  
  for(size_t i=0; i<prog.size(); ++i) {
  	for(size_t j=0; j<prog[i].size(); ++j) 
  		cout << prog[i][j] << "  ";
  	cout << endl;
  }
  	
  

  return 0;
}
