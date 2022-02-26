// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local3.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

long index_i2(void) {
  long nums[3][3] = {{1, 2, 3}, {2, 3, 4}, {3, 4, 5}};
  long i = 2;
  { long i = 1; }
  return nums[i][i];
}
// 5
