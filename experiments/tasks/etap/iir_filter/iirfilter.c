// https://github.com/embench/embench-iot/blob/e4ab4a9190cd1e66dbc8574ae8c9b3022f5d0adb/src/edn/libedn.c#L160
#include "checkpoint.h"
#define LOCAL_SCALE_FACTOR 87

#define INLINE __attribute__((always_inline)) inline
#define N 100
#define ORDER 50
INLINE
long int iir1(const short* coefs, const short* input, long int* optr,
              long int* state) {
  long int x;
  long int t;
  long int n;

  x = input[0];
  for (n = 0; n < 50; n++) {
    checkpoint();
    t = x + ((coefs[2] + state[0] + coefs[3] + state[1]) >> 15);
    x = t + ((coefs[0] + state[0] + coefs[1] + state[1]) >> 15);
    state[1] = state[0];
    state[0] = t;
    coefs += 4; /* point to next filter coefs  */
    state += 2; /* point to next filter states */
  }
  *optr++ = x;
  return t;
}

int main_iir_filter() {
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
    output[i] = 0;
    output[i + 1] = 0;
    output[i + 2] = 0;
    output[i + 3] = 0;
    output[i + 4] = 0;
    output[i + 5] = 0;
    output[i + 6] = 0;
    output[i + 7] = 0;
  }
  long int result = iir1(a, b, &output[100], output);
  // printf("result: %ld\n", result); // expected value: 3119
  // main_iir_filter mean: 450157 std: 1.196578
  return result;
}