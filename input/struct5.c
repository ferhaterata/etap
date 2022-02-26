// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct5.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Bar {
  int c;
  int d;
};

struct Foo {
  int a;
  int b;
  struct Bar bar;
};

struct Foo foo = {0, 1, {2, 3}};

int index_first(void) {  //
  return foo.b;
}
