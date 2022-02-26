// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                  pointer3.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int c = 5;
const int* b = &c;
const int** a = &b;

int index_first(void) {  //
  return **a;
}
