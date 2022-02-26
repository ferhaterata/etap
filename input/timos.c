//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                     timos.c
//    A piece of code that Timos wanted to analyze.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

void timos_deterministic(void) {
  int i = 4;
  while (i > 0) i--;
}

void timos_random_continuous(double i) {
#pragma distribution parameter "i <- Unif(Min=0, Max=4)"
  while (i > 0) i--;
}

void timos_random_continuous_1(double i, double k) {
#pragma distribution parameter "i <- Unif(Min=0, Max=4)"
#pragma distribution parameter "k <- Unif(Min=0, Max=1)"
  while (i > 0) i = i - k;
}

void timos_random_discrete(int i) {
#pragma distribution parameter "i <- DiscreteDistribution(0:4)"
  while (i > 0) i--;
}

void timos_random_continuous_2(double i) {
#pragma distribution parameter "i <- Unif(0,4)"
  while (i > 0.25) i--;
}
