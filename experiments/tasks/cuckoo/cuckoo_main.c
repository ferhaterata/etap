/*
 * cuckoo_main.c
 *
 *  Created on: 27 Mar 2021
 *      Author: eren
 */

/*
 * MIT License
 *
 * Copyright (c) 2020 Eren Yildiz and Kasim Sinan Yildirim
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Adapted from:
 * https://raw.githubusercontent.com/CMUAbstract/alpaca-oopsla2017/master/src/main_cuckoo_dino.c
 *
 */

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

void checkpoint() {
#pragma reliability timing cost "6e+06"  // us
#pragma reliability energy cost "10300000"  // nj
#pragma intermittent capacitor(100, 2000)
#pragma intermittent checkpoint
  return;
}

void restore() {
#pragma reliability timing cost "6e+06"  // us
#pragma reliability energy cost "10300000"  // nj
  return;
}

//#include "leds.h"
#define INLINE __attribute__((always_inline)) inline

//#define NUM_BUCKETS 256 // must be a power of 2
#define NUM_BUCKETS 128  // must be a power of 2
//#define NUM_BUCKETS 64 // must be a power of 2
#define MAX_RELOCATIONS 8

typedef uint16_t value_t;
typedef uint16_t hash_t;
typedef uint16_t fingerprint_t;
typedef uint16_t index_t;  // bucket index

#define NUM_KEYS (NUM_BUCKETS / 4)  // shoot for 25% occupancy
#define INIT_KEY 0x1

INLINE static hash_t djb_hash(uint8_t* data, unsigned len) {
  uint32_t hash = 5381;
  unsigned int i;

  for (i = 0; i < len; data++, i++) hash = ((hash << 5) + hash) + (*data);

  return hash & 0xFFFF;
}

INLINE static index_t hash_fp_to_index(fingerprint_t fp) {
  hash_t hash = djb_hash((uint8_t*)&fp, sizeof(fingerprint_t));
  return hash & (NUM_BUCKETS - 1);  // NUM_BUCKETS must be power of 2
}

INLINE static index_t hash_key_to_index(value_t fp) {
  hash_t hash = djb_hash((uint8_t*)&fp, sizeof(value_t));
  return hash & (NUM_BUCKETS - 1);  // NUM_BUCKETS must be power of 2
}

INLINE static fingerprint_t hash_to_fingerprint(value_t key) {
  return djb_hash((uint8_t*)&key, sizeof(value_t));
}

INLINE static value_t generate_key(value_t prev_key) {
  // insert pseufo-random integers, for testing
  // If we use consecutive ints, they hash to consecutive DJB hashes...
  // NOTE: we are not using rand(), to have the sequence available to verify
  // that that are no false negatives (and avoid having to save the values).
  return (prev_key + 1) + 17;  // REVIEW: multiplication replaced with addition.
}

INLINE static bool insert(fingerprint_t* filter, value_t key) {
  fingerprint_t fp1, fp2, fp_victim, fp_next_victim;
  index_t index_victim, fp_hash_victim;
  unsigned relocation_count = 0;

  fingerprint_t fp = hash_to_fingerprint(key);

  index_t index1 = hash_key_to_index(key);

  index_t fp_hash = hash_fp_to_index(fp);
  index_t index2 = index1 ^ fp_hash;

  fp1 = filter[index1];

  if (!fp1) {  // slot 1 is free
    filter[index1] = fp;
  } else {
    fp2 = filter[index2];
    if (!fp2) {  // slot 2 is free
      filter[index2] = fp;
    } else {              // both slots occupied, evict
      if (0x12 & 0x80) {  // don't use lsb because it's systematic
        index_victim = index1;
        fp_victim = fp1;
      } else {
        index_victim = index2;
        fp_victim = fp2;
      }

      filter[index_victim] = fp;  // evict victim

      do {  // relocate victim(s)
        fp_hash_victim = hash_fp_to_index(fp_victim);
        index_victim = index_victim ^ fp_hash_victim;

        fp_next_victim = filter[index_victim];
        filter[index_victim] = fp_victim;

        fp_victim = fp_next_victim;
      } while (fp_victim && ++relocation_count < MAX_RELOCATIONS);

      if (fp_victim) {
        return false;
      }
    }
  }

  return true;
}

INLINE static bool lookup(fingerprint_t* filter, value_t key) {
  fingerprint_t fp = hash_to_fingerprint(key);
  index_t index1 = hash_key_to_index(key);

  index_t fp_hash = hash_fp_to_index(fp);
  index_t index2 = index1 ^ fp_hash;
  return filter[index1] == fp || filter[index2] == fp;
}

int cuckoo_main() {
  unsigned i;
  value_t volatile key;
  fingerprint_t filter[NUM_BUCKETS];

  for (i = 0; i < NUM_BUCKETS; ++i) filter[i] = 0;

  key = INIT_KEY;
  unsigned inserts = 0;
  for (i = 0; i < NUM_KEYS; ++i) {
    checkpoint();
    key = generate_key(key);
    checkpoint();
    bool success = insert(filter, key);
    inserts += success;
  }

  printf("%d\n", inserts);

  key = INIT_KEY;
  unsigned members = 0;
  for (i = 0; i < NUM_KEYS; ++i) {
    checkpoint();
    key = generate_key(key);
    checkpoint();
    bool member = lookup(filter, key);
    if (!member) {
      checkpoint();
      fingerprint_t fp = hash_to_fingerprint(key);
    }
    members += member;
  }

  printf("%d\n", members);

  return inserts + members;
}

// int main(void) {
//  WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer
//  PM5CTL0 &= ~LOCKLPM5; // Disable the GPIO power-on default high-impedance
//  mode P3DIR=0xFF;

//  restore();
//  int count=0;

//  while(count<100){
// cuckoo_main();
//    P3OUT ^=0x02;
//    P3OUT ^=0x02;
//    count++;
//  }
//  return 0;
//}
