#include <iostream>
#include <vector>
#include "cpp_class.h"
#include "c_userdata.h"

using namespace std;

extern "C" void  update_cvar(udata* user_data);

int main()
{
  var_i x, *y;

  std::vector<int> vec_in{2,5,-3,0};
  x.set_var_i(vec_in);
  
  udata *user = new udata(&x);
  
  y = user->get_var_i();

  std::vector<int> vec_out;
  vec_out = y->get_var_data();
  for(size_t i=0; i<vec_out.size(); i++)
  	std::cout << vec_out[i] << "   ";
  	
   

  // call functions to update x
  update_cvar(user);

  return 0;
}
