// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    array5.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int arr[2][3][4] = {{{1, 2, 3, 4}, {5, 2, 3, 4}, {1, 2, 3, 4}},
                    {{1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}}};
int i;
int k;

long index_i2k(void) {  //
  return arr[i][i + 1][k];
}
// 5
