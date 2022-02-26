#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "aes.h"
#include "klee/klee.h"
// Enable both ECB and CBC mode. Note this can be done before including aes.h or
// at compile-time. E.g. with GCC by using the -D flag: gcc -c aes.c -DCBC=0
// -DECB=1
#define ECB 1
int main() {
  uint8_t key[16];
  uint8_t in[] = {0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
                  0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a};
  uint8_t buffer[16];
  klee_make_symbolic(&key, sizeof(key), "key");
  klee_assume(key[0] != 0);
  AES128_ECB_encrypt(in, key, buffer);
  return 0;
}

// clang-9 -I ../../../../klee/include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone kleeAesTest.c aes.c
// klee --link-llvm-lib=aes.bc kleeAesTest.bc
// cd klee-last
// ktest-tool test000001.ktest