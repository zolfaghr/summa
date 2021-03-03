
#ifndef VAR_D_H_
#define VAR_D_H_

#include <vector>
#include <iostream>

extern "C" void* new_handle_var_d();
extern "C" void  delete_handle_var_d(void* handle);
extern "C" void  set_data_var_d(void* handle, const double* array, int size);
extern "C" void  get_size_data_var_d(void* handle, int* size);
extern "C" void  get_data_var_d(void* handle, double* array);


class var_d  {
private:
  void *handle;
public:
  // constructors
  var_d()  { handle = new_handle_var_d(); }
  
  var_d(const std::vector<double> &arr) {
  	handle = new_handle_var_d();
    ::set_data_var_d(handle, &arr[0], arr.size());
  }
  
  
  // methods
  void set_data(const std::vector<double>& arr) {
       ::set_data_var_d(handle, &arr[0], arr.size());
  }

  std::vector<double> get_data() {
    int size;
    ::get_size_data_var_d(handle, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    ::get_data_var_d(handle, &array[0]);
    return array;
  }
  
  // Destructor 
  ~var_d() { delete_handle_var_d(handle); }
};

#endif
