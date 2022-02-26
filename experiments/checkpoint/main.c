#include <msp430.h>

#include "checkpointlib/CheckPoint.h"

/**
 * main.c
 */

#define timer_count 6000

void Reset() {
  PMMCTL0 = 0x0008;  // Software Reset
}

void Timer_A0_set() {
  // int r = rand()%65535+40000;
  TA0CCR0 = timer_count;         // max 65535
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
  TA0CCTL0 = CCIE;               // enable compare reg 0
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer
  Timer_A0_set();
  PM5CTL0 &= ~LOCKLPM5;
  restore();
  P1DIR |= BIT0;

  while (1) {
    checkpoint();
    P1OUT ^= 0x01;
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
  P3OUT ^= 0x01;
  Reset();
}
