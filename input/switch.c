// -----------------------------------------------------------------------------
//  Test for Probabilistic Execution of Switch Statement.               switch.c
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int foo(int a) {
#pragma distribution parameter "a <- DiscreteDistribution(supp = 0:10)"

  int b = 0;
  switch (a % 5) {
    case 1:
      b = 0;  // prob = 2 / 11
    case 2:
      b = 0;  // prob = 2 / 11
    case 3:
      b = 0;  // prob = 2 / 11
    case 4:
      b = 0;  // prob = 2 / 11
    default:
      b = 1;  // prob = 3 / 11
  }
  return b;
}
