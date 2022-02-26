// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct4.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdlib.h>

typedef struct _str {
  int arraySize;
  int* a;
} str;

str s[2];

int main() {
  s[0].arraySize = 3;                                   // array's first element
  s[0].a = (int*)malloc(sizeof(int) * s[0].arraySize);  // heap allocation
  s[0].a[0] = 2;                                        // initialization
  s[0].a[1] = 5;
  s[0].a[2] = 7;
  int x = s[0].a[1] + s[0].a[2];
  return x;
}
// 12
