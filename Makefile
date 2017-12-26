

all: fast slow basic fast-gdb slow-gdb basic-gdb

fast:
	gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c

slow:
	gcc -o mandel_slow -Wall mandel.c

basic:
	gcc -o mandel_basic -Wall -O3 mandel.c

fast-gdb:
	gcc -o mandel_fast_gdb -ggdb3 -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c

slow-gdb:
	gcc -o mandel_slow_gdb -ggdb3 -Wall mandel.c

basic-gdb:
	gcc -o mandel_basic_gdb -ggdb3 -Wall -O3 mandel.c

clean:
	$(RM) mandel_*

