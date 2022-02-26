// -----------------------------------------------------------------------------
//  Test for Probabilistic Execution of an esoteric loop.               loop-1.c
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

// infinite loop prob=0.30
void foo(int x) {
#pragma distribution parameter "x <- DiscreteDistribution(supp = 0:14)"
  for (int i = 0; i < 14;) {
    i = i - 5;
    i = i + x;
  }
}