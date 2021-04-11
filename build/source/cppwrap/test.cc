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

  S.set_dt(60);
  S.set_veg_fluxflag(false);
  S.summa_runPhysics(1);
  

  return 0;
}
