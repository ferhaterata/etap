#include <msp430.h>

#include "checkpointlib/CheckPoint.h"

#define timer_count 60000

void Reset() {
  PMMCTL0 = 0x0008;  // Software Reset
}

void Timer_A0_set() {
  //  int lower = 1000;
  //  int upper = 65535;i iz
  //  int num = (rand() % (upper - lower + 1)) + lower;
  TA0CCR0 = timer_count;         // max 65535
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
  TA0CCTL0 = CCIE;               // enable compare reg 0
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer

  // Configure GPIO
  P1OUT &= ~BIT0;  // Clear P1.0 output latch for a defined power-on state
  P1DIR |= BIT0;   // Set P1.0 to output direction

  // Disable the GPIO power-on default high-impedance mode to activate
  // previously configured port settings
  PM5CTL0 &= ~LOCKLPM5;

  Timer_A0_set();

  restore();

  while (1) {
    // sense() // random data/fixed data and add some delay
      // switch
    checkpoint();
    P1OUT |= BIT0;  // turn on LED
    // compute()
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
  P1OUT &= ~BIT0;  // turn off LED
  __delay_cycles(1000000);
  Reset();
}
