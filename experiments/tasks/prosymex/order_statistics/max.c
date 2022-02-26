// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       max.c
//    C program to find maximum in arr[] of size n
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

#include "checkpoint.h"

// C function to find maximum in arr[] of size n
int __attribute__((always_inline)) largest(int* arr, int n) {
//#pragma distribution parameter "arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"
#pragma distribution parameter "arr <- memory(5, 14, 18, 9)"
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  checkpoint();
  int max = arr[0];  // Initialize maximum element
  for (int i = 1; i < n; i++)
    if (arr[i] > max) max = arr[i];
  checkpoint();
  return max;
}

int main() {
  checkpoint();
  int arr[] = {10, 324, 45, 90, 8000};
  int n = sizeof(arr) / sizeof(arr[0]);
  int max = largest(arr, n);
  printf("Largest in given array is %d", max);
  return max;  // max = 8000
}

/*
#pragma distribution parameter "arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"
// for.cond should be visited 10 times
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
// for.cond should be visited four times.
#pragma distribution parameter \
    "arr <- env(`0`=5, `1`=14, `2`=DiscreteDistribution(15:16), `3`=8)"
#pragma distribution parameter \
    "arr <- env(`0`=5, `1`=14, `2`=Norm(mean=20, sd=1), `3`=8)"
#pragma distribution parameter "n <- 4"
*/