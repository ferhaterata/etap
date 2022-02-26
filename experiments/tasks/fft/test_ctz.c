#include <stdio.h>
#include <stdlib.h>

__attribute__((always_inline)) inline static int ctz(size_t N) {
#pragma distribution parameter "N <- 8"
  int ctz1 = 0;
  while (N) {
    ctz1++;
    N >>= 1;
  }
  return ctz1 - 1;
}

int main() {
  size_t n = 8;
  printf("%lx\n", n);
  n = ctz(n);
  printf("%ld\n", n);
  return n;
}
