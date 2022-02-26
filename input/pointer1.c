// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                  pointer1.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int b = 5;
const int* a = &b;

int index_first(void) {  //
  return *a;
}
