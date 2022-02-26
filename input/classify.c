//  ----------------------------------------------------------------------------
//  Header file for the spectre class.                                classify.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on April 27, 2021.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "checkpoint.h"
#include "sensor.h"

int classify(int data) {
#pragma distribution parameter \
    "data <- Mixing(Binom(40, 0.4), 15 + Binom(30, 0.6), mixCoeff = c(0.7, 0.3))"
  int result = -1;
  checkpoint();
  if (data < 21) {
    featurize(data);
    result = 1;
    checkpoint();
  } else if (data > 27) {
    alert();
    result = 0;
    checkpoint();
  } else
    error();
  checkpoint();
  return result;
}
