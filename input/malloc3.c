// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   malloc3.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdlib.h>

struct s1 {
  int d;
};

struct s2 {
  struct s1* p;
};  // composite structure

int main(void) {
  struct s1 data;  // stack allocation of `struct s1`
  struct s2* sp;   // stack allocation of `struct s2*` (pointer)
  int a[2];        // stack allocation of `[2 x i32]` (array)

  sp = malloc(sizeof(struct s2));  // allocation a heap region for `struct s2*`
  sp->p = &data;
  sp->p->d = 12;  // assign 12 to stack allocated data via pointer

  a[1] = data.d;  // copying the data to the local array's second element
  free(sp);       // deallocating the heap region
  return a[1];    // return the stack allocated data value
}
// 12
