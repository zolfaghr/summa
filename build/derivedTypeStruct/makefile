
all: compile_f compile_c link
FC = gfortran
CC = g++

FFILES = data_type.f90 updateVar.f90 wrapper_var_i.f90 wrapper_var_d.f90 wrapper_summa_data.f90  
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program data_type.o updateVar.o wrapper_var_i.o wrapper_var_d.o wrapper_summa_data.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
