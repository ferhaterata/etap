#include <msp430.h>
#include "checkpointlib/CheckPoint.h"

// checkpoint <-- (mean=6125.558, sd=42.12112)   cycles
//
// PARAMETERS:
// LPM_CURRENT <- 200000 # nA
// BLOCK_COUNT <- 1
// BOOTSTRAP_COUNT<- 10000
// PRECISION_LOOP_COUNT<-1000

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
        for (; i < 1000; ++i) {
            checkpoint();
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
