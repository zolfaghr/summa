
#ifndef VAR_I_H_
#define VAR_I_H_

#include <vector>
#include <iostream>

extern "C" void* new_opaque_handle();
extern "C" void  delete_opaque_handle(void* handle);
extern "C" void  set_data(void* handle, const int* array, int size);
extern "C" void  get_size_data(void* handle, int* size);
extern "C" void  get_data(void* handle, int* array);
extern "C" void  update_var_i(void* handle);


class var_i
{
private:
  void *handle;
public:
  var_i() 
  { 
    handle = new_opaque_handle(); 
  }

  ~var_i() 
  { 
    delete_opaque_handle(handle); 
  }

  void set_data(const std::vector<int>& var)
  {
     ::set_data(handle, &var[0], var.size());
  }
  
  void update_var_i()
  {
     ::update_var_i(handle);
  }

  std::vector<int> get_data()
  {
    int size;
    ::get_size_data(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data(handle, &array[0]);
    return array;
  }
};

#endif
