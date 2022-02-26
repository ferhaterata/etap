#include <msp430fr5994.h>
#include <stdlib.h>

#define LED 0x01    // red LED, change it to 0x02 for green LED

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer

  // Configure GPIO
  P1OUT &= ~LED;  // Clear P1.0 output latch for a defined power-on state
  P1DIR |= LED;   // Set P1.0 to output direction

  // Disable the GPIO power-on default high-impedance mode to activate
  // previously configured port settings
  PM5CTL0 &= ~LOCKLPM5;

  // Turn on the LED
  P1OUT |= LED;
  return 0;
}
