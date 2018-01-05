
#CC = gcc -std=c99 -Wall -Wextra -g -O2 -D_GNU_SOURCE
CC = gcc -std=c99 -Wall -Wextra -O3 -D_GNU_SOURCE

all: fast slow basic nbody_c nbody_cc

fast: mandel.c
	gcc -o mandel_fast -pipe -std=c99 -Wall -O3 -D_GNU_SOURCE -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c -lm

slow: mandel.c
	gcc -o mandel_slow -std=c99 -Wall -D_GNU_SOURCE mandel.c -lm

basic: mandel.c
	gcc -o mandel_basic -std=c99 -Wall -O3 -D_GNU_SOURCE mandel.c -lm

nbody_cc: nbody.cc
	g++ -o nbody_cc -std=c++11 -Wall -pipe -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3  nbody.cc 

nbody_c: nbody.c
	gcc -o nbody_c -pipe -Wall -O3 -D_GNU_SOURCE -fomit-frame-pointer -march=native -mfpmath=sse -msse3 nbody.c -lm

clean:
	$(RM) mandel_* nbody_*


