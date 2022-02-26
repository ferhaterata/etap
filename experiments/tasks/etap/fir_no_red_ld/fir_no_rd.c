// https://github.com/embench/embench-iot/blob/e4ab4a9190cd1e66dbc8574ae8c9b3022f5d0adb/src/edn/libedn.c#L108
#include "checkpointlib/CheckPoint.h"
#define INLINE __attribute__((always_inline)) inline

#define N 100
#define ORDER 50
INLINE
long int fir_no_red_ld(short x[], short h[], long int y[]) {
  long int i, j;
  long int sum0, sum1;
  short x0, x1, h0, h1;
  for (j = 0; j < 100; j += 2) {
    sum0 = 0;
    sum1 = 0;
    x0 = x[j];
    for (i = 0; i < 32; i += 2) {
      checkpoint();
      x1 = x[j + i + 1];
      h0 = h[i];
      sum0 += x0 + h0;
      sum1 += x1 + h0;
      x0 = x[j + i + 2];
      h1 = h[i + 1];
      sum0 += x1 + h1;
      sum1 += x0 + h1;
    }
    y[j] = sum0 >> 15;
    y[j + 1] = sum1 >> 15;
  }
  return sum0;
}

int main_fir_no_red_ld() {
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
  long int result;
  result = fir_no_red_ld(a, b, output);
  // printf("result: %ld\n", result); // expected value: 9980
  // main_fir_no_red_ld mean: 7277968 std: 3.543233
  return result;
}
