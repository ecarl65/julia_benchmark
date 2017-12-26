#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <math.h>

typedef long long int64;

__attribute__ ((noinline)) static void mandel(unsigned char* data) {
//static void mandel(unsigned char* data) {
    for (int ii = 0; ii<1000; ii++) {
        double im = (ii - 500)*.002;
        for (int jj = 0; jj<1500; jj++) {
            double re = (jj - 1000)*.002;
            double xx = re;
            double yy = im;
            int64 cc = 0;
            for (;;) {
                double tx = xx*xx - yy*yy + re;
                double ty = 2*xx*yy + im;
                double r2 = tx*tx + ty*ty;
                xx = tx;
                yy = ty;
                cc += 1;
                if (r2 > 4 || cc == 255) {
                    data[ii*1500 + jj] = cc;
                    break;
                }
            }
        }
    }
}

static inline double stopwatch() {
    struct timespec ts = { 0, 0 };
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + 1e-9*ts.tv_nsec;
}

static inline double compute_min(double vals[], int N) {

    if (N < 0) {
        fprintf(stderr, "ERROR: Not enough values in array\n");
        return -1.0;
    }

    double min = vals[0];
    for (int m = 1; m < N; m++) {
        min = vals[m] < min ? vals[m] : min;
    }

    return min;
}

int main(int argc, char *argv[]) {
    // Argument parsing and setup
    int N = 100;
    if (argc > 1) N = atoi(argv[1]);
    double times[N];
    static unsigned char data[1500*1000];


    // Run the loops and time results
    for (int m = 0; m < N; m++) {
        double before = stopwatch();
        mandel(data);
        double after = stopwatch();
        times[m] = after - before;
    }

    fprintf(stderr, "number of trials: %d\n", N);
    fprintf(stderr, "min elapsed time: %lf seconds\n", compute_min(times, N));

    printf("P5 1500 1000 255\n");
    fwrite(data, 1, 1500*1000, stdout);

    return 0;
}
