// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct2.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Foo {
  int a;
  int b;
  int c;
};

//
struct Foo foo[3] = {{0, 1, 0}, {2, 3, 0}, {4, 5, 0}};

int index_i(int i) {
#pragma distribution parameter "i <- DiscreteDistribution(supp = 0:2)"
  //#pragma distribution parameter "i <- 2"
  return foo[i].b;
}
// 5
