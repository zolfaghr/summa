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
  
  //declare and allocate summa data structures and initialize model state to known values
  S.summa_initialize();
  
  // initialize parameter data structures (e.g. vegetation and soil parameters)
  S.summa_paramSetup();
  
  // read restart data and reset the model state (e.g initial conditions)
  S.summa_readRestart();
  
  // get the number of data windows
  int num_steps = S.get_num_steps();
  
  for(int step=1; step<=num_steps; ++step) {
	// read model forcing data
  	S.summa_readForcing(step);
  
  	// run the summa physics for one time step
  	S.summa_runPhysics(step);
  	
 }
  		
  // get and print the outputs by calling the appropriate get method of the Summa class
  bool print = true;
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
