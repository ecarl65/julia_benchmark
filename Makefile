

all: fast slow basic

fast:
	gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -fno-finite-math-only -march=native -mfpmath=sse -msse3 mandel.c

slow:
	gcc -o mandel_slow -Wall mandel.c

basic:
	gcc -o mandel_basic -Wall -O3 mandel.c

clean:
	rm mandel_fast mandel_slow mandel_basic

