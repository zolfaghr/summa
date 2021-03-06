
all: compile_f compile_c link
FC = gfortran
CC = g++

# directory
DIR = /home/stiff/summa/build/test

FFILES = cppwrap_datatypes.f90 cppwrap_summa.f90 
CFILES = test.cc

compile_f:
	$(FC) -c $(FFILES)

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -L$(DIR) -o program cppwrap_datatypes.o coupled_em.o cppwrap_summa.o test.o -lsumma4chm -l$(FC)
	
clean:
	rm *.o program *.mod



 
