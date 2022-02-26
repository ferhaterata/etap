//  ----------------------------------------------------------------------------
//  Header file for the checkpointing library.                      checkpoing.h
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on April 27, 2021.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef CHECKPOINT_H
#define CHECKPOINT_H

void checkpoint() {
#pragma reliability timing cost "distr::Norm(8517.05, 0.01)"  // us - 1MHz
#pragma reliability energy cost "distr::Norm(14560, 20)"      // nj - 1MHz

  //#pragma reliability timing cost "distr::Norm(1789.5, 45.73)"   // us - 16MHz
  //#pragma reliability energy cost "distr::Norm(7089.16, 43.33)"  // nj - 16MHz

//#pragma intermittent capacitor(26010000, 39062500)  // nj - 50mF
//#pragma intermittent capacitor(5202000, 7812500)  // 10mf
#pragma intermittent capacitor(2601000, 3906250)  // 5mf
//#pragma intermittent capacitor(1040400, 1562500)  // 2mf
//#pragma intermittent capacitor(520200, 781250)  // 1mf

//  # 1 mF capacitance 40 cm distance profile: 41ms
//  harvesting_time <- 10000 # us
//  # 2 mF capacitance 40 cm distance profile: 72ms
//  harvesting_time <- 20000 # us
//  # 5 mF capacitance 40 cm distance profile: 169ms
//  harvesting_time <- 40000 # us
//  # 10 mF capacitance 40 cm distance profile: 331ms
//  harvesting_time <- 80000 # us
#pragma intermittent checkpoint
  return;
}

void restore() {
#pragma reliability timing cost "distr::Norm(8409.47, 0.01)"  // us - 1MHz
#pragma reliability energy cost "distr::Norm(11024.3, 30)"    // nj - 1MHz
//#pragma reliability timing cost "distr::Norm(8409.47, 0.01)"  // us - 16MHz
//#pragma reliability energy cost "distr::Norm(5512.15, 15)"    // nj - 16MHz
#pragma etap restart
  return;
}
#endif  // CHECKPOINT_H
