#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"

using namespace std;


int main()  {

  const char *path = "/home/stiff/summaTestCases_3.0/settings/syntheticTestCases/colbeck1976/summa_fileManager_colbeck1976-exp1.txt";

  Summa S;
  
  S.set_file_manager(path);
  
  S.summa_initialize();
  
  S.summa_paramSetup();
  
  S.summa_readRestart();
  
  int num_steps = S.get_num_steps();
  
  vector<int> time;
  vector<double> forc;
  
  for(int step = 1; step < num_steps; step++) {
  	S.summa_readForcing(step);
  	time = S.get_timeStruct();
  	forc = S.get_forcStruct();
  	cout << "step --- > " << step << endl;
  	cout << "timeStruct = ";
  	for(size_t i = 0; i<time.size(); i++)
  		cout << time[i] << "  ";
  	cout << endl;
    cout << "forcStruct = ";
  	for(size_t i = 0; i<forc.size(); i++)
  		cout << forc[i] << "  ";
  	cout << endl;
  	
  	S.summa_runPhysics(step);
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
