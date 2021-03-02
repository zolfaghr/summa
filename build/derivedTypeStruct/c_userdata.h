
#ifndef C_USERDATA_H_
#define C_USERDATA_H_

#include <iostream>
#include "cpp_class.h"

extern "C" void* get_opaque_handle2(void* handle);
extern "C" void  free_opaque_handle2(void* handle);
extern "C" void* get_var_i(void* handle1, void* handle2);


class udata {
private:
  void *handle;
public:
  udata(var_i *vi) { handle = get_opaque_handle2(vi->handle); }
  
  var_i* get_var_i() { 
  	var_i* x;
  	::get_var_i(handle, x->handle);
  	return x;  	
  }

  ~udata()  { free_opaque_handle2(handle); }

};

#endif
