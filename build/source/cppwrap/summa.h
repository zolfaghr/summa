
#ifndef SUMMA_H_
#define SUMMA_H_

#include <vector>
#include <iostream>

extern "C" {
// flagVec 
    void* new_handle_flagVec();
    void  delete_handle_flagVec(void* handle);
    void  set_data_flagVec(void* handle, const int* array, int size);
    void  get_size_data_flagVec(void* handle, int* size);
    void  get_data_flagVec(void* handle, int* array);

// var_i 
    void* new_handle_var_i();
    void  delete_handle_var_i(void* handle);
    void  set_data_var_i(void* handle, const int* array, int size);
    void  get_size_data_var_i(void* handle, int* size);
    void  get_data_var_i(void* handle, int* array);

// var_i8 
    void* new_handle_var_i8();
    void  delete_handle_var_i8(void* handle);
    void  set_data_var_i8(void* handle, const int* array, int size);
    void  get_size_data_var_i8(void* handle, int* size);
    void  get_data_var_i8(void* handle, int* array);

// var_d
    void* new_handle_var_d();
    void  delete_handle_var_d(void* handle);
    void  set_data_var_d(void* handle, const double* array, int size);
    void  get_size_data_var_d(void* handle, int* size);
    void  get_data_var_d(void* handle, double* array);

// ilength
    void* new_handle_ilength();
    void  delete_handle_ilength(void* handle);
    void  set_data_ilength(void* handle, const int* array, int size);
    void  get_size_data_ilength(void* handle, int* size);
    void  get_data_ilength(void* handle, int* array);

// i8length
    void* new_handle_i8length();
    void  delete_handle_i8length(void* handle);
    void  set_data_i8length(void* handle, const int* array, int size);
    void  get_size_data_i8length(void* handle, int* size);
    void  get_data_i8length(void* handle, int* array);

// dlength
    void* new_handle_dlength();
    void  delete_handle_dlength(void* handle);
    void  set_data_dlength(void* handle, const double* array, int size);
    void  get_size_data_dlength(void* handle, int* size);
    void  get_data_dlength(void* handle, double* array);

// var_flagVec
    void* new_handle_var_flagVec();
    void  delete_handle_var_flagVec(void* handle);
    void  set_data_var_flagVec(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
    void  get_size_var_flagVec(void* handle, int* num_var);
    void  get_size_data_var_flagVec(void* handle, int* num_var, int* num_dat);
    void  get_data_var_flagVec(void* handle, int* array);

// var_ilength
    void* new_handle_var_ilength();
    void  delete_handle_var_ilength(void* handle);
    void  set_data_var_ilength(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
    void  get_size_var_ilength(void* handle, int* num_var);
    void  get_size_data_var_ilength(void* handle, int* num_var, int* num_dat);
    void  get_data_var_ilength(void* handle, int* array);

// var_i8length
    void* new_handle_var_i8length();
    void  delete_handle_var_i8length(void* handle);
    void  set_data_var_i8length(void* handle, const int* array, int num_row, const int* num_col, int num_elements);
    void  get_size_var_i8length(void* handle, int* num_var);
    void  get_size_data_var_i8length(void* handle, int* num_var, int* num_dat);
    void  get_data_var_i8length(void* handle, int* array);

// var_dlength
    void* new_handle_var_dlength();
    void  delete_handle_var_dlength(void* handle);
    void  set_data_var_dlength(void* handle, const double* array, int num_row, const int* num_col, int num_elements);
    void  get_size_var_dlength(void* handle, int* num_var);
    void  get_size_data_var_dlength(void* handle, int* num_var, int* num_dat);
    void  get_data_var_dlength(void* handle, double* array);

// var_info 
    void* new_handle_var_info();
    void  delete_handle_var_info(void* handle);
    void  set_data_var_info(void* handle, char const *str1, char const *str2, char const *str3,
    					    int type, const int* ncid, int ncid_size, const int* index, int index_size, int flag);

// cppwrappers of summa subroutines
    void  SolveCoupledEM(const double* dt, int* flag,
    					 void* h1, void* h2, void* h3, void* h4, void* h5, void* h6, void* h7, void* h8, void* h9,
    					 int* err);

 } // extern "C"
 
/*******************************************************************/
/************************** STRUCTURES *****************************/ 
/*******************************************************************/
// var_info 
struct  VarInfo {
    char const*   		varname = "empty";
    char const*   		vardesc = "empty";
    char const*   		varunit = "empty";
    std::vector<int> 	ncVarID;
    std::vector<int> 	statIndex;
	int 		  		vartype;
	int			  		varDesire = 0;
};


/*******************************************************************/
/************************** AUXILIARY FUNCTIONS ********************/ 
/*******************************************************************/

  /*************** SET DATA **************/  
  void set_flagVec(const std::vector<int>& arr_i, void* handle) {
       set_data_flagVec(handle, &arr_i[0], arr_i.size());
  }
  
  void set_var_i(const std::vector<int>& arr_i, void* handle) {
       set_data_var_i(handle, &arr_i[0], arr_i.size());
  }
  
  void set_var_d(const std::vector<double> &arr_d, void* handle) {
       set_data_var_d(handle, &arr_d[0], arr_d.size());
  }
  
  void set_var_i8(const std::vector<int>& arr_i, void* handle) {
       ::set_data_var_i8(handle, &arr_i[0], arr_i.size());
  }
  
  void set_i8length(const std::vector<int> &arr_i8length, void* handle) {
       set_data_i8length(handle, &arr_i8length[0], arr_i8length.size());
  }
  
  void set_ilength(const std::vector<int> &arr_ilength, void* handle) {
       set_data_ilength(handle, &arr_ilength[0], arr_ilength.size());
  }
  
  void set_dlength(const std::vector<double> &arr_dlength, void* handle) {
       set_data_dlength(handle, &arr_dlength[0], arr_dlength.size());
  }
  
  void set_var_flagVec(const std::vector<std::vector<int>> &mat, void* handle) {
  
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
  	    
       set_data_var_flagVec(handle, &array[0], num_row, &num_col[0], num_elements);
  }
  
  void set_var_ilength(const std::vector<std::vector<int>> &mat, void* handle) {
  
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
  	    
       set_data_var_ilength(handle, &array[0], num_row, &num_col[0], num_elements);
  }
  
  void set_var_i8length(const std::vector<std::vector<int>> &mat, void* handle) {
  
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
  	    
       set_data_var_i8length(handle, &array[0], num_row, &num_col[0], num_elements);
  }

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
  
  void set_var_info(VarInfo v, void* handle) {
  		set_data_var_info(handle, v.varname, v.vardesc, v.varunit, v.vartype,
  	                      &v.ncVarID[0], v.ncVarID.size(),  &v.statIndex[0], v.statIndex.size(), v.varDesire);
  }

  /*************** GET DATA **************/
  
  std::vector<int> get_flagVec(void* handle) {
    int size;
    get_size_data_flagVec(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    get_data_flagVec(handle, &array[0]);
    return array;
  }
  
  std::vector<int> get_var_i(void* handle) {
    int size;
    get_size_data_var_i(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    get_data_var_i(handle, &array[0]);
    return array;
  }

    
  std::vector<double> get_var_d(void* handle) {
    int size;
    get_size_data_var_d(handle, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    get_data_var_d(handle, &array[0]);
    return array;
  }
  
  std::vector<int> get_var_i8(void* handle) {
    int size;
    get_size_data_var_i8(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    get_data_var_i8(handle, &array[0]);
    return array;
  }
  
  std::vector<int> get_i8length(void* handle) {
    int size;
    get_size_data_i8length(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    get_data_i8length(handle, &array[0]);
    return array;
  }
  
  std::vector<int> get_ilength(void* handle) {
    int size;
    get_size_data_ilength(handle, &size);
    if (size == 0) return std::vector<int>();

    std::vector<int> array(size);
    get_data_ilength(handle, &array[0]);
    return array;
  }
  
  std::vector<double> get_dlength(void* handle) {
    int size;
    get_size_data_dlength(handle, &size);
    if (size == 0) return std::vector<double>();

    std::vector<double> array(size);
    get_data_dlength(handle, &array[0]);
    return array;
  }
  
  std::vector<std::vector<int>> get_var_flagVec(void* handle) {
    int num_row;
    get_size_var_flagVec(handle, &num_row);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    std::vector<int> num_col(num_row);
    get_size_data_var_flagVec(handle, &num_row, &num_col[0]);
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    get_data_var_flagVec(handle, &array[0]);
    
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
  
  std::vector<std::vector<int>> get_var_ilength(void* handle) {
    int num_row;
    get_size_var_ilength(handle, &num_row);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    std::vector<int> num_col(num_row);
    get_size_data_var_ilength(handle, &num_row, &num_col[0]);
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    get_data_var_ilength(handle, &array[0]);
    
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
  
  std::vector<std::vector<int>> get_var_i8length(void* handle) {
    int num_row;
    get_size_var_i8length(handle, &num_row);
    if (num_row == 0) return std::vector<std::vector<int>>();
    
    std::vector<int> num_col(num_row);
    get_size_data_var_i8length(handle, &num_row, &num_col[0]);
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<int> array(num_elem);

    get_data_var_i8length(handle, &array[0]);
    
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
  
  std::vector<std::vector<double>> get_var_dlength(void* handle) {
    int num_row;
    get_size_var_dlength(handle, &num_row);
    if (num_row == 0) return std::vector<std::vector<double>>();
    
    std::vector<int> num_col(num_row);
    get_size_data_var_dlength(handle, &num_row, &num_col[0]);
    
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
  
  
/*******************************************************************/
/************************** SUMMA CLASS ****************************/ 
/*******************************************************************/

struct Block {
  double dt_init_;				// initial time step
  int	 veg_fluxflag_,			// flag to indicate if we are computing fluxes over vegetation
     	 err_;					// error conotrol
  void  *handle_type_,			// local classification of soil veg etc.
  	    *handle_attr_,			// local attributes
   		*handle_forc_,			// model forcing data
   		*handle_mpar_,			// model parameters
   		*handle_bvar_,			// basin-average model variables
   		*handle_indx_,			// model indices
   		*handle_prog_,			// model prognostic variables
   		*handle_diag_,			// model diagnostic variables
   		*handle_flux_,			// model fluxes
   		*handle_indxmeta_;
};

class Summa {

private:
	size_t n_;
	std::vector<Block> block_;
public:

  /************** CONSTRUCTOR *************/
  Summa(size_t n)  {
  	n_ = n;
  	block_ = std::vector<Block>(n);
  	for(size_t i=0; i<n; ++i) {
    	block_[i].dt_init_ = 0;
    	block_[i].veg_fluxflag_ = false;
    	block_[i].err_ = 0;     
  		block_[i].handle_type_ = new_handle_var_i();
  		block_[i].handle_attr_ = new_handle_var_d();
  		block_[i].handle_forc_ = new_handle_var_d();
  		block_[i].handle_mpar_ = new_handle_var_dlength();
  		block_[i].handle_bvar_ = new_handle_var_dlength();
  		block_[i].handle_indx_ = new_handle_var_ilength();
  		block_[i].handle_prog_ = new_handle_var_dlength();
  		block_[i].handle_diag_ = new_handle_var_dlength();
  		block_[i].handle_flux_ = new_handle_var_dlength();
  		block_[i].handle_indxmeta_ = new_handle_var_info();
  	}
  }
  
  
  /*************** SET DATA **************/
  
  void set_dt(size_t i, double dt) {
  	block_[i].dt_init_ = dt;
  }
  
  void set_veg_fluxflag(size_t i, int flag) {
  	block_[i].veg_fluxflag_ = flag;
  }
  
  void set_type(size_t i, const std::vector<int>& arr_i) {
     set_var_i(arr_i, block_[i].handle_type_);
  }
  
  void set_attr(size_t i, const std::vector<double> &arr_d) {
       set_var_d(arr_d, block_[i].handle_attr_);
  }
  
  void set_forc(size_t i, const std::vector<double> &arr_d) {
       set_var_d(arr_d, block_[i].handle_forc_);
  }
    
  void set_mpar(size_t i, const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, block_[i].handle_mpar_); 
  } 
  
  void set_bvar(size_t i, const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, block_[i].handle_bvar_); 
  } 
  
  void set_indx(size_t i, const std::vector<std::vector<int>> &mat) {
  	   set_var_ilength(mat, block_[i].handle_indx_); 
  }
  
  void set_prog(size_t i, const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, block_[i].handle_prog_); 
  }
  
  void set_diag(size_t i, const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, block_[i].handle_diag_); 
  }
  
  void set_flux(size_t i, const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, block_[i].handle_flux_); 
  }
  
  void set_indxmeta(size_t i, VarInfo &v) {
  	   set_var_info(v, block_[i].handle_indxmeta_);
  }
  
  /*************** GET DATA **************/
  
  std::vector<int> get_type(size_t i) {
    return get_var_i(block_[i].handle_type_);
  }
    
  std::vector<double> get_attr(size_t i) {
  	return get_var_d(block_[i].handle_attr_);
  }
  
  std::vector<double> get_forc(size_t i) {
	return get_var_d(block_[i].handle_forc_);
  }
  
  std::vector<std::vector<double>> get_mpar(size_t i) {
    return get_var_dlength(block_[i].handle_mpar_);
  }
  
  std::vector<std::vector<double>> get_bvar(size_t i) {
    return get_var_dlength(block_[i].handle_bvar_);
  }
  
  std::vector<std::vector<int>> get_indx(size_t i) {
    return get_var_ilength(block_[i].handle_indx_);
  }
  
  std::vector<std::vector<double>> get_prog(size_t i) {
    return get_var_dlength(block_[i].handle_prog_);
  }
  
  std::vector<std::vector<double>> get_diag(size_t i) {
    return get_var_dlength(block_[i].handle_diag_);
  }
  
  std::vector<std::vector<double>> get_flux(size_t i) {
    return get_var_dlength(block_[i].handle_flux_);
  }
  
  int get_err(size_t i) { return block_[i].err_; }
 
  
  /***** METHODS FROM SUMMA SUBROUTINES ****/
  
   void coupled_em(size_t i) {
   		SolveCoupledEM(
   					 &block_[i].dt_init_,
   					 &block_[i].veg_fluxflag_,
   					 block_[i].handle_type_,
    				 block_[i].handle_attr_,
    				 block_[i].handle_forc_,
    				 block_[i].handle_mpar_,
    				 block_[i].handle_bvar_,
    				 block_[i].handle_indx_,
    				 block_[i].handle_prog_,
    				 block_[i].handle_diag_,
    				 block_[i].handle_flux_,
    				 &block_[i].err_
    				);
   }
  
  /************** DESTRUCTOR *************/
  ~Summa() { 
  	for(size_t i=0; i<n_; ++i) {
  		delete_handle_var_i(block_[i].handle_type_);
  		delete_handle_var_d(block_[i].handle_attr_);
  		delete_handle_var_d(block_[i].handle_forc_);
  		delete_handle_var_dlength(block_[i].handle_mpar_);
  		delete_handle_var_dlength(block_[i].handle_bvar_);
  		delete_handle_var_ilength(block_[i].handle_indx_);
  		delete_handle_var_dlength(block_[i].handle_prog_);
  		delete_handle_var_dlength(block_[i].handle_diag_);
  		delete_handle_var_dlength(block_[i].handle_flux_);
  		delete_handle_var_info(block_[i].handle_indxmeta_);
  	 }
   }
};


#endif
