
#ifndef SUMMA_H_
#define SUMMA_H_

#include <vector>
#include <iostream>

// var_i 
extern "C" void* new_handle_var_i();
extern "C" void  delete_handle_var_i(void* handle);
extern "C" void  set_data_var_i(void* handle, const int* array, int size);
extern "C" void  get_size_data_var_i(void* handle, int* size);
extern "C" void  get_data_var_i(void* handle, int* array);

// var_d
extern "C" void* new_handle_var_d();
extern "C" void  delete_handle_var_d(void* handle);
extern "C" void  set_data_var_d(void* handle, const double* array, int size);
extern "C" void  get_size_data_var_d(void* handle, int* size);
extern "C" void  get_data_var_d(void* handle, double* array);

// ilength
extern "C" void* new_handle_ilength();
extern "C" void  delete_handle_ilength(void* handle);
extern "C" void  set_data_ilength(void* handle, const int* array, int size);
extern "C" void  get_size_data_ilength(void* handle, int* size);
extern "C" void  get_data_ilength(void* handle, int* array);

// dlength
extern "C" void* new_handle_dlength();
extern "C" void  delete_handle_dlength(void* handle);
extern "C" void  set_data_dlength(void* handle, const double* array, int size);
extern "C" void  get_size_data_dlength(void* handle, int* size);
extern "C" void  get_data_dlength(void* handle, double* array);

// var_dlength
extern "C" void* new_handle_var_dlength();
extern "C" void  delete_handle_var_dlength(void* handle);
extern "C" void  set_data_var_dlength(void* handle, const double* array, int num_row, const int* num_col, int num_elements);
extern "C" void  get_size_data_var_dlength(void* handle, int* num_var, int* num_dat);
extern "C" void  get_data_var_dlength(void* handle, double* array);


extern "C" void  update_summa_data(void* handle);




class Summa  {
private:
  void *handle_var_i;
  void *handle_var_d;
  void *handle_ilength;
  void *handle_dlength;
  void *handle_var_dlength;
public:
  // ************* CONSTRUCTOR *************
  Summa()  { 
  	handle_var_i = new_handle_var_i();
  	handle_var_d = new_handle_var_d();
  	handle_ilength = new_handle_ilength();
  	handle_dlength = new_handle_dlength();
  	handle_var_dlength = new_handle_var_dlength();
  }
  
  
  // ************* METHODS *************
  // set data
  void set_var_i(const std::vector<int>& arr_i) {
       ::set_data_var_i(handle_var_i, &arr_i[0], arr_i.size());
  }
  
  void set_var_d(const std::vector<double> &arr_d) {
       ::set_data_var_d(handle_var_d, &arr_d[0], arr_d.size());
  }
  
  void set_ilength(const std::vector<int> &arr_ilength) {
       ::set_data_ilength(handle_ilength, &arr_ilength[0], arr_ilength.size());
  }
  
  void set_dlength(const std::vector<double> &arr_dlength) {
       ::set_data_dlength(handle_dlength, &arr_dlength[0], arr_dlength.size());
  }
  
  void set_var_dlength(const std::vector<std::vector<double>> &mat) {
  
  	   size_t num_row = mat.size();
  	   std::vector<int> num_col( num_row );
  	   std::vector<double> array;
  	   
  	   int num_elements = 0;
  	   for(size_t i=0; i<num_row; i++) {
  	   	  num_col[i] = mat[i].size();
  	   	  for(size_t j=0; j<num_col[i]; j++)
  	   	  	array.push_back(mat[i][j]);
  	   	  num_elements += num_col[i];
  	   }
  	    
       ::set_data_var_dlength(handle_var_dlength, &array[0], num_row, &num_col[0], num_elements);
  }
  
  
  // get data
  std::vector<int> get_data_var_i() {
    int size;
    ::get_size_data_var_i(handle_var_i, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_var_i(handle_var_i, &array[0]);
    return array;
  }
  
  std::vector<double> get_data_var_d() {
    int size;
    ::get_size_data_var_d(handle_var_d, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    ::get_data_var_d(handle_var_d, &array[0]);
    return array;
  }
  
  std::vector<int> get_data_ilength() {
    int size;
    ::get_size_data_ilength(handle_ilength, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_ilength(handle_ilength, &array[0]);
    return array;
  }
  
  std::vector<double> get_data_dlength() {
    int size;
    ::get_size_data_dlength(handle_dlength, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    ::get_data_dlength(handle_dlength, &array[0]);
    return array;
  }
  
  std::vector<std::vector<double>> get_data_var_dlength() {
    int num_row;
    std::vector<int> num_col(num_row);
    ::get_size_data_var_dlength(handle_var_dlength, &num_row, &num_col[0]);
    if (num_row == 0) return std::vector<std::vector<double>>();
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<double> array(num_elem);

    ::get_data_var_dlength(handle_var_dlength, &array[0]);
    
    std::vector<std::vector<double>> mat(num_row);
    for(size_t i=0; i<num_row; i++)
    	mat[i] = std::vector<double>(num_col[i]);

    num_elem = 0;
    for(size_t i=0; i<num_row; i++){
    	for(size_t j=0; j<num_col[i]; j++)
    		mat[i][j] = array[num_elem + j];
    	num_elem += num_col[i];    		
    }
    
    
    return mat;
  }
  
  // ************* SUMMA SUBROUTINES *************
  
   void update() {
    ::update_summa_data(handle_ilength);
   }
  
  // ************* DESTRUCTOR *************
  ~Summa() { 
  	delete_handle_var_i(handle_var_i);
  	delete_handle_var_d(handle_var_d);
  	delete_handle_ilength(handle_ilength);
  	delete_handle_dlength(handle_dlength);
  	delete_handle_var_dlength(handle_var_dlength);
   }
};

#endif
