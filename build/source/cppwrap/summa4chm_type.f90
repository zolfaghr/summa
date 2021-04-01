
MODULE summa4chm_type
! used to define master summa data structure
! *****************************************************************************
! * higher-level derived data types
! *****************************************************************************
USE nrtype          ! variable types, etc.
USE data_types,only:&
                    ! no spatial dimension
                    var_i,               & ! x%var(:)            (i4b)
                    var_i8,              & ! x%var(:)            (i8b)
                    var_d,               & ! x%var(:)            (dp)
                    var_ilength,         & ! x%var(:)%dat        (i4b)
                    var_dlength            ! x%var(:)%dat        (dp)
implicit none
private

! ************************************************************************
! * master summa data type
! *****************************************************************************
type, public :: summa4chm_type_dec

    ! define the statistics structures
    type(var_dlength)          :: forcStat                   ! x%var(:)%dat -- model forcing data
    type(var_dlength)          :: progStat                   ! x%var(:)%dat -- model prognostic (state) variables
    type(var_dlength)          :: diagStat                   ! x%var(:)%dat -- model diagnostic variables
    type(var_dlength)          :: fluxStat                   ! x%var(:)%dat -- model fluxes
    type(var_dlength)          :: indxStat                   ! x%var(:)%dat -- model indices
    type(var_dlength)          :: bvarStat                   ! x%var(:)%dat -- basin-average variabl

    ! define the primary data structures (scalars)
    type(var_i)                :: timeStruct                 ! x%var(:)                   -- model time data
    type(var_d)                :: forcStruct                 ! x%var(:)     -- model forcing data
    type(var_d)                :: attrStruct                 ! x%var(:)     -- local attributes for each HRU
    type(var_i)                :: typeStruct                 ! x%var(:)     -- local classification of soil veg etc. for each HRU
    type(var_i8)               :: idStruct                   ! x%var(:)     --

    ! define the primary data structures (variable length vectors)
    type(var_ilength)          :: indxStruct                 ! x%var(:)%dat -- model indices
    type(var_dlength)          :: mparStruct                 ! x%var(:)%dat -- model parameters
    type(var_dlength)          :: progStruct                 ! x%var(:)%dat -- model prognostic (state) variables
    type(var_dlength)          :: diagStruct                 ! x%var(:)%dat -- model diagnostic variables
    type(var_dlength)          :: fluxStruct                 ! x%var(:)%dat -- model fluxes

    ! define the basin-average structures
    type(var_d)                :: bparStruct                 ! x%var(:)            -- basin-average parameters
    type(var_dlength)          :: bvarStruct                 ! x%gru(:)%var(:)%dat        -- basin-average variables

    ! define the ancillary data structures
    type(var_d)                :: dparStruct                 ! x%gru(:)%hru(:)%var(:)     -- default model parameters

    ! define the run-time variables
    integer(i4b)               :: computeVegFlux             ! flag to indicate if we are computing fluxes over vegetation (.false. means veg is buried with snow)
    real(dp)                   :: dt_init                    ! used to initialize the length of the sub-step for each HRU
    real(dp)                   :: upArea                     ! area upslope of each HRU

    ! define miscellaneous variables
    integer(i4b)               :: summa1open                 ! flag to define if the summa file is open??
    integer(i4b)               :: numout                     ! number of output variables??
    real(dp)                   :: ts                         ! model time step ??
    integer(i4b)               :: nGRU                       ! number of grouped response units
    integer(i4b)               :: nHRU                       ! number of global hydrologic response units
    integer(i4b)               :: hruCount                   ! number of local hydrologic response units
    real(dp),dimension(12)     :: greenVegFrac_monthly       ! fraction of green vegetation in each month (0-1)
    character(len=256)         :: summaFileManagerFile       ! path/name of file defining directories and files

end type summa4chm_type_dec

END MODULE summa4chm_type
