//  ----------------------------------------------------------------------------
//  Header file for the spectre class.                              checkpoing.h
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on October 29, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef CHECKPOINT_H
#define CHECKPOINT_H

void checkpoint() {
#pragma reliability timing cost "6e+06"  // us
#pragma reliability energy cost "10300000"  // nj
#pragma intermittent capacitor(520200, 781250)  // nj
#pragma intermittent checkpoint
  return;
}

void restore() {
#pragma reliability timing cost "6e+06"  // us
#pragma reliability energy cost "10300000"  // nj
  return;
}
#endif  // CHECKPOINT_H
