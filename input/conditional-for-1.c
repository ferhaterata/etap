//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       add.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int For1(int x) {
//#pragma distribution parameter "x <- 5"
#pragma distribution parameter "x <- DiscreteDistribution(supp = 0:4)"
  //#pragma distribution parameter "x <- Unif(0,100)"
  //#pragma distribution parameter "x <- Norm(100,10)"
  int result = 0;
  for (int i = x; i <= 5; ++i) {
    result = result + 1;
  }
  return result;
}
