# N-body simulation
# Based off of the Computer Language Benchmarks Game

using Printf
using LinearAlgebra


# Constants
const SOLAR_MASS = 4*pi*pi
const DAYS_PER_YEAR = 365.24

# Body type
mutable struct Body
    x::Array{Float64}
    fill::Float64
    v::Array{Float64}
    mass::Float64
end

# Define each of the body initial values
bodies = [
          # Sun
          Body([0.0, 0.0, 0.0], 0.0, [0.0, 0.0, 0.0], SOLAR_MASS),

          # Jupiter
          Body([4.84143144246472090e+00, 
                -1.16032004402742839e+00, 
                -1.03622044471123109e-01],
               0.0,
               [1.66007664274403694e-03 * DAYS_PER_YEAR, 
                7.69901118419740425e-03 * DAYS_PER_YEAR, 
                -6.90460016972063023e-05 * DAYS_PER_YEAR],
               9.54791938424326609e-04 * SOLAR_MASS),

          # Saturn
          Body([8.34336671824457987e+00,
                4.12479856412430479e+00,
                -4.03523417114321381e-01],
               0.0,
               [-2.76742510726862411e-03 * DAYS_PER_YEAR,
                4.99852801234917238e-03 * DAYS_PER_YEAR,
                2.30417297573763929e-05 * DAYS_PER_YEAR],
               2.85885980666130812e-04 * SOLAR_MASS),

          # Uranus
          Body([1.28943695621391310e+01,
                -1.51111514016986312e+01,
                -2.23307578892655734e-01],
               0.0,
               [2.96460137564761618e-03 * DAYS_PER_YEAR,
                2.37847173959480950e-03 * DAYS_PER_YEAR,
                -2.96589568540237556e-05 * DAYS_PER_YEAR],
               4.36624404335156298e-05 * SOLAR_MASS),

          # Neptune
          Body([1.53796971148509165e+01,
                -2.59193146099879641e+01,
                1.79258772950371181e-01],
               0.0,
               [2.68067772490389322e-03 * DAYS_PER_YEAR,
                1.62824170038242295e-03 * DAYS_PER_YEAR,
                -9.51592254519715870e-05 * DAYS_PER_YEAR],
               5.15138902046611451e-05 * SOLAR_MASS),
         ]

# Pre-define some arrays and values globally to reduce the amount of copying
dx = zeros(3)
distance = 0.
energy = 0.

"""
Not sure exactly what this is supposed to be doing
"""
function offset_momentum()
    for i = 1:length(bodies)
        for k = 1:3
            bodies[1].v[k] -= bodies[i].v[k] * bodies[i].mass / SOLAR_MASS
        end
    end
end

"""
Advance the positions and velocities
"""
function bodies_advance(dt::Float64)
    dx .= zeros(3)
    dsq = 0.
    distance = 0.
    mag = 0.

    for i = 1:length(bodies)
        for j = (i+1):length(bodies)
            dx = bodies[i].x - bodies[j].x

            dsq = dot(dx, dx)
            distance = sqrt(dsq)
            mag = dt / (dsq * distance)

            bodies[i].v -= dx * bodies[j].mass * mag
            bodies[j].v += dx * bodies[i].mass * mag
        end
    end

    for k = 1:length(bodies)
        bodies[k].x += dt * bodies[k].v
    end
end

"""
Compute the overall energy in the system
"""
function bodies_energy()
    dx .= zeros(3)
    distance = 0.
    energy = 0.

    for i = 1:length(bodies)
        energy += bodies[i].mass * dot(bodies[i].v, bodies[i].v) / 2.0

        for j = (i+1):length(bodies)
            dx = bodies[i].x - bodies[j].x

            distance = norm(dx)
            energy -= (bodies[i].mass * bodies[j].mass) / distance
        end
    end
    return energy
end


function main_loop(N::Int64)

    # Pre-allocate some arrays and variables

    offset_momentum()

    @printf "%.9f\n" bodies_energy()

    (for i = 1:N; bodies_advance(0.01); end)

    #Profile.print()

    @printf "%.9f\n" bodies_energy()

end

N = 10000
if length(ARGS) >= 1
    N = parse(Int64, ARGS[1])
end

@time main_loop(N)
#main_loop(N)
