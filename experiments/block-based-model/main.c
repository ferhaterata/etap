#include <msp430.h>
// __attribute__((always_inline))
int main(void) {
  WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
  TA0CCTL0 = CCIE;               // enable compare reg 0
  TA0CCR0 = 0;                   // 1 s
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
  int j = 0;
  for (; j < 10; ++j) {
    // interrupt -> make idle
    long i = 0;
    for (; i < 100000; ++i) {
      // checkpoint
      __asm__ __volatile__(" push R5");
      __asm__ __volatile__(" push R14");
      __asm__ __volatile__(" push R12");

      // due to measurement precision
      // _asm_ block 1  -- blocks usually end with a jump, replace
      // them with a similar immediate-to-register inst.

      // restore
      __asm__ __volatile__(" pop R12");
      __asm__ __volatile__(" pop R14");
      __asm__ __volatile__(" pop R5");
    }
    TA0CCR0 = 32768;
    LPM3;  // sleep

    // interrupt -> make idle
    i = 0;
    for (; i < 100000; ++i) {  // active
                               // _asm_ block 2
    }
    TA0CCR0 = 32768;
    LPM3;  // sleep
    i = 0;
    for (; i < 100000; ++i) {  // active
                               // _asm_ block 2
    }
    TA0CCR0 = 32768;
    LPM3;  // sleep
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
