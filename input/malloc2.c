// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    malloc.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdlib.h>

int main(void) {
  int* i = malloc(sizeof(int) * 5);
  *i = 12;
  *(i + 1) = 24;
  int ret = i[1];
  free(i);
  return ret;
}
// 24