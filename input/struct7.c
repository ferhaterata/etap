// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct6.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

struct S {
  int data[2];
};

struct S buf = {{0, 1}};

int main(void) {
  struct S* p = &buf;     // pointer/address assignment
  buf.data[1] = 3;        // initialization
  return *(p->data + 1);  // pointer arithmetic
}
// 3
