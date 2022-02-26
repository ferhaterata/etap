// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct1.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Foo {
  int a;
  int b;
};

struct Foo foo = {0, 1};

int index_first(void) {  //
  return foo.b;
}
