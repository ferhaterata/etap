#include <msp430.h>

int main(void) {
    WDTCTL = WDTPW | WDTHOLD;      // stop watchdog timer
    TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
    TA0CCTL0 = CCIE;               // enable compare reg 0
    TA0CCR0 = 0;                   // 1 s
    _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS


    /// 4 MHz clock rate setup -----------------------------------------------------------------------------------------
    // Clock System Setup

    CSCTL0_H = CSKEY_H;                     // Unlock CS registers
    CSCTL1 = DCOFSEL_0;                     // Set DCO to 1MHz
    // Set SMCLK = MCLK = DCO, ACLK = VLOCLK
    CSCTL2 = SELA__VLOCLK | SELS__DCOCLK | SELM__DCOCLK;
    // Per Device Errata set divider to 4 before changing frequency to
    // prevent out of spec operation from overshoot transient
    CSCTL3 = DIVA__4 | DIVS__4 | DIVM__4;   // Set all corresponding clk sources to divide by 4 for errata
    CSCTL1 = DCOFSEL_3;                     // Set DCO to 4MHz
    CSCTL3 = DIVA__1 | DIVS__1 | DIVM__1;   // Set all dividers to 1 for 8MHz operation
    CSCTL0_H = 0;                           // Lock CS Registers

    /// ----------------------------------------------------------------------------------------------------------------

    /// 8 MHz clock rate setup -----------------------------------------------------------------------------------------
    // Clock System Setup
/*
    CSCTL0_H = CSKEY_H;                     // Unlock CS registers
    CSCTL1 = DCOFSEL_0;                     // Set DCO to 1MHz
    // Set SMCLK = MCLK = DCO, ACLK = VLOCLK
    CSCTL2 = SELA__VLOCLK | SELS__DCOCLK | SELM__DCOCLK;

    // Per Device Errata set divider to 4 before changing frequency to
    // prevent out of spec operation from overshoot transient
    CSCTL3 = DIVA__4 | DIVS__4 | DIVM__4;   // Set all corresponding clk sources to divide by 4 for errata
    CSCTL1 = DCOFSEL_6;                     // Set DCO to 8MHz
    CSCTL3 = DIVA__1 | DIVS__1 | DIVM__1;   // Set all dividers to 1 for 8MHz operation
    CSCTL0_H = 0;                           // Lock CS Registers
*/
    /// ----------------------------------------------------------------------------------------------------------------

    /// 16 MHz clock rate setup ----------------------------------------------------------------------------------------
    // Clock System Setup
    /*
    CSCTL0_H = CSKEY_H;                     // Unlock CS registers
    CSCTL1 = DCOFSEL_0;                     // Set DCO to 1MHz
    // Set SMCLK = MCLK = DCO, ACLK = VLOCLK
    CSCTL2 = SELA__VLOCLK | SELS__DCOCLK | SELM__DCOCLK;
    // Per Device Errata set divider to 4 before changing frequency to
    // prevent out of spec operation from overshoot transient
    CSCTL3 = DIVA__4 | DIVS__4 | DIVM__4;   // Set all corresponding clk sources to divide by 4 for errata
    CSCTL1 = DCOFSEL_4 | DCORSEL;           // Set DCO to 16MHz
    CSCTL3 = DIVA__1 | DIVS__1 | DIVM__1;   // Set all dividers to 1 for 16MHz operation
    CSCTL0_H = 0;                           // Lock CS registers                      // Lock CS registers
    */
    /// ----------------------------------------------------------------------------------------------------------------



    long for_count = 150000;
 
    // long waiting_time = 32768;
    long waiting_time = 8000;
    __asm__ __volatile__(" MOV.A #41200, R8");  // for addressing mode: 10

    int j = 0;
    for (; j < 51; ++j) {

        long i = 0;
        for (; i < for_count; ++i) {
              __asm__ __volatile__("MOV R7, R8");  // 00 0

        }
        TA0CCR0 = waiting_time;
        LPM3;
        // sleep

         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV R7, 1(R8)");  // 00 1
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV 1(R7), R8");  // 01 0
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV 1(R7), 1(R8)");  // 01 1
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV @R8, R7");  // 10 0
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV @R8, 1(R7)");  // 10 1
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV #20, R7");  // 11 0
         }
         TA0CCR0 = waiting_time;
         LPM3;
         // sleep
         i = 0;
         for (; i < for_count; ++i) {
             __asm__ __volatile__("MOV @R8, 1(R7)");  // 11 1

         }
         TA0CCR0 = waiting_time;
         LPM3;

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
