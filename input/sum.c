//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       sum.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

// Here I'd like to demonstrate the probabilistic interpretation of return
int sum(int x) {
//#pragma distribution parameter "x <- 5"
#pragma distribution parameter "x <- DiscreteDistribution(supp = 0:10)"
  //#pragma distribution parameter "x <- Unif(0,100)"
  //#pragma distribution parameter "x <- Norm(100,10)"
  int result = 0;
  for (int i = 0; i <= x; ++i) {
    result = result + i;
  }
  return result;
}
// Summation of a finite series.
// 5 * 6 / 2 = 15