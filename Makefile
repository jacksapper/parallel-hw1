# On Trestles we will check versus your performance versus Intel MKL library's BLAS.

CC = gcc
OPT = -O3 -funroll-loops
CFLAGS = -Wall -std=gnu99 $(OPT)
MKLROOT = /opt/apps/intel/15/composer_xe_2015.2.164/mkl
LDLIBS = -lrt -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a $(MKLROOT)/lib/intel64/libmkl_sequential.a $(MKLROOT)/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm
#LDLIBS = -lrt -lpthread -lm

targets = benchmark-naive benchmark-blocked benchmark-blas benchmark-eigen
objects = benchmark.o dgemm-naive.o dgemm-blocked.o dgemm-blas.o dgemm-eigen.o

.PHONY : default
default : all

.PHONY : all
all : clean $(targets)

benchmark-naive : benchmark.o dgemm-naive.o
	$(CC) -o $@ $^ $(LDLIBS)
benchmark-blocked : benchmark.o dgemm-blocked.o
	$(CC) -o $@ $^ $(LDLIBS)
benchmark-blas : benchmark.o dgemm-blas.o
	$(CC) -o $@ $^ $(LDLIBS)
benchmark-eigen : benchmark.o dgemm-eigen.o
	$(CC) -o $@ $^ $(LDLIBS) -I "~/parallel-hw1/Eigen"

%.o : %.c
	$(CC) -c $(CFLAGS) $<

.PHONY : clean
clean:
	rm -f $(targets) $(objects) *.stdout
