#include <stdio.h>

__attribute__((always_inline)) inline static size_t revbits(size_t v, int J) {
#pragma distribution parameter "v <- 1"
#pragma distribution parameter "J <- 8"
  size_t r = 0;
  for (int j = 0; j < J; j++) {
    r |= ((v >> j) & 1) << (J - 1 - j);
  }
  return r;
}

int main() {
  size_t v = 1;
  int J = 8;
  printf("%lx %d\n", v, J);
  int res = revbits(v, J);
  printf("%d\n", res);
  return res;
}
