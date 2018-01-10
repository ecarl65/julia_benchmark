
CC=gcc
CXX=g++
CFLAGS=-pipe -Wall -O3 -D_GNU_SOURCE -fomit-frame-pointer -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3
LDFLAGS=-lm

all: mandel nbody_c nbody_cc cython_nbody2 cython_doc

mandel: mandel.c
	$(CC) -o $@ -std=c99 $(CFLAGS)  mandel.c -lm

nbody_cc: nbody.cc
	$(CXX) -o $@ -std=c++11 $(CFLAGS)  $<

nbody_c: nbody.c
	gcc -o $@ $(CFLAGS) $< $(LDFLAGS)

cython_doc: cython_nbody2.pyx 
	cython $< -a

.PHONY: cython_nbody2 clean cython_doc

cython_nbody2: cython_nbody2.pyx 
	python setup.py build_ext --inplace

clean:
	$(RM) mandel nbody_c nbody_cc cython_nbody2.so cython_nbody2.c cython_nbody2.html

