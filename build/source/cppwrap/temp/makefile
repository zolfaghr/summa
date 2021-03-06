
all: get_files compile_f compile_c link
FC = gfortran
CC = g++

get_files:
	@-cp ../cppwrap_datatypes.f90 .
	@-cp ../cppwrap_summa.f90 .
	@-cp ../summa.h .
	

FFILES = nrtype.f90 data_types.f90 cppwrap_datatypes.f90 coupled_em.f90 cppwrap_summa.f90 
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program nrtype.o data_types.o cppwrap_datatypes.o coupled_em.o cppwrap_summa.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
