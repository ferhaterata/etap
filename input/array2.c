// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                    array2.c
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

long nums[] = {1, 2, 3};

long i = 1;
//#pragma distribution variable "i <- DiscreteDistribution(0;3)"

long index_i(void) {  //
  return nums[i];
}
// 2
