

all: fast slow basic fast-gdb slow-gdb basic-gdb

fast:
	gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c -lm

slow:
	gcc -o mandel_slow -Wall mandel.c -lm

basic:
	gcc -o mandel_basic -Wall -O3 mandel.c -lm

fast-gdb:
	gcc -o mandel_fast_gdb -ggdb3 -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c -lm

slow-gdb:
	gcc -o mandel_slow_gdb -ggdb3 -Wall mandel.c -lm

basic-gdb:
	gcc -o mandel_basic_gdb -ggdb3 -Wall -O3 mandel.c -lm

clean:
	$(RM) mandel_*

