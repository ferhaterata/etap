#include <stdint.h>
#include <stdio.h>

char p[256];
char q[256];

int secure(uint8_t k) {
#pragma distribution parameter "k <- DiscreteDistribution(supp = 0:255)"
  //  uint8_t k;
  //  scanf("%hhu", &k);
  uint8_t t = 0;
  uint8_t reg1 = p[t];
  uint8_t reg2 = 0;
  if (k <= 127)
    /*load*/ reg2 = q[255 - t];
  else
    /*load*/ reg2 = q[t - 128];

  /*add  */ reg1 = reg1 + reg2;
  /*store*/ p[t] = reg1;

  return 0;
}
