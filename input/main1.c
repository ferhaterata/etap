// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                     main2.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int main(int argc, char* arv[]) {
  int x = 0;
  for (int i = 1; i < argc; i++) {
    x += atoi(arv[i]);
  }
  return x;
}
