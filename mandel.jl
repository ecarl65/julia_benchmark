#!/usr/bin/env julia
function mandelbrot(M::Array{UInt8, 2})

    z::Complex{Float64} = 0.0 
    c::Complex{Float64} = 0.0 
    cc::UInt8 = 0
    
    for ii = 1:1000
        c = (ii - 501) * 0.002im
        for jj = 1:1500
            c = (jj - 1001) * 0.002 + c.im * 1im
            z = copy(c)
            for cc = 0:255
                z = z^2 + c
                if abs2(z) > 4
                    break
                end
            end
            M[jj, ii] = cc
        end
    end
end

# Parse arguments and set up arrays
N = 100
if length(ARGS) >= 1
    N = parse(Int64, ARGS[1])
end
M = zeros(UInt8, 1500, 1000)
times = zeros(Float64, N)

for m = 1:N
    times[m] = @elapsed mandelbrot(M)
end

@printf(STDERR, "number of trials: %d\n", N)
@printf(STDERR, "min elapsed time: %.6f\n", minimum(times))

write(STDOUT, "P5 1500 1000 255\n")
write(STDOUT, M)

