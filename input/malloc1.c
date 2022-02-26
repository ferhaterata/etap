// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   malloc1.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

typedef struct {
  int A;
} Foo;

extern void* malloc(size_t size);
extern void free(void* value);

void allocate() {
  Foo* foo = (Foo*)malloc(sizeof(Foo));
  foo->A = 12;
  free(foo);
}