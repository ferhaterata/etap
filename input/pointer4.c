// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                  pointer4.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

const int b = 5;
const int* a = &b;

struct Bar {
  int c;
  int d;
  const int* e;
};

struct Foo {
  int a;
  int b;
  struct Bar bar;
};

struct Foo foo = {0, 1, {b, 3, &b}};

const int* index_first(void) {  //
  return foo.bar.e;
}
