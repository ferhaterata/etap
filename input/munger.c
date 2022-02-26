// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                     array.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct munger_struct {
  int f1;
  int f2;
};

void __attribute__((always_inline)) munge(struct munger_struct* P) {
  P[0].f1 = P[1].f1 + P[2].f2;
}

int munger() {
  struct munger_struct Array[3];
  munge(Array);
  return Array[0].f1;
}