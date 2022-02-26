// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       max.c
//    C program to find maximum in arr[] of size n
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>
#include "checkpoint.h"

// C function to find maximum in arr[] of size n
int largest(int* arr, int n) {
#pragma distribution parameter "arr <- memory(5, 14, 18, 9)"
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  checkpoint();
  int max = arr[0];  // Initialize maximum element
  for (int i = 1; i < n; i++)
    if (arr[i] > max) max = arr[i];
  checkpoint();
  return max;
}

