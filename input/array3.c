// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    array3.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

long nums[3][3] = {{1, 2, 3}, {2, 3, 4}, {3, 4, 5}};
long i = 2;

long index_i2(void) {  //
  return nums[i][i];
}
// 5
