#include <msp430.h>
#include <stdlib.h>

#include "checkpointlib/CheckPoint.h"

void compute() {
  // do something
  __delay_cycles(50000);
  P1OUT |= BIT1;  // turn on GREEN LED
  __delay_cycles(1000);
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer

  // Configure GPIO
  P1OUT &= ~BIT0;  // Clear P1.0 output latch for a defined power-on state
  P1DIR |= BIT0;   // Set P1.0 to output direction

  P1OUT &= ~BIT1;  // Clear P1.0 output latch for a defined power-on state
  P1DIR |= BIT1;   // Set P1.0 to output direction

  // Disable the GPIO power-on default high-impedance mode to activate
  // previously configured port settings
  PM5CTL0 &= ~LOCKLPM5;

  //  Timer_A0_set();  // set the timer
  // (beginning of the program and after every power failure)

  // restore();

  while (1) {
    // sense() // random data/fixed data and add some delay

    P1OUT |= BIT0;   // turn on RED LED
    P1OUT &= ~BIT1;  // turn off GREEN LED
    compute();       // compute

    // transmit() // blink led and add some delay
  }

  return 0;
}
