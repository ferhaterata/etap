// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                     array.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int main() {
  int vals[4] = {2, 4, 8, 16};
  int x = 0;
  vals[2] = 3;
  x += vals[0];
  x += vals[1];
  x += vals[2];
  return x;
}
