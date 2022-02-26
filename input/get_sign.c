//  ----------------------------------------------------------------------------
//  Header file for the spectre class.                                get_sign.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on October 29, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "checkpoint.h"
#include "sensor.h"

int __attribute__((always_inline)) get_sign(int x) {
#pragma distribution parameter "x <- DiscreteDistribution(supp = -1000:1000)"
  if (x == 0) {
    return 0;
  }
  if (x < 0) {
    return -1;
  } else {
    return 1;
  }
}

int main() {
#pragma reliability analysis start
  for (int i = 0; i < 100; ++i) {
    checkpoint();
    int a;

#pragma probability behaviour "Norm(mean=100,sd=50)"
#pragma reliability timing cost "Norm(mean=15,sd=3)"
#pragma reliability energy cost "25"
#pragma distribution variable "a <- DiscreteDistribution(supp = -1000:1000)"
#pragma probability external event
    read(&a);

    int b = get_sign(a);

#pragma reliability call timing cost "io$timing$write"
#pragma reliability call energy cost "Norm(mean=25,sd=5)"
    write("%d\n", b);

    checkpoint();
  }
#pragma reliability analysis end
  return 0;
}
