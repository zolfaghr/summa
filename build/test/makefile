
all: compile_c link lib_avalable
FC = gfortran
CC = g++

# directory
DIR = /home/stiff/summa/build/test

CFILES = test.cc

compile_c:
	@$(CC) -c $(CFILES)
	
link:
	@$(CC) -L$(DIR) -o program test.o -lsumma4chm -llapack -l$(FC)
	
# make library available at runtime
lib_avalable:
	@echo IMORTANT, library will be available at runtime using the following command: 
	export LD_LIBRARY_PATH=$(DIR):$LD_LIBRARY_PATH
	
clean:
	rm *.o program *.mod



 
