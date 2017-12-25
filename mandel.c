#include <time.h>
#include <stdio.h>

typedef long long int64;

static void mandel(unsigned char* data) {
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

int main() {

    static unsigned char data[1500*1000];
    double before = stopwatch();
    mandel(data);
    double after = stopwatch();
    fprintf(stderr, "elapsed time: %lf seconds\n", after - before);
    printf("P5 1500 1000 255\n");
    fwrite(data, 1, 1500*1000, stdout);

    return 0;
}
