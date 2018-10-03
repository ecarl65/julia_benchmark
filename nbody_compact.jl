const pi = 3.141592653589793
const solar_mass = (4 * pi * pi)
const days_per_year = 365.24

using Printf
using LinearAlgebra
using StaticArrays

const Vec3 = SVector{3, Float64}

mutable struct Planet
    x::Vec3
    v::Vec3
    mass::Float64
end

function advance(bodies::AbstractVector{Planet}, dt::Float64)
    nbodies = length(bodies)
    for i = 1:nbodies
        b = bodies[i]
        for j = (i + 1):nbodies
            b2 = bodies[j]
            dx = b.x - b2.x
            distance = norm(dx)
            mag = dt / (distance*distance*distance)
            b.v  -= dx * b2.mass * mag
            b2.v += dx * b.mass  * mag
        end
    end
    for i = 1:nbodies
        b = bodies[i]
        b.x += dt * b.v
    end
end

function energy(bodies::AbstractVector{Planet})
    e = 0.0
    nbodies = length(bodies)
    for i = 1:nbodies
        b = bodies[i]
        e += 0.5 * b.mass * b.v ⋅ b.v
        for j = (i + 1):nbodies
            b2 = bodies[j]
            dx = b.x - b2.x
            e -= (b.mass * b2.mass) / norm(dx)
        end
    end            
    return e
end

function offset_momentum(bodies::AbstractVector{Planet}    )
    p = zero(Vec3)
    for body in bodies
        p += body.v * body.mass
    end
    bodies[1].v = - p / solar_mass
end

const bodies = SVector(
                      Planet( # sun
                             Vec3([0, 0, 0]),
                             Vec3([0, 0, 0]), 
                             solar_mass
                            ),
                      Planet(#jupiter
                             Vec3([4.84143144246472090e+00, -1.16032004402742839e+00, -1.03622044471123109e-01]),
                             Vec3([1.66007664274403694e-03, 7.69901118419740425e-03,  -6.90460016972063023e-05] * days_per_year),
                             9.54791938424326609e-04 * solar_mass
                            ),
                      Planet(#saturn
                             Vec3([8.34336671824457987e+00,  4.12479856412430479e+00, -4.03523417114321381e-01]),
                             Vec3([-2.76742510726862411e-03, 4.99852801234917238e-03, 2.30417297573763929e-05] * days_per_year),
                             2.85885980666130812e-04 * solar_mass
                            ),
                      Planet(#uranus
                             Vec3([1.28943695621391310e+01, -1.51111514016986312e+01, -2.23307578892655734e-01]),
                             Vec3([2.96460137564761618e-03 , 2.37847173959480950e-03 ,-2.96589568540237556e-05] * days_per_year),
                             4.36624404335156298e-05 * solar_mass
                            ),
                      Planet(#neptune
                             Vec3([1.53796971148509165e+01, -2.59193146099879641e+01, 1.79258772950371181e-01]),
                             Vec3([2.68067772490389322e-03 , 1.62824170038242295e-03 ,-9.51592254519715870e-05] * days_per_year),
                             5.15138902046611451e-05 * solar_mass
                            )
                     )


function main(iterations::Int)
    n = iterations

    offset_momentum(bodies);
    @printf("%.9f\n", energy(bodies))
    for i = 1:n
        advance(bodies, 0.01)
    end
    @printf("%.9f\n", energy(bodies))
end

N = 10000
if length(ARGS) >= 1
    N = parse(Int64, ARGS[1]);
end
main(N)
@time main(N)
