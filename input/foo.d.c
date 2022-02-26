//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                     foo.d.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

// Here I'd like to demonstrate the probabilistic interpretation of return
// This program generated two paths with different weights (not three)
double foo(double x, double y) {  // x and y can take arbitrary real numbers
#pragma distribution parameter "x <- Norm(mean=11, sd=1)"
#pragma distribution parameter "y <- Norm(mean=6, sd=1)"
  if (x < y + 6) {
    double a = 2 * y;
    if (a > -2) return x * y;
  }
  return x;
}
