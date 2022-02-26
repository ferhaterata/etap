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
            //checkpoint();
        }

    }

    // activate low power mode after computation is done
    // so that the power consumption decreases and we can see it on the graph
    LPM3;

    return 0;
}
