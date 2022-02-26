#include <msp430.h>

// Instructions:
/*{c}
 __asm__ __volatile__("MOV R4, R15");      // addr. mode: 00 0, # of cycles: 1
 __asm__ __volatile__("MOV R5, 1(R6)");    // addr. mode: 00 1, # of cycles: 4
 __asm__ __volatile__("MOV 1(R5), R6");    // addr. mode: 01 0, # of cycles: 3
 __asm__ __volatile__("MOV 1(R5), 1(R6)"); // addr. mode: 01 1, # of cycles: 6
 __asm__ __volatile__("MOV @R8, R10");     // addr. mode: 10 0, # of cycles: 2
 __asm__ __volatile__("MOV @R8, 1(R6)");   // addr. mode: 10 1, # of cycles: 5
 __asm__ __volatile__("MOV #20, R6");      // addr. mode: 11 0, # of cycles: 2
 __asm__ __volatile__("MOV @R8, 1(R6)");   // addr. mode: 11 1, # of cycles: 5
*/

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
  TA0CCTL0 = CCIE;               // enable compare reg 0
  TA0CCR0 = 0;                   // 1 s
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
  int j = 0;
  for (; j < 50; ++j) {
    TA0CCR0 = 32768;
    LPM3;
    // sleep
    long i = 0;
    for (; i < 100000; ++i) {
    }
    TA0CCR0 = 32768;
    LPM3;
    // sleep
  }
  LPM3;
  return 0;
}

#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A(void)
#elif defined(__GNUC__)
void __attribute__((interrupt(TIMER0_A0_VECTOR))) Timer_A(void)
#else
#error Compiler not supported!
#endif
{
  LPM3_EXIT;
  TA0CCR0 = 0;
}
