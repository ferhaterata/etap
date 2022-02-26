// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       sin.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include <math.h>
#include <stdio.h>

double func(double value) {
#pragma distribution parameter "value <- 0.5"

  double result;
  result = sin(value);
  printf("The Sine of %f is %f\n", value, result);
  return result;
}
