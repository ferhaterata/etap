// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.              array_struct.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct Foo {
  int A;
  char* B;
  double C;
};

struct Foo Foo;
struct Foo Bar[100];

void funct1() {
  Bar[17].C = 0.2;
  Foo.B = "5";
  char** b_ptr = &Foo.B;
}

int* funct2(struct Foo* F) {
  F->A = 5;
  return &F->A;
}