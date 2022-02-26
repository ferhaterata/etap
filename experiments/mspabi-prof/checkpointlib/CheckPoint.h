/*
 * CheckPointt.h
 *
 *  Created on: 19 Nis 2020
 *      Author: eren
 */

#ifndef CHECKPOINT_H_
#define CHECKPOINT_H_

#define __nv  __attribute__((section(".persistent")))
void checkpoint();
extern inline void restore();




#endif /* CHECKPOINT_H_ */
