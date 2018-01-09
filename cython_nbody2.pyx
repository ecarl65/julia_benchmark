# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# originally by Kevin Carson
# modified by Tupteq, Fredrik Johansson, and Daniel Nanz
# modified by Maciej Fijalkowski
# 2to3
# modified by Andriy Misyura
# modified to Cythonize by Eric Carlsen

import sys
from libc cimport math

def combinations(l):
    result = []
    for x in range(len(l) - 1):
        ls = l[x+1:]
        for y in ls:
            result.append((l[x] + y))
    return result

PI = 3.14159265358979323
SOLAR_MASS = 4 * PI * PI
DAYS_PER_YEAR = 365.24

# TODO Begin transitioning to using C structure to hold body information
cdef struct c_body:
    double x[3]
    double v[3]
    double mass
    double fill

cdef c_body c_bodies[5]

# Sun
c_bodies[0].x = [0.0, 0.0, 0.0]
c_bodies[0].v = [0.0, 0.0, 0.0]
c_bodies[0].mass = SOLAR_MASS

# Jupiter
c_bodies[1].x =  [ 4.84143144246472090e+00,
                  -1.16032004402742839e+00,
                  -1.03622044471123109e-01]
c_bodies[1].v =  [ 1.66007664274403694e-03 * DAYS_PER_YEAR,
                   7.69901118419740425e-03 * DAYS_PER_YEAR,
                  -6.90460016972063023e-05 * DAYS_PER_YEAR]
c_bodies[1].mass = 9.54791938424326609e-04 * SOLAR_MASS

# Saturn
c_bodies[2].x =  [ 8.34336671824457987e+00,
                   4.12479856412430479e+00,
                  -4.03523417114321381e-01]
c_bodies[2].v =  [-2.76742510726862411e-03 * DAYS_PER_YEAR,
                   4.99852801234917238e-03 * DAYS_PER_YEAR,
                   2.30417297573763929e-05 * DAYS_PER_YEAR]
c_bodies[2].mass = 2.85885980666130812e-04 * SOLAR_MASS

# Uranus
c_bodies[3].x =  [ 1.28943695621391310e+01,
                  -1.51111514016986312e+01,
                  -2.23307578892655734e-01]
c_bodies[3].v =  [ 2.96460137564761618e-03 * DAYS_PER_YEAR,
                   2.37847173959480950e-03 * DAYS_PER_YEAR,
                  -2.96589568540237556e-05 * DAYS_PER_YEAR]
c_bodies[3].mass = 4.36624404335156298e-05 * SOLAR_MASS

# Neptune
c_bodies[4].x =  [ 1.53796971148509165e+01,
                  -2.59193146099879641e+01,
                   1.79258772950371181e-01]
c_bodies[4].v =  [ 2.68067772490389322e-03 * DAYS_PER_YEAR,
                   1.62824170038242295e-03 * DAYS_PER_YEAR,
                  -9.51592254519715870e-05 * DAYS_PER_YEAR]
c_bodies[4].mass = 5.15138902046611451e-05 * SOLAR_MASS 

BODIES = {
    'sun': ([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], SOLAR_MASS),

    'jupiter': ([4.84143144246472090e+00,
                 -1.16032004402742839e+00,
                 -1.03622044471123109e-01],
                [1.66007664274403694e-03 * DAYS_PER_YEAR,
                 7.69901118419740425e-03 * DAYS_PER_YEAR,
                 -6.90460016972063023e-05 * DAYS_PER_YEAR],
                9.54791938424326609e-04 * SOLAR_MASS),

    'saturn': ([8.34336671824457987e+00,
                4.12479856412430479e+00,
                -4.03523417114321381e-01],
               [-2.76742510726862411e-03 * DAYS_PER_YEAR,
                4.99852801234917238e-03 * DAYS_PER_YEAR,
                2.30417297573763929e-05 * DAYS_PER_YEAR],
               2.85885980666130812e-04 * SOLAR_MASS),

    'uranus': ([1.28943695621391310e+01,
                -1.51111514016986312e+01,
                -2.23307578892655734e-01],
               [2.96460137564761618e-03 * DAYS_PER_YEAR,
                2.37847173959480950e-03 * DAYS_PER_YEAR,
                -2.96589568540237556e-05 * DAYS_PER_YEAR],
               4.36624404335156298e-05 * SOLAR_MASS),

    'neptune': ([1.53796971148509165e+01,
                 -2.59193146099879641e+01,
                 1.79258772950371181e-01],
                [2.68067772490389322e-03 * DAYS_PER_YEAR,
                 1.62824170038242295e-03 * DAYS_PER_YEAR,
                 -9.51592254519715870e-05 * DAYS_PER_YEAR],
                5.15138902046611451e-05 * SOLAR_MASS) }

SYSTEM = tuple(BODIES.values())
PAIRS = tuple(combinations(SYSTEM))

cdef advance(double dt, int n, bodies=SYSTEM, pairs=PAIRS):
    cdef int i
    cdef double x1, y1, z1, m1, x2, y2, z2, m2
    cdef double v1[3]
    cdef double v2[3]
    cdef double r[3]
    cdef double dx, dy, dz, mag, b1m, b2m, dist

    for i in range(n):
        for ([x1, y1, z1], [v1[0], v1[1], v1[2]], m1, [x2, y2, z2], [v2[0], v2[1], v2[2]], m2) in pairs:
            dx = x1 - x2
            dy = y1 - y2
            dz = z1 - z2
            dist = math.sqrt(dx * dx + dy * dy + dz * dz);
            mag = dt / (dist*dist*dist)
            b1m = m1 * mag
            b2m = m2 * mag
            v1[0] -= dx * b2m
            v1[1] -= dy * b2m
            v1[2] -= dz * b2m
            v2[2] += dz * b1m
            v2[1] += dy * b1m
            v2[0] += dx * b1m
        for ([r[0], r[1], r[2]], [vx, vy, vz], m) in bodies:
            r[0] += dt * vx
            r[1] += dt * vy
            r[2] += dt * vz

cdef report_energy(bodies=SYSTEM, pairs=PAIRS, double e=0.0):

    for ((x1, y1, z1), v1, m1, (x2, y2, z2), v2, m2) in pairs:
        dx = x1 - x2
        dy = y1 - y2
        dz = z1 - z2
        e -= (m1 * m2) / ((dx * dx + dy * dy + dz * dz) ** 0.5)
    for (r, [vx, vy, vz], m) in bodies:
        e += m * (vx * vx + vy * vy + vz * vz) / 2.
    print("%.9f" % e)

cdef offset_momentum(ref, bodies=SYSTEM, double px=0.0, double py=0.0, double pz=0.0):
    for (r, [vx, vy, vz], m) in bodies:
        px -= vx * m
        py -= vy * m
        pz -= vz * m
    (r, v, m) = ref
    v[0] = px / m
    v[1] = py / m
    v[2] = pz / m

def main(int n=5000000, ref='sun'):
    offset_momentum(BODIES[ref])
    report_energy()
    advance(0.01, n)
    report_energy()


if __name__ == '__main__':
    if len(sys.argv) > 1: 
        N = int(sys.argv[1])
    else: 
        N = 5000000

    main(N)
