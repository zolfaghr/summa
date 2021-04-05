
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
    void  set_data_var_i8(void* handle, const long int* array, int size);
    void  get_size_data_var_i8(void* handle, int* size);
    void  get_data_var_i8(void* handle, long int* array);

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
    void  set_data_i8length(void* handle, const long int* array, int size);
    void  get_size_data_i8length(void* handle, int* size);
    void  get_data_i8length(void* handle, long int* array);

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
    void  set_data_var_i8length(void* handle, const long int* array, int num_row, const int* num_col, int num_elements);
    void  get_size_var_i8length(void* handle, int* num_var);
    void  get_size_data_var_i8length(void* handle, int* num_var, int* num_dat);
    void  get_data_var_i8length(void* handle, long int* array);

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

	void  SummaInit( void* h1, void* h2, void* h3, void* h4, void* h5, void* h6, void* h7, void* h8, void* h9, void* h10,
    				 void* h11, void* h12, void* h13, void* h14, void* h15, void* h16, void* h17, void* h18, void* h19,
    				 int* err);
    				 
	void  SetupParam( void* h1, void* h2, void* h3, void* h4, void* h5, void* h6, void* h7, double* upArea, int* err);
    				 
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
  
  void set_var_i8(const std::vector<long int>& arr_i, void* handle) {
       ::set_data_var_i8(handle, &arr_i[0], arr_i.size());
  }
  
  void set_i8length(const std::vector<long int> &arr_i8length, void* handle) {
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
  
  void set_var_i8length(const std::vector<std::vector<long int>> &mat, void* handle) {
  
  	   size_t num_row = mat.size();
  	   std::vector<int> num_col( num_row );
  	   std::vector<long int> array;
  	   
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
  
  std::vector<long int> get_var_i8(void* handle) {
    int size;
    get_size_data_var_i8(handle, &size);
    if (size == 0) return std::vector<long int>();

    std::vector<long int> array(size);
    get_data_var_i8(handle, &array[0]);
    return array;
  }
  
  std::vector<long int> get_i8length(void* handle) {
    int size;
    get_size_data_i8length(handle, &size);
    if (size == 0) return std::vector<long int>();

    std::vector<long int> array(size);
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
  
  std::vector<std::vector<long int>> get_var_i8length(void* handle) {
    int num_row;
    get_size_var_i8length(handle, &num_row);
    if (num_row == 0) return std::vector<std::vector<long int>>();
    
    std::vector<int> num_col(num_row);
    get_size_data_var_i8length(handle, &num_row, &num_col[0]);
    
    int num_elem = 0;
    for(int i=0; i<num_row; i++)
    	num_elem += num_col[i];   	

    std::vector<long int> array(num_elem);

    get_data_var_i8length(handle, &array[0]);
    
    std::vector<std::vector<long int>> mat(num_row);
    for(size_t i=0; i<num_row; i++)
    	mat[i] = std::vector<long int>(num_col[i]);

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

class Summa {

private: 
/*********************** summa4chm_type ****************************/
   // statistics structures
  void  *handle_forcStat_,			// model forcing data	
     	*handle_progStat_,			// model prognostic (state) variables                   
        *handle_diagStat_,			// model diagnostic variables                  
        *handle_fluxStat_,			// model fluxes                 
        *handle_indxStat_,			// model indices            
        *handle_bvarStat_,			// basin-average variables  
   // primary data structures (scalars)
        *handle_timeStruct_,		// model time data
    	*handle_forcStruct_,		// model forcing data
    	*handle_attrStruct_,		// local attributes for each HRU
    	*handle_typeStruct_,		// local classification of soil veg etc. for each HRU
    	*handle_idStruct_,		
   // primary data structures (variable length vectors)
    	*handle_indxStruct_,		// model indices
    	*handle_mparStruct_,		// model parameters
    	*handle_progStruct_,		// model prognostic (state) variables
    	*handle_diagStruct_,		// model diagnostic variables
    	*handle_fluxStruct_,		// model fluxes     
   // basin-average structures
    	*handle_bparStruct_,		// basin-average parameters
    	*handle_bvarStruct_,		// basin-average variables
   // ancillary data structures
    	*handle_dparStruct_;		// default model parameters    	
   // run-time variables
    	int 	computeVegFlux_; 	// flag to indicate if we are computing fluxes over vegetation
    	double  dt_init_;           // used to initialize the length of the sub-step for each HRU
    	double	upArea_;            // area upslope of each HRU
   // miscellaneous variables
    	int 	summa1open_;        // flag to define if the summa file is open??
    	int 	numout_;            // number of output variables??
    	double 	ts_;            	// model time step ??
    	int  	nGRU_;            	// number of grouped response units
    	int 	nHRU_;            	// number of global hydrologic response units
    	int 	hruCount_;          // number of local hydrologic response units
    	std::vector<double> greenVegFrac_monthly_;      // fraction of green vegetation in each month (0-1)
    	char const*         summaFileManagerFile;       // path/name of file defining directories and files

/*********************** others ****************************/
		int     err_;			    // error conotrol
		
public:

   Summa() {
   
  /************** CONSTRUCTOR *************/
        // statistics structures
   		handle_forcStat_ = new_handle_var_dlength();	
     	handle_progStat_ = new_handle_var_dlength();                   
        handle_diagStat_ = new_handle_var_dlength();                
        handle_fluxStat_ = new_handle_var_dlength();                 
        handle_indxStat_ = new_handle_var_dlength();            
        handle_bvarStat_ = new_handle_var_dlength();  
        // primary data structures (scalars)
        handle_timeStruct_ = new_handle_var_i();
    	handle_forcStruct_ = new_handle_var_d();
    	handle_attrStruct_ = new_handle_var_d();
    	handle_typeStruct_ = new_handle_var_i();
    	handle_idStruct_   = new_handle_var_i8();
    	// primary data structures (variable length vectors)
    	handle_indxStruct_ = new_handle_var_ilength();
    	handle_mparStruct_ = new_handle_var_dlength();
    	handle_progStruct_ = new_handle_var_dlength();
    	handle_diagStruct_ = new_handle_var_dlength();
    	handle_fluxStruct_ = new_handle_var_dlength();  
    	// basin-average structures
    	handle_bparStruct_ = new_handle_var_d();
    	handle_bvarStruct_ = new_handle_var_dlength();
        // ancillary data structures
    	handle_dparStruct_ = new_handle_var_d(); 
    	// miscellaneous variables
    	greenVegFrac_monthly_ = std::vector<double>(12); 
   }
   
  /*************** SET DATA **************/
  // statistics structures
  void set_forcStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_forcStat_); 
  }  
  
  void set_progStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_progStat_); 
  }
  
  void set_diagStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_diagStat_); 
  }
  
  void set_fluxStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_fluxStat_); 
  }
  
  void set_indxStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_indxStat_); 
  }
  
  void set_bvarStat(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_bvarStat_); 
  }
  
  // primary data structures (scalars)
  void set_timeStruct(const std::vector<int>& arr) {
     set_var_i(arr, handle_timeStruct_);
  }
  
  void set_forcStruct(const std::vector<double>& arr) {
     set_var_d(arr, handle_forcStruct_);
  }
  
  void set_attrStruct(const std::vector<double>& arr) {
     set_var_d(arr, handle_attrStruct_);
  }
  
  void set_typeStruct(const std::vector<int>& arr) {
     set_var_i(arr, handle_typeStruct_);
  }
  
  void set_typeStruct(const std::vector<long int>& arr) {
     set_var_i8(arr, handle_idStruct_);
  }
  
  // primary data structures (variable length vectors)
   void set_indxStruct(const std::vector<std::vector<int>> &mat) {
  	  set_var_ilength(mat, handle_indxStruct_); 
  }
  
   void set_mparStruct(const std::vector<std::vector<double>> &mat) {
  	  set_var_dlength(mat, handle_mparStruct_); 
  }
  
   void set_progStruct(const std::vector<std::vector<double>> &mat) {
  	  set_var_dlength(mat, handle_progStruct_); 
  }

   void set_diagStruct(const std::vector<std::vector<double>> &mat) {
  	  set_var_dlength(mat, handle_diagStruct_); 
  }
  
   void set_fluxStruct(const std::vector<std::vector<double>> &mat) {
  	  set_var_dlength(mat, handle_fluxStruct_); 
  }
  
  // basin-average structures
   void set_bparStruct(const std::vector<double>& arr) {
     set_var_d(arr, handle_bparStruct_);
  }
  
  void set_bvarStruct(const std::vector<std::vector<double>> &mat) {
  	   set_var_dlength(mat, handle_bvarStruct_); 
  } 
  
  // ancillary data structures
   void set_dparStruct(const std::vector<double>& arr) {
     set_var_d(arr, handle_dparStruct_);
  }  
  
  // others
  
  void set_dt(double dt) {
  	dt_init_ = dt;
  }
  
  void set_veg_fluxflag(int flag) {
  	computeVegFlux_ = flag;
  }
  
  /*************** GET DATA **************/
  // statistics structures
  std::vector<std::vector<double>> get_forcStat() {
    return get_var_dlength(handle_forcStat_);
  }  
  
  std::vector<std::vector<double>> get_progStat() {
    return get_var_dlength(handle_progStat_);
  }
  
  std::vector<std::vector<double>> get_diagStat() {
    return get_var_dlength(handle_diagStat_);
  }
  
  std::vector<std::vector<double>> get_fluxStat() {
    return get_var_dlength(handle_fluxStat_);
  }
  
  std::vector<std::vector<double>> get_indxStat() {
    return get_var_dlength(handle_indxStat_);
  }
  
  std::vector<std::vector<double>> get_bvarStat() {
    return get_var_dlength(handle_bvarStat_);
  }
  
  // primary data structures (scalars)
  std::vector<int> get_timeStruct() {
    return get_var_i(handle_timeStruct_);
  }
    
  std::vector<double> get_forcStruct() {
  	return get_var_d(handle_forcStruct_);
  }
  
  std::vector<double> get_attrStruct() {
  	return get_var_d(handle_attrStruct_);
  }
  
  std::vector<int> get_typeStruct() {
  	return get_var_i(handle_typeStruct_);
  }
  
  std::vector<long int> get_idStruct() {
  	return get_var_i8(handle_idStruct_);
  }
  
  // primary data structures (variable length vectors)
  std::vector<std::vector<int>> get_indxStruct() {
    return get_var_ilength(handle_indxStruct_);
  }
  
  std::vector<std::vector<double>> get_mparStruct() {
    return get_var_dlength(handle_mparStruct_);
  }
  
  std::vector<std::vector<double>> get_progStruct() {
    return get_var_dlength(handle_progStruct_);
  }
  
  std::vector<std::vector<double>> get_diagStruct() {
    return get_var_dlength(handle_diagStruct_);
  }
  
  std::vector<std::vector<double>> get_fluxStruct() {
    return get_var_dlength(handle_fluxStruct_);
  }
  
  // basin-average structures
  std::vector<double> get_pbarStruct() {
  	return get_var_d(handle_bparStruct_);
  }
  
  std::vector<std::vector<double>> get_bvarStruct() {
    return get_var_dlength(handle_bvarStruct_);
  }
  
  // ancillary data structures
  std::vector<double> get_dparStruct() {
  	return get_var_d(handle_dparStruct_);
  }
  
  // others  
  int get_err() { return err_; }
 
  
  /***** METHODS FROM SUMMA SUBROUTINES ****/
   
   void summa_initialize() {
		SummaInit(
  				handle_forcStat_, 				 
  				handle_progStat_,				 
  				handle_diagStat_,				
  				handle_fluxStat_,				 
  				handle_indxStat_,				 
  				handle_bvarStat_,				
  				handle_timeStruct_,				
  				handle_forcStruct_,				
  				handle_attrStruct_,				
  				handle_typeStruct_,				
  				handle_idStruct_,				
				handle_indxStruct_,			
  				handle_mparStruct_,				
  				handle_progStruct_,				
  				handle_diagStruct_,				
  				handle_fluxStruct_,				
  				handle_bparStruct_,				
  				handle_bvarStruct_,				
  				handle_dparStruct_,
  				&err_
  				);				   
   }
   
   
   void summa_paramSetup() {
		SetupParam(
  				handle_attrStruct_,				
  				handle_typeStruct_,				
  				handle_idStruct_,							
  				handle_mparStruct_,				
  				handle_bparStruct_,				
  				handle_bvarStruct_,				
  				handle_dparStruct_,
  				&upArea_,
  				&err_
  				);				   
   }
  
   void coupled_em() {
   		SolveCoupledEM(
   					 &dt_init_,
   					 &computeVegFlux_,
   					 handle_typeStruct_,
    				 handle_attrStruct_,
    				 handle_forcStruct_,
    				 handle_mparStruct_,
    				 handle_bvarStruct_,
    				 handle_indxStruct_,
    				 handle_progStruct_,
    				 handle_diagStruct_,
    				 handle_fluxStruct_,
    				 &err_
    				);
   }
  
  /************** DESTRUCTOR *************/
  ~Summa() { 
  		 // statistics structures
   		 delete_handle_var_dlength(handle_forcStat_);	
     	 delete_handle_var_dlength(handle_progStat_);                   
         delete_handle_var_dlength(handle_diagStat_);                
         delete_handle_var_dlength(handle_fluxStat_);                 
         delete_handle_var_dlength(handle_indxStat_);            
         delete_handle_var_dlength(handle_bvarStat_);  
         // primary data structures (scalars)
         delete_handle_var_i(handle_timeStruct_);
    	 delete_handle_var_d(handle_forcStruct_);
    	 delete_handle_var_d(handle_attrStruct_);
    	 delete_handle_var_i(handle_typeStruct_);
    	 delete_handle_var_i8(handle_idStruct_);
    	 // primary data structures (variable length vectors)
    	 delete_handle_var_ilength(handle_indxStruct_);
    	 delete_handle_var_dlength(handle_mparStruct_);
    	 delete_handle_var_dlength(handle_progStruct_);
    	 delete_handle_var_dlength(handle_diagStruct_);
    	 delete_handle_var_dlength(handle_fluxStruct_);  
    	 // basin-average structures
    	 delete_handle_var_d(handle_bparStruct_);
    	 delete_handle_var_dlength(handle_bvarStruct_);
         // ancillary data structures
    	 delete_handle_var_d(handle_dparStruct_); 
   }
};


#endif
