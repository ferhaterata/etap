//  ----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                       foo.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <assert.h>

double __attribute__((always_inline)) foo(double x, double y) {
#pragma distribution parameter "x <- Norm(mean=11, sd=1)"
#pragma distribution parameter "y <- Norm(mean=5, sd=1)"
  if (x < y + 6) {
    double a = 2 * y;
    if (a > -2) return x * y;
  }
  return x;
}

int bar(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp = 10:11)"
#pragma distribution parameter "y <- DiscreteDistribution(supp = 2:7)"
  if (x < y + 6) {  // if x=10 then y={5,6,7}; if x=11 then y={6,7}
    int a = 2 * y;
    if (a >= 8)  // if x=10 then y={5,6,7}; if x=11 then y={6,7}
      return x * y;
  }
  return x;
}

// we believe this program generates 4 paths
double baz(double x, double y) {
#pragma distribution parameter "x <- Norm(mean=11, sd=1)"
#pragma distribution parameter "y <- Norm(mean=5, sd=1)"
  double z = 0;
  for (int i = 1; i < 3; ++i) {
    z += foo(x, y);
    //    z = z + 1;
  }
  return z;
}

void foobar(int a, int b) {
#pragma distribution parameter "a <- 1"
#pragma distribution parameter "b <- 0"
  //#pragma distribution parameter "a <- DiscreteDistribution(1)"
  //#pragma distribution parameter "b <- DiscreteDistribution(0)"
  int x = 1, y = 0;
  if (a != 0) {
    y = 3 + x;
    if (b == 0)  //
      x = 2 * (a + b);
  }
  assert(x - y != 0);
}

void barfoo(int a, int b) {
#pragma distribution parameter "a <- DiscreteDistribution(2)"
#pragma distribution parameter "b <- DiscreteDistribution(0)"
  int x = 1, y = 0;
  if (a != 0) {
    y = 3 + x;
    if (b == 0)  //
      x = 2 * (a + b);
  }
  assert(x - y != 0);
}

// comparing an arithmetic expression on continuous r.v.s with an equality.
// function calls
// casting: integer to double or double to integer, int2prt
// bit arithmetic -> bernoulli
// pointers and arrays/array size -> poission or exponential
// structs ??
// void return types

// loops
// static int k = 3;
//
//#pragma distribution "x <- Discrete(supp = 0:5)"
// void parametric_loop(int a) {
//  int i; // i <- DiscreteDistribution(0)
//  for (i = 0; i < a; ++i) {
//  }
//}
//
//#pragma distribution "x <- Discrete(supp = 0:5)"
// int unroll_parametric_loop(int a) {
//  int i = 0; // i <- DiscreteDistribution(0)
//  if (i < a) {
//    ++i;
//    if (i < a) {
//      ++i;
//      if (i < a) {
//        ++i;
//      }
//    }
//  }
//  return i;
//}
//
// int static_loop() {
//  int i; // i <- DiscreteDistribution(0)
//  for (i = 0; i < 3; ++i) {
//  }
//  return i;
//}
//
// int unroll_static_loop() {
//  int i = 0; // i <- DiscreteDistribution(0)
//  if (i < 3) {
//    ++i;
//    if (i < 3) {
//      ++i;
//      if (i < 3) {
//        ++i;
//      }
//    }
//  }
//  return i;
//}
