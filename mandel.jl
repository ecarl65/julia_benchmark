function mandel(z)
    c = z
    maxiter = 80
    for n = 1:maxiter
        if abs2(z) > 4
            return n-1
        end
        z = z^2 + c
    end
    return maxiter
end

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

#println(mandel(0))

M = zeros(UInt8, 1500, 1000)

tic()
mandelbrot(M)
toc()

outfile = "mandel_julia.pbm"
output = open(outfile, "w")
write(output, "P5 1500 1000 255\n")
write(output, M)
close(output)

