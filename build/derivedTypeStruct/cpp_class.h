
#ifndef CPP_CLASS_H_
#define CPP_CLASS_H_

#include <vector>
#include <iostream>

extern "C" void* get_opaque_handle();
extern "C" void free_opaque_handle(void* handle);
extern "C" void SetB(void* handle, const int* data, int data_size);
extern "C" void QueryBSize(void* handle, int* data_size);
extern "C" void QueryBData(void *handle, int *data);

class SimpleF
{
private:
  void *handle;
public:
  SimpleF() 
  { 
    handle = get_opaque_handle(); 
  }

  ~SimpleF() 
  { 
    free_opaque_handle(handle); 
  }

  void SetB(const std::vector<int>& b)
  {
     ::SetB(handle, &b[0], b.size());
  }

  std::vector<int> QueryB()
  {
    // Get the data size, construct a suitable buffer, populate the buffer.
    int data_size;
    ::QueryBSize(handle, &data_size);
    if (data_size == 0) return std::vector<int>();

    std::vector<int> data(data_size);
    ::QueryBData(handle, &data[0]);
    return data;
  }
};

#endif
