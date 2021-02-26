
#ifndef CPP_CLASS_H_
#define CPP_CLASS_H_

#include <vector>
#include <iostream>

extern "C" void* get_opaque_handle();
extern "C" void free_opaque_handle(void* handle);
extern "C" void SetB(void* handle, const int* array, int array_size);
extern "C" void QueryBSize(void* handle, int* array_size);
extern "C" void QueryBData(void *handle, int *array);

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

  void SetB(const std::vector<int>& var)
  {
     ::SetB(handle, &var[0], var.size());
  }

  std::vector<int> QueryB()
  {
    // Get the array size, construct a suitable buffer, populate the buffer.
    int array_size;
    ::QueryBSize(handle, &array_size);
    if (array_size == 0) return std::vector<int>();

    std::vector<int> array(array_size);
    ::QueryBData(handle, &array[0]);
    return array;
  }
};

#endif
