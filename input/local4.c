// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local4.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Foo {
  int a;
  int b;
};

int main() {
  struct Foo foo = {0, 1};
  foo.a = 2;
  struct Foo* bar = &foo;
  return bar->b;
}
// 1