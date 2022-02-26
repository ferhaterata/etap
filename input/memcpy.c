// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    memcpy.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <string.h>

int main() {
  char str1[15];
  char str2[15];

  int ret;
  memcpy(str1, "abcdefghijkl", 11);
  memcpy(str2, "ABCDEFGHIJKL", 11);

  ret = memcmp(str1, str2, 6);
  printf("%d", ret);
  return ret;
}
