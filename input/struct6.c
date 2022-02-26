// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct6.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include <stdio.h>

struct S {
  int data[2];
};

int main(void) {
  struct S buf = {{0, 1}};
  struct S* p = &buf;
  return *(p->data + 1);
}
// 1
