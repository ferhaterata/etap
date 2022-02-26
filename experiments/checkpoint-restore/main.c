#include <msp430.h>

#include "checkpointlib/CheckPoint.h"

/**
 * main.c
 */

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer
    TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
    TA0CCTL0 = CCIE;               // enable compare reg 0
    TA0CCR0 = 0;                   // 1 s
    _BIS_SR(GIE);

    for (int j = 0; j < 50; ++j)
    {
        // energy tracing device is not precise enough to capture one checkpoint
        // function; we divide energy by 10 to find energy consumption of one
        // checkpoint
        for (int i = 100; i > 0; --i)
        {
            restore();
        }
        TA0CCR0 = 32768;
        LPM3;

    }

    // activate low power mode after computation is done
    // so that the power consumption decreases and we can see it on the graph
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
