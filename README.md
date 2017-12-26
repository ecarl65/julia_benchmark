# julia_benchmark

## Introduction
This is a quick and dirty set of files to test Julia against C on the Mandelbrot set.
I started out with a 
[C mandelbrot version passed to me](https://github.com/xscott/working/blob/master/excess0/mandel.c) 
and attempted to implement the 
equivalent structure in Julia. Both versions will produce an output on standard output. Both programs also measure 
the execution time of just generating the mandelbrot set, not the file output time, and output it to standard error.

## Results
Running each program 10 times produced the following results on my crummy laptop (specs below)

|             | Median Time | Average Time | Standard Deviation   |
|-------------|-------------|--------------|----------------------|
| `mandel.jl` | 0.566598846 | 0.5671196473 | 0.003800356532448803 |
| `mandel.c`  | 0.371234    | 0.3709791    | 0.001235028785089647 |

## C Compilation

The above results are using the "fast" version of the C program, with more aggressive compilation flags:

    gcc -o mandel_fast -pipe -Wall -O3 -ffast-math -ffinite-math-only -march=native -mfpmath=sse -msse3 mandel.c
    
For the assembly generation the `mandelbrot` function was ensured to not be inlined and I added `-ggdb3` to the compilation flags.

## Julia Compilation

The Julia assembly language generation was done from the REPL after importing the file and calling `code_native(mandelbrot, Tuple{Array{UInt8,2}})`. When the Julia version of the program was called there were no special compilation flags, it was called like `julia mandel.jl > mandel_julia.pbm`.

## Machine Specs


| Field          | Value |
|----------------|--------------------------------|
| processor      | (4 entries with values of 0-3) |
| vendor_id      | GenuineIntel |
| cpu family     | 6 |
| model          | 78 |
| model name     | Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz |
| stepping       | 3 |
| microcode      | 0x88 |
| cpu MHz        | 2663.818 |
| cache size     | 3072 KB |
| physical id    | 0 |
| siblings       | 4 |
| core id        | 1 |
| cpu cores      | 2 |
| apicid         | 3 |
| initial apicid | 3 |
| fpu            | yes |
| fpu_exception  | yes |
| cpuid level    | 22 |
| wp             | yes |
| flags           | fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp |
| bugs            |  |
| bogomips        | 4800.00 |
| clflush size    | 64 |
| cache_alignment | 64 |
| address sizes   | 39 bits physical, 48 bits virtual |
| power management| |


