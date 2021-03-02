
all: compile_f compile_c link
FC = gfortran
CC = g++

FFILES = datatypes.f90 update_var.f90 fort_type.f90 
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program datatypes.f90 update_var.o fort_type.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
