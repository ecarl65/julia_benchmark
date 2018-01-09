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

DEF NBODIES=5
DEF PI = 3.14159265358979323
DEF SOLAR_MASS = 4 * PI * PI
DEF DAYS_PER_YEAR = 365.24


# Celestial body structure containing location, velocity, mass, and a filler
cdef struct body:
    double x[3]
    double v[3]
    double mass
    double fill

# Global array holding all the bodies
cdef body bodies[NBODIES]

# Sun
bodies[0].x = [0.0, 0.0, 0.0]
bodies[0].v = [0.0, 0.0, 0.0]
bodies[0].mass = SOLAR_MASS

# Jupiter
bodies[1].x    = [ 4.84143144246472090e+00,
                  -1.16032004402742839e+00,
                  -1.03622044471123109e-01]
bodies[1].v    = [ 1.66007664274403694e-03 * DAYS_PER_YEAR,
                   7.69901118419740425e-03 * DAYS_PER_YEAR,
                  -6.90460016972063023e-05 * DAYS_PER_YEAR]
bodies[1].mass =   9.54791938424326609e-04 * SOLAR_MASS

# Saturn
bodies[2].x    = [ 8.34336671824457987e+00,
                   4.12479856412430479e+00,
                  -4.03523417114321381e-01]
bodies[2].v    = [-2.76742510726862411e-03 * DAYS_PER_YEAR,
                   4.99852801234917238e-03 * DAYS_PER_YEAR,
                   2.30417297573763929e-05 * DAYS_PER_YEAR]
bodies[2].mass =   2.85885980666130812e-04 * SOLAR_MASS

# Uranus
bodies[3].x    = [ 1.28943695621391310e+01,
                  -1.51111514016986312e+01,
                  -2.23307578892655734e-01]
bodies[3].v    = [ 2.96460137564761618e-03 * DAYS_PER_YEAR,
                   2.37847173959480950e-03 * DAYS_PER_YEAR,
                  -2.96589568540237556e-05 * DAYS_PER_YEAR]
bodies[3].mass =   4.36624404335156298e-05 * SOLAR_MASS

# Neptune
bodies[4].x    = [ 1.53796971148509165e+01,
                  -2.59193146099879641e+01,
                   1.79258772950371181e-01]
bodies[4].v    = [ 2.68067772490389322e-03 * DAYS_PER_YEAR,
                   1.62824170038242295e-03 * DAYS_PER_YEAR,
                  -9.51592254519715870e-05 * DAYS_PER_YEAR]
bodies[4].mass =   5.15138902046611451e-05 * SOLAR_MASS 


cdef advance(double dt, unsigned int n, body [NBODIES] bodies=bodies):
    cdef unsigned int m, i, j
    cdef double dx[3]
    cdef double mag, dist, dsq

    for m in xrange(n):
        for i in xrange(NBODIES):

            for j in xrange(i+1, NBODIES):
                dx[0] = bodies[i].x[0] - bodies[j].x[0]
                dx[1] = bodies[i].x[1] - bodies[j].x[1]
                dx[2] = bodies[i].x[2] - bodies[j].x[2]

                dsq = dx[0]*dx[0] + dx[1]*dx[1] + dx[2]*dx[2]
                dist = math.sqrt(dsq)
                mag = dt / (dsq * dist)

                bodies[i].v[0] -= dx[0] * bodies[j].mass * mag
                bodies[i].v[1] -= dx[1] * bodies[j].mass * mag
                bodies[i].v[2] -= dx[2] * bodies[j].mass * mag

                bodies[j].v[0] += dx[0] * bodies[i].mass * mag
                bodies[j].v[1] += dx[1] * bodies[i].mass * mag
                bodies[j].v[2] += dx[2] * bodies[i].mass * mag

        for i in xrange(NBODIES):
            bodies[i].x[0] += dt * bodies[i].v[0]
            bodies[i].x[1] += dt * bodies[i].v[1]
            bodies[i].x[2] += dt * bodies[i].v[2]


cdef report_energy(body [NBODIES] bodies=bodies):
    cdef double e=0.0
    cdef double dx[3]
    cdef double distance
    cdef int i, j, k

    for i in xrange(NBODIES):
        e += bodies[i].mass * (bodies[i].v[0]*bodies[i].v[0] 
                + bodies[i].v[1]*bodies[i].v[1] + bodies[i].v[2]*bodies[i].v[2]) / 2.0

        for j in xrange(i+1, NBODIES):
            for k in xrange(3):
                dx[k] = bodies[i].x[k] - bodies[j].x[k]

            distance = math.sqrt(dx[0]*dx[0] + dx[1]*dx[1] + dx[2]*dx[2])
            e -= (bodies[i].mass * bodies[j].mass) / distance;

    print("%.9f" % e)


cdef offset_momentum(body [NBODIES] bodies=bodies):
    cdef double px[3]
    cdef unsigned int i

    px[0] = 0.0;
    px[1] = 0.0;
    px[2] = 0.0;
    for i in xrange(NBODIES):
        px[0] -= bodies[i].v[0] * bodies[i].mass
        px[1] -= bodies[i].v[1] * bodies[i].mass
        px[2] -= bodies[i].v[2] * bodies[i].mass
    bodies[0].v[0] = px[0] / bodies[0].mass
    bodies[0].v[1] = px[1] / bodies[0].mass
    bodies[0].v[2] = px[2] / bodies[0].mass


def main(unsigned int n=5000000):
    cdef unsigned int i
    offset_momentum()
    report_energy()
    advance(0.01, n)
    report_energy()


if __name__ == '__main__':
    if len(sys.argv) > 1: 
        N = int(sys.argv[1])
    else: 
        N = 5000000

    main(N)
