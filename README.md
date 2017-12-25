# julia_benchmark

## Introduction
This is a quick and dirty set of files to test Julia against C on the Mandelbrot set.
I started out with a 
[C mandelbrot version passed to me](https://github.com/xscott/working/blob/master/excess0/mandel.c) 
and attempted to implement the 
equivalent structure in Julia. Both versions will produce an output, with the Julia 
output currently hardcoded to "mandel_julia.pbm". The C program produces an output to 
the stdout, meaning it needs to redirect output to a file. Both programs also measure 
the execution time of just generating the mandelbrot set, not the file output time.

## Results
Running each program 10 times produced the following results on my crummy laptop (specs below)

|             | Median Time | Average Time | Standard Deviation   |
|-------------|-------------|--------------|----------------------|
| `mandel.jl` | 0.586330067 | 0.5870916313 | 0.003496055297644133 |
| `mandel.c`  | 0.3717155   | 0.3676821    | 0.009663187654990225 |

## C Compilation

The above results are using the "fast" version of the C program, with more aggressive compilation flags:

    gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c

## Machine Specs

