// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   malloc4.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

struct S {
  int data[2];
};

struct S buf = {{0, 1}};

int main(void) {
  int i = 3;
  int* q = NULL;
  struct S* p;

  if (buf.data[1] == 1) q = &i;

  p = &buf;

  if (p->data[1] == 1) p->data[0] = *q;

  return 0;
}
