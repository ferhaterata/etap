// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                 quicksort.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

__attribute__((always_inline)) inline void swap(int* xp, int* yp) {
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

__attribute__((always_inline)) inline int partition(int arr[], int l, int h) {
  int x = arr[h];
  int i = (l - 1);

  for (int j = l; j <= h - 1; j++) {
    if (arr[j] <= x) {
      i++;
      swap(&arr[i], &arr[j]);
    }
  }
  swap(&arr[i + 1], &arr[h]);
  return (i + 1);
}

__attribute__((always_inline)) inline void quickSort(int arr[], int l, int h) {
  int stack[h - l + 1];  // Create an auxiliary stack
  int top = -1;          // initialize top of stack
  // push initial values of l and h to stack
  stack[++top] = l;
  stack[++top] = h;
  // Keep popping from stack while is not empty
  while (top >= 0) {
    // Pop h and l
    h = stack[top--];
    l = stack[top--];
    // Set pivot element at its correct position in sorted array
    int p = partition(arr, l, h);
    // If there are elements on left side of pivot, then push left side to stack
    if (p - 1 > l) {
      stack[++top] = l;
      stack[++top] = p - 1;
    }
    // If there are elements on right side of pivot, push right side to stack
    if (p + 1 < h) {
      stack[++top] = p + 1;
      stack[++top] = h;
    }
  }
}

int quick_sort_test(int n) {
#pragma distribution parameter \
    "n <- DiscreteDistribution(supp = c(32, 64, 128, 256), prob = c(0.4, 0.3, 0.2, 0.1))"
  int arr[] = {
      78, 99, 94, 81, 65, 61, 88, 3,  34,  37, 71, 24, 13, 16, 16, 90, 55,  52,
      84, 36, 59, 77, 44, 88, 15, 15, 70,  64, 21, 93, 30, 96, 65, 83, 40,  98,
      89, 29, 28, 64, 35, 20, 61, 18, 18,  83, 89, 34, 57, 4,  81, 33, 94,  96,
      20, 83, 52, 57, 36, 35, 87, 49, 79,  35, 49, 83, 16, 74, 63, 79, 73,  14,
      97, 13, 2,  29, 36, 20, 60, 61, 59,  45, 16, 36, 97, 35, 85, 98, 59,  23,
      76, 44, 80, 36, 13, 22, 65, 45, 47,  86, 43, 99, 77, 25, 4,  45, 32,  10,
      37, 29, 71, 28, 95, 4,  1,  8,  54,  43, 77, 94, 87, 65, 83, 98, 24,  99,
      27, 68, 17, 80, 98, 50, 30, 2,  35,  19, 89, 39, 84, 21, 43, 53, 97,  60,
      36, 27, 73, 80, 37, 98, 17, 43, 75,  27, 21, 52, 17, 38, 1,  93, 27,  84,
      41, 19, 89, 98, 27, 15, 3,  60, 43,  21, 7,  95, 33, 27, 52, 79, 18,  94,
      53, 17, 56, 2,  40, 97, 82, 14, 81,  37, 10, 21, 70, 69, 40, 48, 68,  9,
      60, 88, 62, 91, 70, 32, 21, 72, 29,  81, 17, 16, 43, 71, 98, 20, 100, 65,
      80, 56, 76, 87, 93, 64, 71, 48, 14,  60, 36, 68, 6,  82, 77, 23, 58,  68,
      9,  24, 13, 91, 51, 10, 16, 30, 110, 78, 45, 42, 93, 93, 13, 94, 14,  63,
      88, 30, 59, 17};
  //  int n = sizeof(arr) / sizeof(arr[0]);
  quickSort(arr, 0, n - 1);
  return arr[n - 1];
}