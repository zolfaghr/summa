# parent directory of the 'build' directory
F_MASTER = /home/stiff/summa

# fortran compiler
FC = gfortran
FC_EXE = /usr/bin/gfortran-7

# libraries
INCLUDES = -I/usr/include -I/usr/share/doc/liblapack3 -I/usr/lib/x86_64-linux-gnu -I/usr/local/include \
            -I/usr/local/lib -I/usr/local/fortran 
LIBRARIES = -llapack -lgfortran -lnetcdff -lnetcdf

# define compiler flags
FLAGS_NOAH = -O3 -ffree-form -fdefault-real-8 -ffree-line-length-none -fmax-errors=0 -fPIC
FLAGS_COMM = -O3 -ffree-line-length-none -fmax-errors=0 -fPIC
FLAGS_SUMMA = -O3 -ffree-line-length-none -fmax-errors=0 -fPIC

#========================================================================
# PART 1: Define directory paths
#========================================================================

# Core directory that contains source code
F_KORE_DIR = $(F_MASTER)/build/source

# Location of the compiled modules
MOD_PATH = $(F_MASTER)/build

# Define the directory for the executables
EXE_PATH = $(F_MASTER)/bin

#========================================================================
# PART 2: Assemble all of the SUMMA sub-routines
#========================================================================

# Define directories
DRIVER_DIR = $(F_KORE_DIR)/driver
HOOKUP_DIR = $(F_KORE_DIR)/hookup
NETCDF_DIR = $(F_KORE_DIR)/netcdf
DSHARE_DIR = $(F_KORE_DIR)/dshare
NUMREC_DIR = $(F_KORE_DIR)/numrec
NOAHMP_DIR = $(F_KORE_DIR)/noah-mp
ENGINE_DIR = $(F_KORE_DIR)/engine

#  utilities
SUMMA_NRUTIL= \
		nrtype.f90 \
		f2008funcs.f90 \
		nr_utility.f90
NRUTIL = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_NRUTIL))

# Numerical recipes procedures
# NOTE: all numerical recipes procedures are now replaced with free versions
SUMMA_NRPROC= \
		expIntegral.f90 \
		spline_int.f90
NRPROC = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_NRPROC))

# Hook-up modules (set files and directory paths)
SUMMA_HOOKUP= \
		ascii_util.f90 \
		summaFileManager.f90
HOOKUP = $(patsubst %, $(HOOKUP_DIR)/%, $(SUMMA_HOOKUP))

# Data modules
SUMMA_DATAMS= \
		multiconst.f90 \
		var_lookup.f90 \
		data_types.f90 \
		globalData.f90 \
		flxMapping.f90 \
		get_ixname.f90 \
		popMetadat.f90 \
		outpt_stat.f90
DATAMS = $(patsubst %, $(DSHARE_DIR)/%, $(SUMMA_DATAMS))

# utility modules
SUMMA_UTILMS= \
		time_utils.f90 \
		mDecisions.f90 \
		snow_utils.f90 \
		soil_utils.f90 \
		updatState.f90 \
		matrixOper.f90
UTILMS = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_UTILMS))

# Model guts
SUMMA_MODGUT= \
		MODGUT = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_MODGUT))

# Solver
SUMMA_SOLVER= \
		vegPhenlgy.f90 \
		diagn_evar.f90 \
		stomResist.f90 \
		groundwatr.f90 \
		vegSWavRad.f90 \
		vegNrgFlux.f90 \
		ssdNrgFlux.f90 \
		vegLiqFlux.f90 \
		snowLiqFlx.f90 \
		soilLiqFlx.f90 \
		bigAquifer.f90 \
		computFlux.f90 \
		computResid.f90 \
		computJacob.f90 \
		eval8summa.f90 \
		summaSolve.f90 \
		systemSolv.f90 \
		varSubstep.f90 \
		opSplittin.f90 \
		coupled_em.f90 \
		run_oneHRU.f90 \
		run_oneGRU.f90
SOLVER = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_SOLVER))

# Define routines for SUMMA preliminaries
SUMMA_PRELIM= \
		conv_funcs.f90 \
		sunGeomtry.f90 \
		convE2Temp.f90 \
		allocspace.f90 \
		checkStruc.f90 \
		childStruc.f90 \
		ffile_info.f90 \
		read_attrb.f90 \
		read_pinit.f90 \
		pOverwrite.f90 \
		read_param.f90 \
		paramCheck.f90 \
		check_icond.f90
PRELIM = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_PRELIM))

SUMMA_NOAHMP= \
		module_model_constants.F \
		module_sf_noahutl.F \
		module_sf_noahlsm.F \
		module_sf_noahmplsm.F

NOAHMP = $(patsubst %, $(NOAHMP_DIR)/%, $(SUMMA_NOAHMP))

# Define routines for the SUMMA model runs
SUMMA_MODRUN = \
		indexState.f90 \
		getVectorz.f90 \
		updateVars.f90 \
		var_derive.f90 \
		read_force.f90 \
		derivforce.f90 \
		snowAlbedo.f90 \
		canopySnow.f90 \
		tempAdjust.f90 \
		snwCompact.f90 \
		layerMerge.f90 \
		layerDivide.f90 \
		volicePack.f90 \
		qTimeDelay.f90
MODRUN = $(patsubst %, $(ENGINE_DIR)/%, $(SUMMA_MODRUN))

# Define routines for the solver
SUMMA_MSOLVE = \

# Define NetCDF routines
SUMMA_NETCDF = \
		netcdf_util.f90 \
		def_output.f90 \
		modelwrite.f90 \
		read_icond.f90
NETCDF = $(patsubst %, $(NETCDF_DIR)/%, $(SUMMA_NETCDF))

# ... stitch together common programs
COMM_ALL = $(NRUTIL) $(NRPROC) $(HOOKUP) $(DATAMS) $(UTILMS)

# ... stitch together SUMMA programs
SUMMA_ALL = $(NETCDF) $(PRELIM) $(MODRUN) $(SOLVER)

# Define the driver routine
SUMMA_DRIVER= \
		summa_type.f90 \
		summa_util.f90 \
		summa_alarms.f90 \
		summa_globalData.f90 \
		summa_defineOutput.f90 \
		summa_init.f90 \
		summa_setup.f90 \
		summa_restart.f90 \
		summa_forcing.f90 \
		summa_modelRun.f90 \
		summa_writeOutput.f90 \
		summa_driver.f90
DRIVER = $(patsubst %, $(DRIVER_DIR)/%, $(SUMMA_DRIVER))

#========================================================================
# PART 3: Checks
#======================================================================
# make sure that the paths are defined. These are just some high level checks
ifndef F_MASTER
 $(error F_MASTER is undefined)
endif
ifndef FC
 $(error FC is undefined: Specify your compiler)
endif
ifndef FC_EXE
 $(error FC_EXE is undefined: Specify your compiler executable)
endif
ifndef FLAGS_SUMMA
 $(error Specify flags for your compiler: $(FC))
endif
ifndef INCLUDES
 $(error INCLUDES is undefined)
endif
ifndef LIBRARIES
 $(error LIBRARIES is undefined)
endif

#========================================================================
# PART 4: compilation
#======================================================================

# Compile
all: compile_noah compile_comm compile_summa link clean


# compile Noah-MP routines
compile_noah:
	$(FC_EXE) $(FLAGS_NOAH) -c $(NOAHMP)

# compile common routines
compile_comm:
	$(FC_EXE) $(FLAGS_COMM) -c $(COMM_ALL) $(INCLUDES)

# compile SUMMA routines
compile_summa: 
	$(FC_EXE) $(FLAGS_SUMMA) -c $(SUMMA_ALL) $(DRIVER) $(INCLUDES)
# generate library
link:   
	$(FC_EXE) -shared *.o -o libsumma4chm.so  
# Remove object files
clean:
	rm -f *.o
	rm -f *.mod
	rm -f soil_veg_gen_parm__genmod.f90




