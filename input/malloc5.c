// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   malloc5.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

struct S {
  int data[2];
};  // struct definition

struct S buf = {{0, 1}};  // global var.: constant initialization

int main(void) {
  int i = 3;      // stack allocation of i32
  int* q = NULL;  // null pointer assignment
  struct S* p;    // stack allocation of struct*

  if (buf.data[0] == 0)  // should be visited
    q = &i;              // load/store: pointer/address assignment

  p = &buf;

  if (p->data[1] == 1)  // should be visited
    p->data[0] = *q;    // load/store: indirection

  return buf.data[0];
}
// 3