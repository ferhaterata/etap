// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.               conditional.c
//   To validate whether the framework handles conditional events correctly.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include "checkpoint.h"
#include "sensor.h"

int conditional3(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"


  int x = n;
  int* xp = &x;
  if (n > 1)
    if (n > 2) return n;  // {3, 4}
  return *xp;  // {1, 2, 3, 4}
}
