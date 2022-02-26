// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                      sort.c
//    C program to sort the array in an
//    ascending order using selection sort
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

void __attribute__((always_inline)) swap(int* xp, int* yp) {
#pragma distribution parameter "xp <- DiscreteDistribution(8)"
#pragma distribution parameter "yp <- DiscreteDistribution(5)"
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

int x = 3;
int y = 5;

int main(void) {
  swap(&x, &y);
  return x;
}
// 5
