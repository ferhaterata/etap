#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "klee/klee.h"

typedef struct {
  int d;
  int x;
  int y;
} EE;

EE extended_euclid(int a, int b) {
  EE ee1, ee2, ee3;
  if (b == 0) {
    ee1.d = a;
    ee1.x = 1;
    ee1.y = 0;
    return ee1;
  } else {
    ee2 = extended_euclid(b, a % b);
    ee3.d = ee2.d;
    ee3.x = ee2.y;
    ee3.y = ee2.x - floor(a / b) * ee2.y;
    return ee3;
  }
}

// Copied from
// https://stackoverflow.com/questions/11720656/modulo-operation-with-negative-numbers
int modulo(int x, int N) { return (x % N + N) % N; }

void decimal_to_binary(int op1, int aOp[]) {
  int result, i = 0;
  do {
    result = op1 % 2;
    op1 /= 2;
    aOp[i] = result;
    i++;
  } while (op1 > 0);
}

int modular_exponentiation(int a, int b, int n) {
  int* bb;
  int count = 0, c = 0, d = 1, i;

  // find out the size of binary b
  count = (int)(log(b) / log(2)) + 1;

  bb = (int*)malloc(sizeof(int*) * count);
  decimal_to_binary(b, bb);

  for (i = count - 1; i >= 0; i--) {
    c = 2 * c;
    d = (d * d) % n;
    if (bb[i] == 1) {
      c = c + 1;
      d = (d * a) % n;
    }
  }
  return d;
}

int get_d(int e, int phi) {
  EE ee;
  ee = extended_euclid(e, phi);
  return modulo(ee.x, phi);
}
int prime(int n) {
  int i;
  for (i = 2; i <= n / 2; i++) {
    if (n % i != 0)
      continue;
    else
      return 1;
  }
  return 0;
}
int main(int argc, char* argv[]) {
  int p, q, phi, n, e, d, m, c;

  //  klee_make_symbolic(&p, sizeof(p), "prime 1");
  //  klee_make_symbolic(&q, sizeof(q), "prime 2");
  //  klee_assume(prime(p) && prime(q));
  //  klee_assume(isPrime(p));
  p = 10;
  q = 29;
  //  e = 5;
  m = 50;

  printf("p: %d\n", p);
  printf("q: %d\n", q);
  //  printf("Enter the value of p: ");
  //  scanf("%d", &p);
  //  printf("Enter the valeu of q: ");
  //  scanf("%d", &q);
  n = p * q;
  phi = (p - 1) * (q - 1);
  klee_make_symbolic(&e, sizeof(e), "e");
  klee_assume(e > 1 && e < phi);
  //  printf("Enter the value of e: ");
  //  scanf("%d", &e);
  d = get_d(e, phi);
  printf("Public Key: (n = %d, e = %d)\n", n, e);
  printf("Private Key: (n = %d, d = %d)\n", n, d);
  //  printf("Enter message to encrypt: ");
  //  scanf("%d", &m);
  c = modular_exponentiation(m, e, n);
  printf("Encrypted message is: %d\n", c);
  m = modular_exponentiation(c, d, n);
  printf("Message is decrypted to %d\n", m);
  return 0;
}

// clang-9 -I usr/local/include/klee -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone rsaNuman.c
// klee --external-calls=all rsaNuman.bc