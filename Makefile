
all:
	make -f Makefile.mk
	
clean:
	make -f Makefile.mk clean

include pyOCD.mk
