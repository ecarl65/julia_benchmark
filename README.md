# julia_benchmark
Quick and dirty benchmark of Julia program(s).

I started out with a c mandelbrot version passed to me and attempted to implement the 
equivalent structure in Julia. Both versions will produce an output, with the Julia 
output currently hardcoded to "mandel_julia.pbm". The C program produces an output to 
the stdout, meaning it needs to redirect output to a file. Both programs also measure 
the execution time of just generating the mandelbrot set, not the file output time.

Running each program 10 times produced the following results on my crummy laptop (specs below)

|            | Median Time | Average Time | Standard Deviation |
|------------|-------------|--------------|--------------------|
|mandel.jl:  | 0.0         | 0.0          | 0.0                |
|mandel.c    | 0.0         | 0.0          | 0.0                |
