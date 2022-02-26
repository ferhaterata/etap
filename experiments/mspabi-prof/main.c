#include <msp430.h>
#include "checkpointlib/CheckPoint.h"
/**
 * main.c
 */
__nv int i;
__nv int j;

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer
    TA0CTL = TASSEL__ACLK + MC_1; // set the max period for 16bit timer operation
    TA0CCTL0 = CCIE;               // enable compare reg 0
    TA0CCR0 = 0;                   // 1 s
    _BIS_SR(GIE);

    __asm__ __volatile__ (" MOV #1,R12");
    __asm__ __volatile__ (" MOV #1,R13");
   for(j = 0;j<50;++j)
    {
        for ( i = 0; i < 10000; ++i)
        {
          //  __asm__ __volatile__ (" calla   #__mspabi_mpyi");
        }
        TA0CCR0 = 32768;
        LPM3;
    }
    LPM3;
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
