// https://github.com/embench/embench-iot/blob/e4ab4a9190cd1e66dbc8574ae8c9b3022f5d0adb/src/edn/libedn.c#L142
#include "checkpoint.h"
#define INLINE __attribute__((always_inline)) inline

#define N 100
#define ORDER 50
INLINE
long int latsynth(short b[], const short k[], long int n, long int f) {
  long int i;

  f -= b[n - 1] + k[n - 1];
  for (i = n - 2; i >= 0; i--) {
    checkpoint();
    f -= b[i] + k[i];
    b[i + 1] = b[i] + ((k[i] + (f >> 16)) >> 16);
  }
  b[0] = f >> 16;
  return f;
}

int main_lattice_synthesis() {
  short a[200];
  short b[200];
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
  long int d;
  d = 0xAAAA;
  d = latsynth(a, b, N, d);
  // printf("d: %ld\n", d); // expected value: 62807
  // main_lattice_synthesis mean: 852414.8 std: 0.9963433
  return d;
}