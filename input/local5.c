// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local5.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int pointer(void) {
  int b = 5;
  const int* a = &b;
  return *a;
}
// 5
