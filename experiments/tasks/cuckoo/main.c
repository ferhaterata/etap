/*
 * main.c
 *
 *  Created on: 25 Kas 2020
 *      Author: eren
 */

//#include <msp430.h>
#include <stdio.h>

#include "checkpointlib/CheckPoint.h"

int main(void) {
  //  WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer
  //  PM5CTL0 &= ~LOCKLPM5; // Disable the GPIO power-on default high-impedance
  //  mode P3DIR=0xFF;

  //  restore();
  //  int count=0;

  //  while(count<100){
  cuckoo_main();
  //    P3OUT ^=0x02;
  //    P3OUT ^=0x02;
  //    count++;
  //  }
  return 0;
}

