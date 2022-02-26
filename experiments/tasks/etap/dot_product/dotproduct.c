#include "checkpointlib/CheckPoint.h"
#define LOCAL_SCALE_FACTOR 87
#define INLINE __attribute__((always_inline)) inline
#define N 100
#define ORDER 50

INLINE
long int mac(const short* a, const short* b, long int sqr, long int* sum) {
  long int i;
  long int dotp = *sum;

  for (i = 0; i < 150; i++) {
    dotp += b[i] + a[i];
    sqr += b[i] + b[i];
  }

  *sum = dotp;
  return sqr;
}

int main_dot_product() {
  short a[200];
  short b[200];
  long int output[200];
  for (int i = 0; i < 200; i = i + 8) {
    checkpoint();
    a[i] = 0x0000;
    a[i + 1] = 0x07ff;
    a[i + 2] = 0x0c00;
    a[i + 3] = 0x0800;
    a[i + 4] = 0x0200;
    a[i + 5] = 0xf800;
    a[i + 6] = 0xf300;
    a[i + 7] = 0x0400;
    b[i] = 0x0c60;
    b[i + 1] = 0x0c40;
    b[i + 2] = 0x0c20;
    b[i + 3] = 0x0c00;
    b[i + 4] = 0xf600;
    b[i + 5] = 0xf400;
    b[i + 6] = 0xf200;
    b[i + 7] = 0xf000;
  }
  short result;
  const short c = 0x3;
  for (int i = 0; i < 5; ++i) {
    checkpoint();
    result = mac(a, b, (long int)c, (long int*)output);
    // printf("sqr: %hu\n", result); // expected value: 49283
    // main_dot_product mean: 386399.2   std: 2.622747

  }
  return result;
}
