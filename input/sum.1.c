//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       sum.c
//    Summation of a finite series.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2021 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int sum(int x) {
#pragma distribution parameter "x <- DiscreteDistribution(supp = 0:100)"
  int result = 0;
  for (int i = 0; i <= x; ++i) {
    result = result + i;
  }
  return result;
}
