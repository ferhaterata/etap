// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local6.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Bar {
  int c;
  int d;
};

struct Foo {
  int a;
  long b;
  struct Bar bar;
};

int main(void) {
  const int b = 5;
  const int* a = &b;

  struct Foo foo = {0, 1, {b, 3}};
  foo.a = *a;
  return foo.bar.c;
}
// 5
