#include <msp430.h>

#include "checkpointlib/CheckPoint.h"
#include <stdlib.h>
#include "input.h"
#include "sha.h"
//#define timer_count 60000
#define lower_timer_count 30000
#define upper_timer_count 65535

#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = PORT5_VECTOR
__interrupt void sense(void)
#elif defined(__GNUC__)
void __attribute__((interrupt(PORT5_VECTOR))) sense(void)
#else
#error Compiler not supported!
#endif
{

    P1OUT |= BIT1;              // turn on GREEN LED
   // __delay_cycles(16000);    // sensing time
    P1OUT &= ~BIT1;             // turn off GREEN LED
}

void compute(){
    P1OUT |= BIT0; // turn on RED LED
    /* SHA_INFO sha_info;
       sha_stream(&sha_info, inputString);*/
}

int random_int(int min, int max)
{
   return min + rand() % (max+1 - min);
}
void Reset() {
  PMMCTL0 = 0x0008;  // Software Reset
}

void Timer_A0_set() {
  //  int lower = 1000;
  //  int upper = 65535;
  //  int num = (rand() % (upper - lower + 1)) + lower;
  int timer_count= random_int(lower_timer_count,upper_timer_count); // random power failure
  TA0CCR0 = timer_count;         // max 65535
  TA0CTL = TASSEL__ACLK + MC_1;  // set the max period for 16bit timer operation
  TA0CCTL0 = CCIE;               // enable compare reg 0
  _BIS_SR(GIE);                  // ENABLE GLOBAL INTERRUPTS
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // stop watchdog timer

  // Configure GPIO
  P1OUT &= ~BIT0;  // Clear P1.0 output latch for a defined power-on state
  P1OUT &= ~BIT1;
  P1DIR |= BIT0 ;   // Set P1.0 to output direction
  P1DIR |=  BIT1;   // Set P1.1 to output direction

  // Disable the GPIO power-on default high-impedance mode to activate
  // previously configured port settings


  Timer_A0_set();
  P5DIR &= ~BIT6;
  P5REN |= BIT6;
  P5OUT |= BIT6;


  P5IES |= BIT6;
  P5IFG &= ~BIT6;
  PM5CTL0 &= ~LOCKLPM5;
  P5IE |= BIT6;
  restore();

  while (1) {
    // sense() // random data/fixed data and add some delay
      // switch
    checkpoint();
    //P1OUT |= BIT0;  // turn on RED LED

    compute();      // compute

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
    P1OUT &= ~BIT0; // turn off RED LED

  __delay_cycles(16000); // charge time
  Reset();
}
