// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.               conditional.c
//   To validate whether the framework handles conditional events correctly.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int conditional1(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  if (n > 1)
    if (n > 2) return n;
  return n;
}
