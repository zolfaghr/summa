
all: compile_c link lib_avalable
FC = gfortran
CC = g++

# libraries
INCLUDES = -I/usr/include -I/usr/share/doc/liblapack3 -I/usr/lib/x86_64-linux-gnu -I/usr/local/include \
            -I/usr/local/lib -I/usr/local/fortran 
LIBRARIES = -llapack -lgfortran -lnetcdff -lnetcdf

# directory
DIR = /home/stiff/summa/build/test

CFILES = test.cc

compile_c:
	$(CC) -c $(CFILES)
	
link:
	$(CC) -L$(DIR) -o program test.o -lsumma4chm -llapack -l$(FC) $(INCLUDES)
	
# make library available at runtime
lib_avalable:
	echo IMORTANT, before running program run the following
	export LD_LIBRARY_PATH=$(DIR):$LD_LIBRARY_PATH
	
clean:
	rm *.o program *.mod



 
