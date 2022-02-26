//  ----------------------------------------------------------------------------
//  Header file for the spectre class.                                  sensor.h
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on April 27, 2021.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef SENSOR_H
#define SENSOR_H

int sample(int* __pin) { return *__pin; }

int transmit(int* __out) { return *__out; }

void featurize(data) {
#pragma reliability timing cost "distr::Norm(8056.47, 211)"  // 1MHz
#pragma reliability energy cost "distr::Norm(11020, 201)"    // 1MHz
  //#pragma reliability timing cost "distr::Norm(2014.18, 211)" // 16 MHz
  //#pragma reliability energy cost "distr::Norm(5510, 201)" // 16 MHz
  return;
}

void alert() {
#pragma reliability timing cost "distr::Norm(5102.4, 234)"  // 1MHz
#pragma reliability energy cost "distr::Norm(9020.3, 250)"  // 1MHz
  //#pragma reliability timing cost "distr::Norm(1275.6, 234)"   // 16 MHz
  //#pragma reliability energy cost "distr::Norm(4510.15, 250)"  // 16 MHz
  return;
}

void error() {
#pragma reliability timing cost "distr::Norm(2067.4, 225)"
#pragma reliability energy cost "distr::Norm(4020.3, 202)"
  //#pragma reliability timing cost "distr::Norm(516.85, 225)"   // 16 MHz
  //#pragma reliability energy cost "distr::Norm(2010.15, 202)"  // 16 MHz
  return;
}

#endif  // SENSOR_H
