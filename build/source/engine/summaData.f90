

module summadata_module

! data types
USE nrtype

! provide access to the derived types to define the data structures
USE data_types,only:&
                    var_i,        & ! data vector (i4b)
                    var_d,        & ! data vector (dp)
                    var_ilength,  & ! data vector with variable length dimension (i4b)
                    var_dlength     ! data vector with variable length dimension (dp)

implicit none

 type summaData
 	! model control
 	integer(8)              :: hruId                  ! hruId
 	real(dp)               	:: dt_init                ! used to initialize the size of the sub-step
 	logical(lgt)           	:: computeVegFlux         ! flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
 	! data structures (input)
 	type(var_i)             :: type_data              ! type of vegetation and soil
 	type(var_d)             :: attr_data              ! spatial attributes
 	type(var_d)             :: forc_data              ! model forcing data
 	type(var_dlength)       :: mpar_data              ! model parameters
 	type(var_dlength)       :: bvar_data              ! basin-average model variables
 	! data structures (input-output)
 	type(var_ilength)      	:: indx_data              ! state vector geometry
 	type(var_dlength)      	:: prog_data              ! prognostic variables for a local HRU
 	type(var_dlength)      	:: diag_data              ! diagnostic variables for a local HRU
 	type(var_dlength)      	:: flux_data              ! model fluxes for a local HRU
 	! error control
 	character(len = 256)    :: message                ! error message
 end type summaData
 
 
end module summadata_module





