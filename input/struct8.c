// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                   struct8.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

struct RT {
  int A;
  int B[3][2];
  int C;
};

struct ST {
  struct RT X;
  int Y;
  struct RT Z;
};

struct ST st[2];

int main(void) {
  st[1].Z.B[2][1] = 2;
  struct ST* s = &st[1];  //%s is a pointer to an (array of) %ST structs; ,
  // suppose the pointer value is ADDR
  int i = s->Z.B[2][1];
  return i;
}
