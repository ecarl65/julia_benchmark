#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <math.h>

typedef long long int64;

//__attribute__ ((noinline)) static void mandel(unsigned char* data) {
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

static inline double compute_mean(double vals[], int N) {
    double avg = 0.0;
    for (int m = 0; m < N; m++) {
        avg += vals[m];
    }

    avg /= (double) N;

    return avg;
}

// the compare function for double values
static int compare (const void * a, const void * b)
{
    if (*(double*)a > *(double*)b) return 1;
    else if (*(double*)a < *(double*)b) return -1;
    else return 0;  
}

static inline double compute_median(double vals[], int N) {
    double median = 0;

    qsort(&vals[0], N, sizeof(double), compare);

    if (N % 2) {
        median = vals[N/2];
    } else {
        median = (vals[N/2 - 1] + vals[N/2]) / 2.0;
    }

    return median;
}


static inline double compute_std(double vals[], int N, double mean) {
    double sum_sq = 0.0f;
    for (int m = 0; m < N; m++) {
        sum_sq = (vals[m] - mean) * (vals[m] - mean);
    }
    double std_dev = sqrt(sum_sq / ((double) (N - 1)));

    return std_dev;
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

    double mean = compute_mean(times, N);
    double median = compute_median(times, N);
    double std = compute_std(times, N, mean);
    
    // Print results
    fprintf(stderr, "number of trials: %d\n", N);
    fprintf(stderr, "mean elapsed time: %lf seconds\n", mean);
    fprintf(stderr, "median elapsed time: %lf seconds\n", median);
    fprintf(stderr, "standard deviation of elapsed times: %lf seconds\n", std);

    //fprintf(stderr, "elapsed time: %lf seconds\n", after - before);
    printf("P5 1500 1000 255\n");
    fwrite(data, 1, 1500*1000, stdout);

    return 0;
}
