//  ----------------------------------------------------------------------------
//  Header file for the spectre class.                               spectre.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on October 29, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include <stdint.h>

uint32_t SIZE = 16;
uint8_t array1[16], array2[256 * 64], array3[16];

uint8_t foo(uint32_t x) {
  uint8_t temp = 0;
  if (x < SIZE) {
    if (x <= 8) {
      temp |= array2[8];
    }
  }
  temp |= array3[8];
  return temp;
}
