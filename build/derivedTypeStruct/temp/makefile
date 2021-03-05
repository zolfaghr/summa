
all: compile_f compile_c link
FC = gfortran
CC = g++

FFILES = nrtype.f90 data_type.f90 cppwrap_data_type.f90 coupled_em.f90 wrapper_coupled_em.f90 
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program nrtype.o data_type.o cppwrap_data_type.o coupled_em.o wrapper_coupled_em.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
