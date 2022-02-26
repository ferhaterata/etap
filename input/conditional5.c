// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.               conditional.c
//   To validate whether the framework handles conditional events correctly.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int conditional5(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp=2:5)"
#pragma distribution parameter "y <- DiscreteDistribution(supp=4:7)"
  if (x > 3)
    if (x - y > 0) return x;
  return x;
}