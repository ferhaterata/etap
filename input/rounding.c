// -----------------------------------------------------------------------------
//  Test for Probabilistic Execution of rounding.                      rounder.c
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int rounder(float x) {
#pragma distribution parameter "x <- Unif(0, 20)"

  if (x - (int)x >= 0.5) {
    return (int)x + 1;
  } else {
    return (int)x;
  }
}