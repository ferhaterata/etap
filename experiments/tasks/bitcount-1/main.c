#include <stdint.h>
#include <stdio.h>

#include "checkpoint.h"

#define INLINE __attribute__((always_inline)) inline

#define SEED 4L
#define ITER 100
#define CHAR_BIT 8

char bits[256] = {
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, /* 0   - 15  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, /* 16  - 31  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, /* 32  - 47  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 48  - 63  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, /* 64  - 79  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 80  - 95  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 96  - 111 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, /* 112 - 127 */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, /* 128 - 143 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 144 - 159 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 160 - 175 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, /* 176 - 191 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, /* 192 - 207 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, /* 208 - 223 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, /* 224 - 239 */
    4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8  /* 240 - 255 */
};

INLINE int btbl_bitcnt(uint32_t x) {
  int cnt = bits[((char*)&x)[0] & 0xFF];

  if (0L != (x >>= 8)) cnt += btbl_bitcnt(x);
  return cnt;
}

INLINE int bit_count(uint32_t x) {
  int n = 0;

  if (x) do
      n++;
    while (0 != (x = x & (x - 1)));
  return (n);
}

INLINE int bitcount(uint32_t i) {
  i = ((i & 0xAAAAAAAAL) >> 1) + (i & 0x55555555L);
  i = ((i & 0xCCCCCCCCL) >> 2) + (i & 0x33333333L);
  i = ((i & 0xF0F0F0F0L) >> 4) + (i & 0x0F0F0F0FL);
  i = ((i & 0xFF00FF00L) >> 8) + (i & 0x00FF00FFL);
  i = ((i & 0xFFFF0000L) >> 16) + (i & 0x0000FFFFL);
  return (int)i;
}

INLINE int ntbl_bitcount(uint32_t x) {
  return bits[(int)(x & 0x0000000FUL)] + bits[(int)((x & 0x000000F0UL) >> 4)] +
         bits[(int)((x & 0x00000F00UL) >> 8)] +
         bits[(int)((x & 0x0000F000UL) >> 12)] +
         bits[(int)((x & 0x000F0000UL) >> 16)] +
         bits[(int)((x & 0x00F00000UL) >> 20)] +
         bits[(int)((x & 0x0F000000UL) >> 24)] +
         bits[(int)((x & 0xF0000000UL) >> 28)];
}

INLINE int BW_btbl_bitcount(uint32_t x) {
  union {
    unsigned char ch[4];
    long y;
  } U;

  U.y = x;
  return bits[U.ch[0]] + bits[U.ch[1]] + bits[U.ch[3]] + bits[U.ch[2]];
}

INLINE int AR_btbl_bitcount(uint32_t x) {
  unsigned char* Ptr = (unsigned char*)&x;
  int Accu;

  Accu = bits[*Ptr++];
  Accu += bits[*Ptr++];
  Accu += bits[*Ptr++];
  Accu += bits[*Ptr];
  return Accu;
}

INLINE int ntbl_bitcnt(uint32_t x) {
  int cnt = 0;
  do {
    cnt += bits[(int)(x & 0x0000000FL)];
  } while (0L != (x >>= 4));
  return cnt;
}

INLINE int bit_shifter(uint32_t x) {
  int i, n;
  for (i = n = 0; x && (i < (sizeof(uint32_t) * CHAR_BIT)); ++i, x >>= 1)
    n += (int)(x & 1L);
  return n;
}

int bc_main() {
  unsigned n_0, n_1, n_2, n_3, n_4, n_5, n_6;
  uint32_t seed;
  unsigned iter;
  unsigned func;

  n_0 = 0;
  n_1 = 0;
  n_2 = 0;
  n_3 = 0;
  n_4 = 0;
  n_5 = 0;
  n_6 = 0;

  for (func = 0; func < 7; func++) {
    seed = (uint32_t)SEED;
    if (func == 0) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        checkpoint();
        n_0 += bit_count(seed);  // correct
      }
    } else if (func == 1) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        checkpoint();
        n_1 += bitcount(seed);  // correct
      }
    } else if (func == 2) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        checkpoint();
        n_2 += ntbl_bitcnt(seed);  // correct
      }
    } else if (func == 3) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        checkpoint();
        n_3 += ntbl_bitcount(seed);  // correct
      }
    } else if (func == 4) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        checkpoint();
        n_4 += bit_shifter(seed);  // correct
      }
    } else if (func == 5) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        //        n_5 += AR_btbl_bitcount(seed);  // incorrect
        checkpoint();
        n_5 += 0;
      }
    } else if (func == 6) {
      for (iter = 0; iter < ITER; ++iter, seed += 13) {
        //        n_6 += BW_btbl_bitcount(seed);  // incorrect
        checkpoint();
        n_6 += 0;
      }
    }
  }

  int sum = n_0 + n_1 + n_2 + n_3 + n_4 + n_5 + n_6;
  //  printf("%d\n", n_0);
  //  printf("%d\n", n_1);
  //  printf("%d\n", n_2);
  //  printf("%d\n", n_3);
  //  printf("%d\n", n_4);
  //  printf("%d\n", n_5);
  //  printf("%d\n", n_6);
  // printf("%d\n", sum);

  return sum;
}

// int main(void) {
//  restore();
//  int count = 0;
//
//  while (count < 1) {
// bc_main();
//    count++;
//  }
//  return 0;
//}
