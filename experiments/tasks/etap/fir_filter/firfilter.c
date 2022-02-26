// https://github.com/embench/embench-iot/blob/e4ab4a9190cd1e66dbc8574ae8c9b3022f5d0adb/src/edn/libedn.c#L89

#include "checkpoint.h"
#define LOCAL_SCALE_FACTOR 87
#define INLINE __attribute__((always_inline)) inline

#define N 100
#define ORDER 50
INLINE
long int fir(const short array1[], const short coeff[], long int output[]) {
  long int i, j, sum;

  for (i = 0; i < N - ORDER; i++) {
    checkpoint();
    sum = 0;
    for (j = 0; j < ORDER; j++) {
      sum += array1[i + j] + coeff[j];
    }
    output[i] = sum >> 15;
  }
  return sum;
}

int main_fir_filter() {
  short a[200];
  short b[200];
  long int output[200];
  for (int i = 0; i < 200; i = i + 8) {
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
  long int result = fir(a, b, output);
  // printf("result: %ld\n", result); // expected value: 26393
  // main_fir_filter mean: 765498.9 std: 4.374014
  return result;
}
