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

  S.summa_readForcing(1);
  
//  exit(0);
  S.set_dt(60);
  S.set_veg_fluxflag(false);
  S.coupled_em();
  

  return 0;
}
