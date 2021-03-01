
#ifndef C_USERDATA_H_
#define C_USERDATA_H_

#include <iostream>
#include "cpp_class.h"

extern "C" void* get_opaque_handle2(void* handle);
extern "C" void  free_opaque_handle2(void* handle);


class udata {
private:
  void *handle;
public:
  udata(var_i *vi) 
  { 
    handle = get_opaque_handle2(vi->handle); 
  }

  ~udata() 
  { 
    free_opaque_handle2(handle); 
  }

};

#endif
