// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct3.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Foo {
  int a;
  int b;
  int c;
};

int index_i(int i) {  //
  struct Foo foo[3];
  foo[i].b = 4;
  return foo[i].b;
}
