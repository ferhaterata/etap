// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    malloc.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdlib.h>

typedef struct {
  int A;
} Foo;

void allocate() {
  Foo* foo = (Foo*)malloc(sizeof(Foo));
  foo->A = 12;
  free(foo);
}