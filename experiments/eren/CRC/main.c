/**********************************************************************
 *
 * Filename:    main.c
 * 
 * Description: A simple test program for the CRC implementations.
 *
 * Notes:       To test a different CRC standard, modify crc.h.
 *
 * 
 * Copyright (c) 2000 by Michael Barr.  This software is placed into
 * the public domain and may be used for any purpose.  However, this
 * notice must not be changed or removed and no warranty is either
 * expressed or implied by its publication or distribution.
 **********************************************************************/
#define printf(...)
#include <msp430.h>
//#include "../bareBench.h"
#include <stdio.h>
//#include <string.h>

#include "crc.h"
#include "checkpointlib/CheckPoint.h"

int
main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer
    PM5CTL0 &= ~LOCKLPM5; // Disable the GPIO power-on default high-impedance mode
    P3DIR=0xFF;

    restore();

    int count=0;

    while(count<50){
	unsigned char  test[] = "123456789";
	crc volatile crcSlow_r;
	crc volatile crcFast_r;

	crcSlow_r = crcSlow(test,9);

    }

  return 0;
}   /* main() */


