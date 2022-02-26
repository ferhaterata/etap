/**********************************************************************
 * Slow and fast implementations of the CRC standards.
 * The parameters for each supported CRC standard are defined in the header file
 * crc.h. The implementations here should stand up to further additions to that
 * list.
 *
 * Copyright (c) 2000 by Michael Barr. This software is placed into
 * the public domain and may be used for any purpose.  However, this
 * notice must not be changed or removed and no warranty is either
 * expressed or implied by its publication or distribution.
 **********************************************************************/
#include <stdio.h>
#include <string.h>

#include "checkpoint.h"

#define INLINE __attribute__((always_inline)) inline

#define FALSE 0
#define TRUE !FALSE

// Select the CRC standard from the list that follows.
#define CRC_CCITT

#if defined(CRC_CCITT)

typedef unsigned short crc;

#define CRC_NAME "CRC-CCITT"
#define POLYNOMIAL 0x1021
#define INITIAL_REMAINDER 0xFFFF
#define FINAL_XOR_VALUE 0x0000
#define REFLECT_DATA FALSE
#define REFLECT_REMAINDER FALSE
#define CHECK_VALUE 0x29B1

#elif defined(CRC16)

typedef unsigned short crc;

#define CRC_NAME "CRC-16"
#define POLYNOMIAL 0x8005
#define INITIAL_REMAINDER 0x0000
#define FINAL_XOR_VALUE 0x0000
#define REFLECT_DATA TRUE
#define REFLECT_REMAINDER TRUE
#define CHECK_VALUE 0xBB3D

#elif defined(CRC32)

typedef unsigned long crc;

#define CRC_NAME "CRC-32"
#define POLYNOMIAL 0x04C11DB7
#define INITIAL_REMAINDER 0xFFFFFFFF
#define FINAL_XOR_VALUE 0xFFFFFFFF
#define REFLECT_DATA TRUE
#define REFLECT_REMAINDER TRUE
#define CHECK_VALUE 0xCBF43926

#else

#error "One of CRC_CCITT, CRC16, or CRC32 must be #define'd."

#endif

// void crcInit(void);
// crc crcSlow(unsigned char const message[], int nBytes);
// crc crcFast(unsigned char const message[], int nBytes);

// Derive parameters from the standard-specific parameters in crc.h.
#define WIDTH (8 * sizeof(crc))
#define TOPBIT (1 << (WIDTH - 1))

#if (REFLECT_DATA == TRUE)
#undef REFLECT_DATA
#define REFLECT_DATA(X) ((unsigned char)reflect((X), 8))
#else
#undef REFLECT_DATA
#define REFLECT_DATA(X) (X)
#endif

#if (REFLECT_REMAINDER == TRUE)
#undef REFLECT_REMAINDER
#define REFLECT_REMAINDER(X) ((crc)reflect((X), WIDTH))
#else
#undef REFLECT_REMAINDER
#define REFLECT_REMAINDER(X) (X)
#endif

/*********************************************************************
 * Reorder the bits of a binary sequence, by reflecting them about
 * the middle position. No checking is done that nBits <= 32.
 * Returns: The reflection of the original data.
 *********************************************************************/
INLINE
static unsigned long reflect(unsigned long data, unsigned char nBits) {
  unsigned long reflection = 0x00000000;
  unsigned char bit;
  // Reflect the data about the center bit.
  for (bit = 0; bit < nBits; ++bit) {
    checkpoint();
    // If the LSB bit is set, set the reflection of it.
    if (data & 0x01) {
      reflection |= (1 << ((nBits - 1) - bit));
    }
    data = (data >> 1);
  }
  return (reflection);
} /* reflect() */

/*********************************************************************
 * Compute the CRC of a given message.
 * Returns: The CRC of the message.
 *********************************************************************/
// INLINE
crc crc_slow(unsigned char const message[], int nBytes) {
#pragma distribution parameter \
    "message <- galloc(\"[10 x i8]\", 49, 50, 51, 52, 53, 54, 55, 56, 57, 0)"
#pragma distribution parameter "nBytes <- 9"

  crc remainder = INITIAL_REMAINDER;
  int byte;
  unsigned char bit;
  // Perform modulo-2 division, a byte at a time.
  for (byte = 0; byte < nBytes; ++byte) {
    checkpoint();
    // Bring the next byte into the remainder.
    remainder ^= (REFLECT_DATA(message[byte]) << (WIDTH - 8));
    // Perform modulo-2 division, a bit at a time.
    for (bit = 8; bit > 0; --bit) {
      // Try to divide the current data bit.
      if (remainder & TOPBIT) {
        remainder = (remainder << 1) ^ POLYNOMIAL;
      } else {
        remainder = (remainder << 1);
      }
      checkpoint();
    }
  }
  // The final remainder is the CRC result.
  return (REFLECT_REMAINDER(remainder) ^ FINAL_XOR_VALUE);
} /* crcSlow() */

// crc CrcTable[256];

/*********************************************************************
 * Populate the partial CRC lookup table.
 * This function must be rerun any time the CRC standard is changed. If desired,
 * it can be run "offline" and the table results stored in an embedded system's
 * ROM.
 *********************************************************************/
// INLINE
// void crcInit(void) {
//  crc remainder;
//  int dividend;
//  unsigned char bit;
//  // Compute the remainder of each possible dividend.
//  for (dividend = 0; dividend < 256; ++dividend) {
//    // Start with the dividend followed by zeros.
//    remainder = dividend << (WIDTH - 8);
//    // Perform modulo-2 division, a bit at a time.
//    for (bit = 8; bit > 0; --bit) {
//      // Try to divide the current data bit.
//      if (remainder & TOPBIT) {
//        remainder = (remainder << 1) ^ POLYNOMIAL;
//      } else {
//        remainder = (remainder << 1);
//      }
//    }
//    // Store the result into the table.
//    CrcTable[dividend] = remainder;
//  }
//} /* crcInit() */

/*********************************************************************
 * Compute the CRC of a given message.
 * crcInit() must be called first.
 * Returns: The CRC of the message.
 *********************************************************************/
//// INLINE
// crc crcFast(unsigned char const message[], int nBytes) {
//#pragma distribution parameter \
//    "message <- galloc(\"[10 x i8]\", 49, 50, 51, 52, 53, 54, 55, 56, 57, 0)"
//#pragma distribution parameter "nBytes <- 9"
//
//  crcInit();
//  checkpoint();
//  crc remainder = INITIAL_REMAINDER;
//  unsigned char data;
//  int byte;
//  // Divide the message by the polynomial, a byte at a time.
//  for (byte = 0; byte < nBytes; ++byte) {
//    data = REFLECT_DATA(message[byte]) ^ (remainder >> (WIDTH - 8));
//    remainder = CrcTable[data] ^ (remainder << 8);
//  }
//  // The final remainder is the CRC.
//
//  checkpoint();
//  return (REFLECT_REMAINDER(remainder) ^ FINAL_XOR_VALUE);
//} /* crcFast() */

// int main(void) {
//  unsigned char test[] = "123456789";
//
//  // Print the check value for the selected CRC algorithm.
//  printf("The check value for the %s standard is 0x%X\n", CRC_NAME,
//         CHECK_VALUE);
//
//  // Compute the CRC of the test message, slowly.
//  crc c = crcSlow(test, 9);
//  printf("The crcSlow() of \"123456789\" is in hex 0x%X\n", c);
//  printf("The crcSlow() of \"123456789\" is in decimal: %hu\n", c);
//
//  // Compute the CRC of the test message, more efficiently.
//  crcInit();
//  printf("The crcFast() of \"123456789\" is 0x%X\n",
//         crcFast(test, strlen(test)));
//  c = crcFast(test, 9);
//  return c;
//} /* main() */
