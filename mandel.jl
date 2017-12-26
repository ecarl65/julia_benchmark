function mandelbrot(M::Array{UInt8, 2})

    z::Complex{Float64} = 0.0 
    c::Complex{Float64} = 0.0 
    cc::UInt8 = 0
    
    for ii = 1:1000
        c = (ii - 501) * 0.002im
        for jj = 1:1500
            c = (jj - 1001) * 0.002 + c.im * 1im
            z = c
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

M = zeros(UInt8, 1500, 1000)

timed = @elapsed mandelbrot(M)
write(STDERR, "elapsed time $timed\n")

write(STDOUT, "P5 1500 1000 255\n")
write(STDOUT, M)

