all:
	make -f Makefile.mk
	
clean:
	make -f Makefile.mk clean

load:
	make -f Makefile.mk load

server:
	make -f Makefile.mk server

debug: 
	make -f Makefile.mk debug