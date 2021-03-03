#include <iostream>
#include <vector>
#include "summa.h"


int main()  {
  

  std::vector<int> vec_in{1,-2,3,-4,5}, vec_out;

  Summa S;

  S.set_i8length(vec_in);
  
 // update data
  S.update();
   
  vec_out = S.get_data_i8length();  
   
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  std::cout << std::endl;
 
  

  return 0;
}
