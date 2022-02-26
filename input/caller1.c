// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   caller1.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int callee(const int* X) {
  return *X + 1;  // load
}
int caller() {
  int T;  // on stack
  T = 4;  // store
  return callee(&T);
}
