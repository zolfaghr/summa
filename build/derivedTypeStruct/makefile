
all: compile_f compile_c link
FC = gfortran
CC = g++

FFILES = fort_type.f90 f_userdata.f90 update_var.f90
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -o program fort_type.o f_userdata.o update_var.o test.o -l$(FC)
	
clean:
	rm *.o program *.mod



 
