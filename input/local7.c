// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local7.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int main(void) {
  int arr[2][3][4] = {{{1, 2, 3, 4}, {1, 9, 3, 4}, {1, 2, 3, 4}},
                      {{1, 2, 3, 4}, {1, 2, 3, 4}, {1, 2, 3, 4}}};
  int i = 0;
  int k = 1;
  return arr[i][i + 1][k];
}
// 9