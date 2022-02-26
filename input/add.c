//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       add.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int add(int x) {
//#pragma distribution parameter "x <- 5"
#pragma distribution parameter "x <- DiscreteDistribution(supp = 0:100)"
  //#pragma distribution parameter "x <- Unif(0,100)"
  //#pragma distribution parameter "x <- Norm(100,10)"
  int result = x;
  for (int i = 0; i <= 1000; ++i) {
    result = result + i;
  }
  return result;
}
