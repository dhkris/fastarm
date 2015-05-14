
#compiler configuration
CFLAGS= -I ./header/

#folder prefixes
ASM=-I lib/ lib
HEADERS=header
TESTSRC=test
BUILDTMP=build
TESTBINOUT=testbin
LIBOUT=bin

# Build everything
all: test_sumf test_avgf test_productf test_sqrt32 test_vecmultiplyf test_vecfusedmultiplyf test_crypt_rc4 library

library: lib_sqrt32.o lib_sumf.o lib_avgf.o lib_maximumf.o lib_productf.o lib_vecmultiplyf.o lib_vecfusedmultiplyopsf.o lib_crypt_rc4.o
	cc -shared -o ${LIBOUT}/libfastarm.so \
	${BUILDTMP}/lib_sqrt32.o \
	${BUILDTMP}/lib_sumf.o \
	${BUILDTMP}/lib_avgf.o \
	${BUILDTMP}/lib_maximumf.o \
	${BUILDTMP}/lib_productf.o \
	${BUILDTMP}/lib_vecmultiplyf.o \
	${BUILDTMP}/lib_vecfusedmultiplyopsf.o \
	${BUILDTMP}/lib_crypt_rc4.o 

lib_sqrt32.o:
	as ${ASM}/fa_sqrt32.s -o ${BUILDTMP}/lib_sqrt32.o
test_sqrt32: lib_sqrt32.o
	cc -c ${TESTSRC}/test_sqrt32.c -o ${BUILDTMP}/test_sqrt32.o ${CFLAGS}
	cc ${BUILDTMP}/lib_sqrt32.o ${BUILDTMP}/test_sqrt32.o -o ${TESTBINOUT}/test_sqrt32

##### Floating point operations ####
# FP32 summing
lib_sumf.o:
	as ${ASM}/fa_sumf.s -o ${BUILDTMP}/lib_sumf.o
test_sumf: lib_sumf.o
	cc -c ${TESTSRC}/test_sumf.c -o ${BUILDTMP}/test_sumf.o ${CFLAGS}
	cc ${BUILDTMP}/lib_sumf.o ${BUILDTMP}/test_sumf.o -o ${TESTBINOUT}/test_sumf

# FP32 average
lib_avgf.o:
	as ${ASM}/fa_avgf.s -o ${BUILDTMP}/lib_avgf.o
test_avgf: lib_avgf.o
	cc -c ${TESTSRC}/test_avgf.c -o ${BUILDTMP}/test_avgf.o ${CFLAGS}
	cc ${BUILDTMP}/lib_avgf.o ${BUILDTMP}/test_avgf.o -o ${TESTBINOUT}/test_avgf
	
lib_maximumf.o: 
	as ${ASM}/fa_maximumf.s -o ${BUILDTMP}/lib_maximumf.o	
	
# FP32 product
lib_productf.o: lib_maximumf.o
	as ${ASM}/fa_productf.s -o ${BUILDTMP}/lib_productf.o
test_productf: lib_productf.o
	cc -c ${TESTSRC}/test_productf.c -o ${BUILDTMP}/test_productf.o ${CFLAGS}
	cc ${BUILDTMP}/lib_productf.o ${BUILDTMP}/lib_maximumf.o  ${BUILDTMP}/test_productf.o -o ${TESTBINOUT}/test_productf


# FP32 vector multiply
lib_vecmultiplyf.o:
	as ${ASM}/fa_vecmultiplyf.s -o ${BUILDTMP}/lib_vecmultiplyf.o
test_vecmultiplyf: lib_vecmultiplyf.o
	cc -c ${TESTSRC}/test_vecmultiplyf.c -o ${BUILDTMP}/test_vecmultiplyf.o ${CFLAGS}
	cc ${BUILDTMP}/lib_vecmultiplyf.o ${BUILDTMP}/test_vecmultiplyf.o -o ${TESTBINOUT}/test_vecmultiplyf
	
	# FP32 vector multiply
lib_vecfusedmultiplyopsf.o:
	as ${ASM}/fa_vecfmopsf.s -o ${BUILDTMP}/lib_vecfusedmultiplyopsf.o
test_vecfusedmultiplyf: lib_vecfusedmultiplyopsf.o
	cc -c ${TESTSRC}/test_vecfusedmultiplyf.c -o ${BUILDTMP}/test_vecfusedmultiplyf.o ${CFLAGS}
	cc ${BUILDTMP}/lib_vecfusedmultiplyopsf.o ${BUILDTMP}/test_vecfusedmultiplyf.o -o ${TESTBINOUT}/test_vecfusedmultiplyf
	
lib_crypt_rc4.o:
	as ${ASM}/fa_crypt_rc4.s -o ${BUILDTMP}/lib_crypt_rc4.o
test_crypt_rc4: lib_crypt_rc4.o
	cc -c ${TESTSRC}/test_crypt_rc4.c -o ${BUILDTMP}/test_crypt_rc4.o ${CFLAGS}
	cc ${BUILDTMP}/lib_crypt_rc4.o ${BUILDTMP}/test_crypt_rc4.o -o ${TESTBINOUT}/test_crypt_rc4
		

# Utility
clean:
	rm -rf ${BUILDTMP}/*

distclean: clean
	rm -rf ${TESTBINOUT}/*
	rm -rf ${LIBOUT}/*
