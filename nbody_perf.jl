#/* The Computer Language Benchmarks Game
# * http://benchmarksgame.alioth.debian.org/
# *
# * contributed by Christoph Bauer
# *  
# */

using Printf
using LinearAlgebra

##include <math.h>
##include <stdio.h>
##include <stdlib.h>

##define pi 3.141592653589793
##define solar_mass (4 * pi * pi)
##define days_per_year 365.24

const pi = 3.141592653589793
const solar_mass = (4 * pi * pi)
const days_per_year = 365.24

#struct planet {
#  double x, y, z;
#  double vx, vy, vz;
#  double mass;
#};

mutable struct planet
    x::Float64
    y::Float64
    z::Float64
    vx::Float64
    vy::Float64
    vz::Float64
    mass::Float64
end

#void advance(int nbodies,       struct planet * bodies, double dt)
#{
#  int i, j;
#
#  for (i = 0; i < nbodies; i++) {
#    struct planet * b = &(bodies[i]);
#    for (j = i + 1; j < nbodies; j++) {
#      struct planet * b2 = &(bodies[j]);
#      double dx = b->x - b2->x;
#      double dy = b->y - b2->y;
#      double dz = b->z - b2->z;
#      double distance = sqrt(dx * dx + dy * dy + dz * dz);
#      double mag = dt / (distance * distance * distance);
#      b->vx -= dx * b2->mass * mag;
#      b->vy -= dy * b2->mass * mag;
#      b->vz -= dz * b2->mass * mag;
#      b2->vx += dx * b->mass * mag;
#      b2->vy += dy * b->mass * mag;
#      b2->vz += dz * b->mass * mag;
#    }
#  }
#  for (i = 0; i < nbodies; i++) {
#    struct planet * b = &(bodies[i]);
#    b->x += dt * b->vx;
#    b->y += dt * b->vy;
#    b->z += dt * b->vz;
#  }
#}

function advance(nbodies::Int, bodies::Vector{planet}, dt::Float64)
    for i = 1:nbodies
        b::planet = bodies[i]
        for j = i + 1: nbodies
            b2::planet = bodies[j]
            dx::Float64 = b.x - b2.x
            dy::Float64 = b.y - b2.y
            dz::Float64 = b.z - b2.z
            distance::Float64 = sqrt(dx * dx + dy * dy + dz * dz)
            mag::Float64  = dt / (distance * distance * distance)
            b.vx -= dx * b2.mass * mag
            b.vy -= dy * b2.mass * mag
            b.vz -= dz * b2.mass * mag
            b2.vx += dx * b.mass * mag
            b2.vy += dy * b.mass * mag
            b2.vz += dz * b.mass * mag
        end
    end
    for i = 1:nbodies
        b::planet = bodies[i]
        b.x += dt * b.vx
        b.y += dt * b.vy
        b.z += dt * b.vz
    end
end



#double energy(int nbodies, struct planet * bodies)
#{
#  double e;
#  int i, j;
#
#  e = 0.0;
#  for (i = 0; i < nbodies; i++) {
#    struct planet * b = &(bodies[i]);
#    e += 0.5 * b->mass * (b->vx * b->vx + b->vy * b->vy + b->vz * b->vz);
#    for (j = i + 1; j < nbodies; j++) {
#      struct planet * b2 = &(bodies[j]);
#      double dx = b->x - b2->x;
#      double dy = b->y - b2->y;
#      double dz = b->z - b2->z;
#      double distance = sqrt(dx * dx + dy * dy + dz * dz);
#      e -= (b->mass * b2->mass) / distance;
#    }
#  }
#  return e;
#}

function energy(nbodies::Int, bodies::Vector{planet})
    e::Float64 = 0.0
    for i = 1:nbodies
        b::planet = bodies[i]
        e += 0.5 * b.mass * (b.vx * b.vx + b.vy * b.vy + b.vz * b.vz)
        for j = i + 1:nbodies
            b2::planet = bodies[j]
            dx::Float64 = b.x - b2.x
            dy::Float64 = b.y - b2.y
            dz::Float64 = b.z - b2.z
            distance::Float64 = sqrt(dx * dx + dy * dy + dz * dz)
            e -= (b.mass * b2.mass) / distance
        end
    end

    return e                        
end

#void offset_momentum(int nbodies, struct planet * bodies)
#{
#  double px = 0.0, py = 0.0, pz = 0.0;
#  int i;
#  for (i = 0; i < nbodies; i++) {
#    px += bodies[i].vx * bodies[i].mass;
#    py += bodies[i].vy * bodies[i].mass;
#    pz += bodies[i].vz * bodies[i].mass;
#  }
#  bodies[0].vx = - px / solar_mass;
#  bodies[0].vy = - py / solar_mass;
#  bodies[0].vz = - pz / solar_mass;
#}

function offset_momentum(nbodies::Int, bodies::Vector{planet})
    px::Float64 = 0.0
    py::Float64 = 0.0
    pz::Float64 = 0.0

    for i = 1:nbodies
        px += bodies[i].vx * bodies[i].mass
        py += bodies[i].vy * bodies[i].mass
        pz += bodies[i].vz * bodies[i].mass
    end
    bodies[1].vx = - px / solar_mass
    bodies[1].vy = - py / solar_mass
    bodies[1].vz = - pz / solar_mass
end

##define NBODIES 5
const NBODIES = 5

#struct planet bodies[NBODIES] = {
#  {                               /* sun */
#    0, 0, 0, 0, 0, 0, solar_mass
#  },
#  {                               /* jupiter */
#    4.84143144246472090e+00,
#    -1.16032004402742839e+00,
#    -1.03622044471123109e-01,
#    1.66007664274403694e-03 * days_per_year,
#    7.69901118419740425e-03 * days_per_year,
#    -6.90460016972063023e-05 * days_per_year,
#    9.54791938424326609e-04 * solar_mass
#  },
#  {                               /* saturn */
#    8.34336671824457987e+00,
#    4.12479856412430479e+00,
#    -4.03523417114321381e-01,
#    -2.76742510726862411e-03 * days_per_year,
#    4.99852801234917238e-03 * days_per_year,
#    2.30417297573763929e-05 * days_per_year,
#    2.85885980666130812e-04 * solar_mass
#  },
#  {                               /* uranus */
#    1.28943695621391310e+01,
#    -1.51111514016986312e+01,
#    -2.23307578892655734e-01,
#    2.96460137564761618e-03 * days_per_year,
#    2.37847173959480950e-03 * days_per_year,
#    -2.96589568540237556e-05 * days_per_year,
#    4.36624404335156298e-05 * solar_mass
#  },
#  {                               /* neptune */
#    1.53796971148509165e+01,
#    -2.59193146099879641e+01,
#    1.79258772950371181e-01,
#    2.68067772490389322e-03 * days_per_year,
#    1.62824170038242295e-03 * days_per_year,
#    -9.51592254519715870e-05 * days_per_year,
#    5.15138902046611451e-05 * solar_mass
#  }
#};

bodies = [
          planet( # sun
                 0, 0, 0, 0, 0, 0, solar_mass
                ),
          planet(#jupiter
                 4.84143144246472090e+00,
                 -1.16032004402742839e+00,
                 -1.03622044471123109e-01,
                 1.66007664274403694e-03 * days_per_year,
                 7.69901118419740425e-03 * days_per_year,
                 -6.90460016972063023e-05 * days_per_year,
                 9.54791938424326609e-04 * solar_mass
                ),
          planet(#saturn
                 8.34336671824457987e+00,
                 4.12479856412430479e+00,
                 -4.03523417114321381e-01,
                 -2.76742510726862411e-03 * days_per_year,
                 4.99852801234917238e-03 * days_per_year,
                 2.30417297573763929e-05 * days_per_year,
                 2.85885980666130812e-04 * solar_mass
                ),
          planet(#uranus
                 1.28943695621391310e+01,
                 -1.51111514016986312e+01,
                 -2.23307578892655734e-01,
                 2.96460137564761618e-03 * days_per_year,
                 2.37847173959480950e-03 * days_per_year,
                 -2.96589568540237556e-05 * days_per_year,
                 4.36624404335156298e-05 * solar_mass
                ),
          planet(#neptune
                 1.53796971148509165e+01,
                 -2.59193146099879641e+01,
                 1.79258772950371181e-01,
                 2.68067772490389322e-03 * days_per_year,
                 1.62824170038242295e-03 * days_per_year,
                 -9.51592254519715870e-05 * days_per_year,
                 5.15138902046611451e-05 * solar_mass
                )
         ]

#int main(int argc, char ** ar          gv)
#{
#  int n = atoi(argv[1]);
#  int i;
#
#  offset_momentum(NBODIES, bodies);
#  printf ("%.9f\n", energy(NBODIES, bodies));
#  for (i = 1; i <= n; i++)
#    advance(NBODIES, bodies, 0.01);
#  printf ("%.9f\n", energy(NBODIES, bodies));
#  return 0;
#}

function main(iterations::Int, bodies)
    n::Int = iterations

    offset_momentum(NBODIES, bodies);
    @printf("%.9f\n", energy(NBODIES, bodies))
    for i = 1:n
        advance(NBODIES, bodies, 0.01)
    end
    @printf("%.9f\n", energy(NBODIES, bodies))
end

N = 5000000
if length(ARGS) >= 1
    N = parse(Int64, ARGS[1]);
end

main(N,bodies)
@time main(N,bodies)
