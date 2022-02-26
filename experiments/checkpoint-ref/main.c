#include <msp430.h>
#include <stdlib.h>

#include "checkpointlib/CheckPoint.h"

void compute() {
  // do something
}

void Reset() {
  PMMCTL0 = 0x0008;  // Software Reset
}

void Timer_A0_set() {
  TA0CCR0 = 32768;               // max 65535(0xFFFF)
                                 // if ACLK(32768KHz) -> 32768 = 1s
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
                                 // ACLK -> 32768 KHz
  TA0CCTL0 = CCIE;               // enable compare reg 0
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
}

void Timer_A0_stop() { TA0CTL = MC_0; }

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer

  // Configure GPIO
  P1OUT &= ~BIT0;  // Clear P1.0 output latch for a defined power-on state
  P1DIR |= BIT0;   // Set P1.0 to output direction

  // Disable the GPIO power-on default high-impedance mode to activate
  // previously configured port settings
  PM5CTL0 &= ~LOCKLPM5;

  Timer_A0_set();  // set the timer
                   // (beginning of the program and after every power failure)

  restore();

  while (1) {
    // sense() // random data/fixed data and add some delay
    // switch
    checkpoint();
    P1OUT |= BIT0;  // turn on RED LED

    compute();  // compute

    // transmit() // blink led and add some delay
  }

  return 0;
}

// Timer A0 interrupt service routine
#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A(void)
#elif defined(__GNUC__)
void __attribute__((interrupt(TIMER0_A0_VECTOR))) Timer_A(void)
#else
#error Compiler not supported!
#endif
{
  Timer_A0_stop();  // stop the timer to prevent counting while capacitor
                    // is charging
  P1OUT &= ~BIT0;   // turn off LED
  __delay_cycles(1000000);  // charge time 1s at 1MHz
  Reset();
}
