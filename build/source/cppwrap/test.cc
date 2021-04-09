#include <iostream>
#include <stdio.h>
#include <vector>
#include<string.h>
#include "summa.h"


int main()  {

  Summa S;
  
  S.summa_initialize();
  
  S.summa_paramSetup();
  
  S.summa_readRestart();

  S.summa_readForcing(2);
  
  exit(0);
  
//  S.coupled_em();
  

  return 0;
}
