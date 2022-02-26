// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                  andornot.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int a = 5;
// char* str = "probabilistic symbolic simulation";

int And(int x, int y) {
#pragma distribution parameter "x <- 0"
#pragma distribution parameter "y <- 2 * DiscreteDistribution(1) + 1"
  if (x == 0 && y == 3) {
    return a + 3;
  }
  return -1;
}

int Or(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(0)"
#pragma distribution parameter "y <- DiscreteDistribution(1)"
  if (x == 0 || y == 2) {
    return 0;
  }
  return -1;
}

int Not(int x) {
#pragma distribution parameter \
    "x <- DiscreteDistribution(supp = c(1, 0), prob = c(0.4, 0.6))"
  if (x != 0) {
    return 0;  // 0.4
  }
  return -1;  // 0.6
}

double NotEq(double x) {
#pragma distribution parameter "x <- Unif(Min=0, Max=1)"
  if (x != 0) {
    return 0;  // 0.99
  }
  return -1;  // 0.01
}

// long nums[] = {1, 2, 3};
//
// long index_first(void) {  //
//  return nums[0];
//}