
#ifndef CPP_CLASS_H_
#define CPP_CLASS_H_

#include <vector>
#include <iostream>

extern "C" void* get_opaque_handle();
extern "C" void  free_opaque_handle(void* handle);
extern "C" void  set_var_i(void* handle, const int* array, int size);
extern "C" void  get_var_size(void* handle, int* size);
extern "C" void  get_var_data(void* handle, int* array);


class var_i
{
private:
  void *handle;
public:
  var_i() 
  { 
    handle = get_opaque_handle(); 
  }

  ~var_i() 
  { 
    free_opaque_handle(handle); 
  }

  void set_var_i(const std::vector<int>& var)
  {
     ::set_var_i(handle, &var[0], var.size());
  }

  std::vector<int> get_var_data()
  {
    int size;
    ::get_var_size(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_var_data(handle, &array[0]);
    return array;
  }
};

#endif
