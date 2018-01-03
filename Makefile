
all: fast slow basic nbody

fast:
	gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c -lm

slow:
	gcc -o mandel_slow -Wall mandel.c -lm

basic:
	gcc -o mandel_basic -Wall -O3 mandel.c -lm

nbody:
	g++ -o nbody -std=c++11 -Wall -pipe -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3  nbody.cc 

clean:
	$(RM) mandel_*


