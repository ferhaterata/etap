// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.               conditional.c
//   To validate whether the framework handles conditional events correctly.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int conditional4(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp=1:4)"
#pragma distribution parameter "y <- DiscreteDistribution(supp=5:8)"
  if (x - y > 1) return x;
  return y;
}
