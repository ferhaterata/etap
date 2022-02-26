// -----------------------------------------------------------------------------
//  Test for Probabilistic Execution of an esoteric loop.            factorial.c
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int factorial(int x) {
#pragma distribution parameter "x <-DiscreteDistribution(supp = 0:100)"
  int result = 1;
  for (int i = 0; i < x; ++i) {
    result *= x - i;
  }
  return result;
}