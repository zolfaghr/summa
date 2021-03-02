
#ifndef VAR_I_H_
#define VAR_I_H_

#include <vector>
#include <iostream>

extern "C" void* new_handle_var_i();
extern "C" void  delete_handle_var_i(void* handle);
extern "C" void  set_data_var_i(void* handle, const int* array, int size);
extern "C" void  get_size_data_var_i(void* handle, int* size);
extern "C" void  get_data_var_i(void* handle, int* array);
extern "C" void  update_var_i(void* handle);


class var_i  {
private:
  void *handle;
public:
  // constructors
  var_i()  { handle = new_handle_var_i(); }
  
  var_i(const std::vector<int> &arr) {
  	handle = new_handle_var_i();
    ::set_data_var_i(handle, &arr[0], arr.size());
  }
  
  
  // methods
  void set_data(const std::vector<int>& arr) {
       ::set_data_var_i(handle, &arr[0], arr.size());
  }

  std::vector<int> get_data() {
    int size;
    ::get_size_data_var_i(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_var_i(handle, &array[0]);
    return array;
  }
  
   void update() { ::update_var_i(handle); }
  
  // destructor 
  ~var_i() { delete_handle_var_i(handle); }
};

#endif
