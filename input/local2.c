// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    local2.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int index_i(void) {
  int nums[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
  int i = 2;
#pragma distribution variable "i <- DiscreteDistribution(0;3)"
  return nums[i];
}
