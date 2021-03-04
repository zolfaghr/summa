
#ifndef SUMMA_H_
#define SUMMA_H_

#include <vector>
#include <iostream>

// flagVec 
extern "C" void* new_handle_flagVec();
extern "C" void  delete_handle_flagVec(void* handle);
extern "C" void  set_data_flagVec(void* handle, const int* array, int size);
extern "C" void  get_size_data_flagVec(void* handle, int* size);
extern "C" void  get_data_flagVec(void* handle, int* array);

// var_i 
extern "C" void* new_handle_var_i();
extern "C" void  delete_handle_var_i(void* handle);
extern "C" void  set_data_var_i(void* handle, const int* array, int size);
extern "C" void  get_size_data_var_i(void* handle, int* size);
extern "C" void  get_data_var_i(void* handle, int* array);

// var_i8 
extern "C" void* new_handle_var_i8();
extern "C" void  delete_handle_var_i8(void* handle);
extern "C" void  set_data_var_i8(void* handle, const int* array, int size);
extern "C" void  get_size_data_var_i8(void* handle, int* size);
extern "C" void  get_data_var_i8(void* handle, int* array);

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

// i8length
extern "C" void* new_handle_i8length();
extern "C" void  delete_handle_i8length(void* handle);
extern "C" void  set_data_i8length(void* handle, const int* array, int size);
extern "C" void  get_size_data_i8length(void* handle, int* size);
extern "C" void  get_data_i8length(void* handle, int* array);

// dlength
extern "C" void* new_handle_dlength();
extern "C" void  delete_handle_dlength(void* handle);
extern "C" void  set_data_dlength(void* handle, const double* array, int size);
extern "C" void  get_size_data_dlength(void* handle, int* size);
extern "C" void  get_data_dlength(void* handle, double* array);

// var_flagVec
extern "C" void* new_handle_var_flagVec();
extern "C" void  delete_handle_var_flagVec(void* handle);
extern "C" void  set_data_var_flagVec(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
extern "C" void  get_size_data_var_flagVec(void* handle, int* num_var, int* num_dat);
extern "C" void  get_data_var_flagVec(void* handle, int* array);

// var_ilength
extern "C" void* new_handle_var_ilength();
extern "C" void  delete_handle_var_ilength(void* handle);
extern "C" void  set_data_var_ilength(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
extern "C" void  get_size_data_var_ilength(void* handle, int* num_var, int* num_dat);
extern "C" void  get_data_var_ilength(void* handle, int* array);

// var_i8length
extern "C" void* new_handle_var_i8length();
extern "C" void  delete_handle_var_i8length(void* handle);
extern "C" void  set_data_var_i8length(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
extern "C" void  get_size_data_var_i8length(void* handle, int* num_var, int* num_dat);
extern "C" void  get_data_var_i8length(void* handle, int* array);

// var_dlength
extern "C" void* new_handle_var_dlength();
extern "C" void  delete_handle_var_dlength(void* handle);
extern "C" void  set_data_var_dlength(void* handle, const double* array, int num_row, const int* num_col, int num_elements);
extern "C" void  get_size_data_var_dlength(void* handle, int* num_var, int* num_dat);
extern "C" void  get_data_var_dlength(void* handle, double* array);


extern "C" void  solveCoupledEM(void* h1, void* h2, void* h3, void* h4);


void set_var_dlength(const std::vector<std::vector<double>> &mat, void *handle);
std::vector<std::vector<double>> get_data_var_dlength(void* handle);




class Summa  {
private:
  void *handle_flagVec;
  void *handle_type_;
  void *handle_var_i8;
  void *handle_attr_;
  void *handle_forc_;
  void *handle_ilength;
  void *handle_i8length;
  void *handle_dlength;
  void *handle_var_flagVec;
  void *handle_var_ilength;
  void *handle_var_i8length;
  void *handle_mpar_;
public:
  // ************* CONSTRUCTOR *************
  Summa()  { 
    handle_flagVec = new_handle_flagVec();
  	handle_type_ = new_handle_var_i();
  	handle_var_i8 = new_handle_var_i8();
  	handle_attr_ = new_handle_var_d();
  	handle_forc_ = new_handle_var_d();
  	handle_i8length = new_handle_i8length();
  	handle_ilength = new_handle_ilength();
  	handle_dlength = new_handle_dlength();
  	handle_var_flagVec = new_handle_var_flagVec();
  	handle_var_ilength = new_handle_var_ilength();
  	handle_var_i8length = new_handle_var_i8length();
  	handle_mpar_ = new_handle_var_dlength();
  }
  
  
  // ************* METHODS *************
  
  // set data 
  void set_flagVec(const std::vector<int>& arr_i) {
       ::set_data_flagVec(handle_flagVec, &arr_i[0], arr_i.size());
  }
  
  void set_type(const std::vector<int>& arr_i) {
       ::set_data_var_i(handle_type_, &arr_i[0], arr_i.size());
  }
  
  void set_var_i8(const std::vector<int>& arr_i) {
       ::set_data_var_i8(handle_var_i8, &arr_i[0], arr_i.size());
  }
  
  void set_attr(const std::vector<double> &arr_d) {
       ::set_data_var_d(handle_attr_, &arr_d[0], arr_d.size());
  }
  
  void set_forc(const std::vector<double> &arr_d) {
       ::set_data_var_d(handle_forc_, &arr_d[0], arr_d.size());
  }
  
  void set_i8length(const std::vector<int> &arr_i8length) {
       ::set_data_i8length(handle_i8length, &arr_i8length[0], arr_i8length.size());
  }
  
  void set_ilength(const std::vector<int> &arr_ilength) {
       ::set_data_ilength(handle_ilength, &arr_ilength[0], arr_ilength.size());
  }
  
  void set_dlength(const std::vector<double> &arr_dlength) {
       ::set_data_dlength(handle_dlength, &arr_dlength[0], arr_dlength.size());
  }
  
  void set_var_flagVec(const std::vector<std::vector<int>> &mat) {
  
  	   size_t num_row = mat.size();
  	   std::vector<int> num_col( num_row );
  	   std::vector<int> array;
  	   
  	   int num_elements = 0;
  	   for(size_t i=0; i<num_row; i++) {
  	   	  num_col[i] = mat[i].size();
  	   	  for(size_t j=0; j<num_col[i]; j++)
  	   	  	array.push_back(mat[i][j]);
  	   	  num_elements += num_col[i];
  	   }
  	    
       ::set_data_var_flagVec(handle_var_flagVec, &array[0], num_row, &num_col[0], num_elements);
  }
  
  void set_var_ilength(const std::vector<std::vector<int>> &mat) {
  
  	   size_t num_row = mat.size();
  	   std::vector<int> num_col( num_row );
  	   std::vector<int> array;
  	   
  	   int num_elements = 0;
  	   for(size_t i=0; i<num_row; i++) {
  	   	  num_col[i] = mat[i].size();
  	   	  for(size_t j=0; j<num_col[i]; j++)
  	   	  	array.push_back(mat[i][j]);
  	   	  num_elements += num_col[i];
  	   }
  	    
       ::set_data_var_ilength(handle_var_ilength, &array[0], num_row, &num_col[0], num_elements);
  }
  
  void set_var_i8length(const std::vector<std::vector<int>> &mat) {
  
  	   size_t num_row = mat.size();
  	   std::vector<int> num_col( num_row );
  	   std::vector<int> array;
  	   
  	   int num_elements = 0;
  	   for(size_t i=0; i<num_row; i++) {
  	   	  num_col[i] = mat[i].size();
  	   	  for(size_t j=0; j<num_col[i]; j++)
  	   	  	array.push_back(mat[i][j]);
  	   	  num_elements += num_col[i];
  	   }
  	    
       ::set_data_var_i8length(handle_var_i8length, &array[0], num_row, &num_col[0], num_elements);
  }
  
  
  void set_mpar(const std::vector<std::vector<double>> &mat) {
  	   ::set_var_dlength(mat, handle_mpar_); 
  } 
  
  // get data
  std::vector<int> get_data_flagVec() {
    int size;
    ::get_size_data_flagVec(handle_flagVec, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_flagVec(handle_flagVec, &array[0]);
    return array;
  }
  
  std::vector<int> get_type() {
    int size;
    ::get_size_data_var_i(handle_type_, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_var_i(handle_type_, &array[0]);
    return array;
  }

  std::vector<int> get_data_var_i8() {
    int size;
    ::get_size_data_var_i8(handle_var_i8, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_var_i8(handle_var_i8, &array[0]);
    return array;
  }
    
  std::vector<double> get_attr() {
    int size;
    ::get_size_data_var_d(handle_attr_, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    ::get_data_var_d(handle_attr_, &array[0]);
    return array;
  }
  
  std::vector<double> get_forc() {
    int size;
    ::get_size_data_var_d(handle_forc_, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    ::get_data_var_d(handle_forc_, &array[0]);
    return array;
  }
  
  std::vector<int> get_data_i8length() {
    int size;
    ::get_size_data_i8length(handle_i8length, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    ::get_data_i8length(handle_i8length, &array[0]);
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
  
  std::vector<std::vector<int>> get_data_var_flagVec() {
    int num_row;
    std::vector<int> num_col(num_row);
    ::get_size_data_var_flagVec(handle_var_flagVec, &num_row, &num_col[0]);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    ::get_data_var_flagVec(handle_var_flagVec, &array[0]);
    
    std::vector<std::vector<int>> mat(num_row);
    for(size_t i=0; i<num_row; i++)
    	mat[i] = std::vector<int>(num_col[i]);

    num_elem = 0;
    for(size_t i=0; i<num_row; i++){
    	for(size_t j=0; j<num_col[i]; j++)
    		mat[i][j] = array[num_elem + j];
    	num_elem += num_col[i];    		
    }
    
    
    return mat;
  }
  
  std::vector<std::vector<int>> get_data_var_ilength() {
    int num_row;
    std::vector<int> num_col(num_row);
    ::get_size_data_var_ilength(handle_var_ilength, &num_row, &num_col[0]);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    ::get_data_var_ilength(handle_var_ilength, &array[0]);
    
    std::vector<std::vector<int>> mat(num_row);
    for(size_t i=0; i<num_row; i++)
    	mat[i] = std::vector<int>(num_col[i]);

    num_elem = 0;
    for(size_t i=0; i<num_row; i++){
    	for(size_t j=0; j<num_col[i]; j++)
    		mat[i][j] = array[num_elem + j];
    	num_elem += num_col[i];    		
    }
    
    
    return mat;
  }
  
  std::vector<std::vector<int>> get_data_var_i8length() {
    int num_row;
    std::vector<int> num_col(num_row);
    ::get_size_data_var_i8length(handle_var_i8length, &num_row, &num_col[0]);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    ::get_data_var_i8length(handle_var_i8length, &array[0]);
    
    std::vector<std::vector<int>> mat(num_row);
    for(size_t i=0; i<num_row; i++)
    	mat[i] = std::vector<int>(num_col[i]);

    num_elem = 0;
    for(size_t i=0; i<num_row; i++){
    	for(size_t j=0; j<num_col[i]; j++)
    		mat[i][j] = array[num_elem + j];
    	num_elem += num_col[i];    		
    }
    
    
    return mat;
  }
  
  std::vector<std::vector<double>> get_mpar() {
    return ::get_data_var_dlength(handle_mpar_);
  }
  
  
  // ************* METHODS FROM SUMMA SUBROUTINES *************
  
   void coupled_em() {
    ::solveCoupledEM(handle_type_,
    				 handle_attr_,
    				 handle_forc_,
    				 handle_mpar_
    				);
   }
  
  // ************* DESTRUCTOR *************
  ~Summa() { 
    delete_handle_flagVec(handle_flagVec);
  	delete_handle_var_i(handle_type_);
  	delete_handle_var_i8(handle_var_i8);
  	delete_handle_var_d(handle_attr_);
  	delete_handle_var_d(handle_forc_);
  	delete_handle_ilength(handle_ilength);
  	delete_handle_i8length(handle_i8length);
  	delete_handle_dlength(handle_dlength);
  	delete_handle_var_flagVec(handle_var_flagVec);
  	delete_handle_var_ilength(handle_var_ilength);
  	delete_handle_var_i8length(handle_var_i8length);
  	delete_handle_var_dlength(handle_mpar_);
   }
};

  void set_var_dlength(const std::vector<std::vector<double>> &mat, void *handle) {
  
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
  	    
       set_data_var_dlength(handle, &array[0], num_row, &num_col[0], num_elements);
  }
  
  std::vector<std::vector<double>> get_data_var_dlength(void* handle) {
    int num_row;
    std::vector<int> num_col(num_row);
    get_size_data_var_dlength(handle, &num_row, &num_col[0]);
    if (num_row == 0) return std::vector<std::vector<double>>();
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<double> array(num_elem);

    get_data_var_dlength(handle, &array[0]);
    
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

#endif
