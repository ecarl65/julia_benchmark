
all: fast slow basic nbody_c nbody_cc

fast: mandel.c
	gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c -lm

slow: mandel.c
	gcc -o mandel_slow -Wall mandel.c -lm

basic: mandel.c
	gcc -o mandel_basic -Wall -O3 mandel.c -lm

nbody_cc: nbody.cc
	g++ -o nbody_cc -std=c++11 -Wall -pipe -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3  nbody.cc 

nbody_c: nbody.c
	gcc -o nbody_c -pipe -Wall -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3 nbody.c -lm

clean:
	$(RM) mandel_* nbody_*


