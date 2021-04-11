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
  
  for(int i=1; i<3; i++) {
  	S.summa_readForcing(i);
  	S.summa_runPhysics(i);
  }
  		

  bool print = false;
  if(print) {  
  	vector<vector<double>> prog;
  	prog = S.get_progStruct();
  
  	for(size_t i=0; i<prog.size(); ++i) {
  		for(size_t j=0; j<prog[i].size(); ++j) 
  			cout << prog[i][j] << "  ";
  		cout << endl;
  	}
  }
  	
  

  return 0;
}
