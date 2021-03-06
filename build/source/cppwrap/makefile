
# current directory
CURDIR = /home/stiff/summa/build/source/cppwrap
# summa directory
LIBDIR = /home/stiff/summa/build


all: compile_c link message
FC = gfortran
CC = g++

CFILES = test.cc

lib:
	@-$(MAKE) -C $(LIBDIR)
	@-cp $(LIBDIR)/libsumma4chm.so $(CURDIR)

compile_c:
	@$(CC) -c $(CFILES)
	
link:
	@$(CC) -L$(CURDIR) -o program test.o -lsumma4chm -llapack -l$(FC)
	
# make library available at runtime
message:
	@echo IMORTANT, library will be available at runtime using the following command: 
	export LD_LIBRARY_PATH=$(CURDIR):$LD_LIBRARY_PATH
	
clean:
	rm *.o program 



 
