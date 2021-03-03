
all: compile_f compile_c link
FC = gfortran
CC = g++

FFILES = nrtype.f90 data_type.f90 updateVar.f90 wrapper_var_i.f90 wrapper_var_d.f90 wrapper_dlength.f90 wrapper_summa_data.f90 \
		wrapper_ilength.f90 wrapper_var_dlength.f90 
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program nrtype.o data_type.o updateVar.o wrapper_var_i.o wrapper_var_d.o wrapper_dlength.o \
	wrapper_ilength.o wrapper_var_dlength.o wrapper_summa_data.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
