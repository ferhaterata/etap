//#include <CheckPoint.h>
#include <msp430.h>

#define __nv __attribute__((section(".persistent")))
#define xstr(s) str(s)
#define str(s) #s
typedef struct {
  unsigned int reg[34];
  unsigned int data[RAM_LENGTH];

} saver __attribute__((aligned(2)));

__nv unsigned int base_addrs_ram;
__nv unsigned int base_addrs_ram_size = RAM_LENGTH;
__nv unsigned int* data_ptr;
__nv unsigned int* ram_ptr = RAM_START;
__nv volatile unsigned int check = 0;
__nv saver dataSec;
//__nv unsigned int i;

static inline __dma_word_copy(unsigned int from, unsigned int to,
                              unsigned short size) {
  // Configure DMA channel 0
  __data16_write_addr((unsigned short)&DMA0SA, (unsigned long)from);
  // Source block address
  __data16_write_addr((unsigned short)&DMA0DA, (unsigned long)to);
  // Destination single address
  DMA0SZ = size;                                    // Block size
  DMA0CTL = DMADT_5 | DMASRCINCR_3 | DMADSTINCR_3;  // Rpt, inc
  DMA0CTL |= DMAEN;                                 // Enable DMA0
  DMA0CTL |= DMAREQ;                                // Trigger block transfer
}

void checkpoint() {
  // SAVE Registers

  __asm__ __volatile__(" PUSH SP");
  __asm__ __volatile__(" PUSH 8(SP)");
  __asm__ __volatile__(" PUSH SR");
  __asm__ __volatile__(" PUSH R15");
  __asm__ __volatile__(" PUSH R15");
  __asm__ __volatile__(" MOV.A R15,0(SP)");
  __asm__ __volatile__(" MOV # " xstr(dataSec) ",R15");
  __asm__ __volatile__(" MOV.A R3,0(R15)");
  __asm__ __volatile__(" MOV.A R4,4(R15)");
  __asm__ __volatile__(" MOV.A R5,8(R15)");
  __asm__ __volatile__(" MOV.A R6,12(R15)");
  __asm__ __volatile__(" MOV.A R7,16(R15)");
  __asm__ __volatile__(" MOV.A R8,20(R15)");
  __asm__ __volatile__(" MOV.A R9,24(R15)");
  __asm__ __volatile__(" MOV.A R10,28(R15)");
  __asm__ __volatile__(" MOV.A R11,32(R15)");
  __asm__ __volatile__(" MOV.A R12,36(R15)");
  __asm__ __volatile__(" MOV.A R13,40(R15)");
  __asm__ __volatile__(" MOV.A R14,44(R15)");
  __asm__ __volatile__(" MOV.A 0(SP),R14");
  __asm__ __volatile__(" MOV.A R14,48(R15)");
  __asm__ __volatile__(" MOV.A 44(R15),R14");
  __asm__ __volatile__(" POP 52(R15)");
  __asm__ __volatile__(" POP 52(R15)");
  __asm__ __volatile__(" POP 52(R15)");  // SR
  __asm__ __volatile__(" POP 56(R15)");  // PC
  __asm__ __volatile__(" POP 60(R15)");  // SP
  __asm__ __volatile__(" MOV.A 48(R15),R15");

  /*
      __asm__ __volatile__ (" PUSH R14");
      __asm__ __volatile__ (" PUSH R13");
      __asm__ __volatile__ (" PUSH R12");
      __asm__ __volatile__ (" PUSH R11");
      __asm__ __volatile__ (" PUSH R10");
      __asm__ __volatile__ (" PUSH R9");
      __asm__ __volatile__ (" PUSH R8");
      __asm__ __volatile__ (" PUSH R7");
      __asm__ __volatile__ (" PUSH R6");
      __asm__ __volatile__ (" PUSH R5");
      __asm__ __volatile__ (" PUSH R4");
      __asm__ __volatile__ (" PUSH R3");


      __asm__ __volatile__ (" MOV # " xstr(dataSec) ",R7");
      __asm__ __volatile__ (" POP 0(R7)");  //R3
      __asm__ __volatile__ (" POP 2(R7)");  //R4
      __asm__ __volatile__ (" POP 4(R7)");  //R5
      __asm__ __volatile__ (" POP 6(R7)");  //R6
      __asm__ __volatile__ (" POP 8(R7)");  //R7
      __asm__ __volatile__ (" POP 10(R7)");  //R8
      __asm__ __volatile__ (" POP 12(R7)"); //R9
      __asm__ __volatile__ (" POP 14(R7)"); //R10
      __asm__ __volatile__ (" POP 16(R7)"); //R11
      __asm__ __volatile__ (" POP 18(R7)"); //R12
      __asm__ __volatile__ (" POP 20(R7)"); //R13
      __asm__ __volatile__ (" POP 22(R7)"); //R14
      __asm__ __volatile__ (" POP 24(R7)"); //R15
      __asm__ __volatile__ (" POP 26(R7)"); //SR
      __asm__ __volatile__ (" POP 28(R7)"); //PC
      __asm__ __volatile__ (" POP 30(R7)"); //SP

      __asm__ __volatile__ (" MOV 8(R7) ,R7");

      */
  // save RAM
  base_addrs_ram = RAM_START;
  data_ptr = &dataSec.data[0];
  __dma_word_copy(base_addrs_ram, data_ptr, base_addrs_ram_size);
  // DMA0CTL |= DMAREQ;                      // Trigger block transfer

  /*
      __asm__ __volatile__ (" PUSH 30(R7)"); //SR
      __asm__ __volatile__ (" PUSH 0(R7)");  //R3
      __asm__ __volatile__ (" PUSH 2(R7)");  //R4
      __asm__ __volatile__ (" PUSH 4(R7)");  //R5
      __asm__ __volatile__ (" PUSH 6(R7)");  //R6
      __asm__ __volatile__ (" PUSH 8(R7)");  //R7
      __asm__ __volatile__ (" PUSH 10(R7)");  //R8
      __asm__ __volatile__ (" PUSH 12(R7)"); //R9
      __asm__ __volatile__ (" PUSH 14(R7)"); //R10
      __asm__ __volatile__ (" PUSH 16(R7)"); //R11
      __asm__ __volatile__ (" PUSH 18(R7)"); //R12
      __asm__ __volatile__ (" PUSH 20(R7)"); //R13
      __asm__ __volatile__ (" PUSH 22(R7)"); //R14
      __asm__ __volatile__ (" PUSH 24(R7)"); //R15



      __asm__ __volatile__ (" POP R15");
      __asm__ __volatile__ (" POP R14");
      __asm__ __volatile__ (" POP R13");
      __asm__ __volatile__ (" POP R12");
      __asm__ __volatile__ (" POP R11");
      __asm__ __volatile__ (" POP R10");
      __asm__ __volatile__ (" POP R9");
      __asm__ __volatile__ (" POP R8");
      __asm__ __volatile__ (" POP R7");
      __asm__ __volatile__ (" POP R6");
      __asm__ __volatile__ (" POP R5");
      __asm__ __volatile__ (" POP R4");
      __asm__ __volatile__ (" POP R3");
      __asm__ __volatile__ (" POP SR");

  */

  check = 1;
}

void restore() {
  if (check == 0) {
    return;
  }

  // restore RAM

  base_addrs_ram = RAM_START;
  data_ptr = &dataSec.data[0];
  __dma_word_copy(data_ptr, base_addrs_ram, base_addrs_ram_size);
  // DMA0CTL |= DMAREQ;                      // Trigger block transfer

  // RESTORE Registers

  __asm__ __volatile__(" MOV # " xstr(dataSec) ",R15");
  __asm__ __volatile__(" MOV 60(R15) ,SP");
  __asm__ __volatile__(" MOV 56(R15) ,4(SP)");
  __asm__ __volatile__(" MOV 52(R15) ,SR");

  __asm__ __volatile__(" MOV.A 44(R15) ,R14");
  __asm__ __volatile__(" MOV.A 40(R15) ,R13");
  __asm__ __volatile__(" MOV.A 36(R15) ,R12");
  __asm__ __volatile__(" MOV.A 32(R15) ,R11");
  __asm__ __volatile__(" MOV.A 28(R15) ,R10");
  __asm__ __volatile__(" MOV.A 24(R15) ,R9");
  __asm__ __volatile__(" MOV.A 20(R15) ,R8");
  __asm__ __volatile__(" MOV.A 16(R15) ,R7");
  __asm__ __volatile__(" MOV.A 12(R15) ,R6");
  __asm__ __volatile__(" MOV.A 8(R15) ,R5");
  __asm__ __volatile__(" MOV.A 4(R15) ,R4");
  __asm__ __volatile__(" MOV.A 2(R15) ,R3");
  __asm__ __volatile__(" MOV.A 48(R15) ,R15");
  /*

      __asm__ __volatile__ (" PUSH 32(R7)"); //SP
      __asm__ __volatile__ (" POP SP");
      __asm__ __volatile__ (" PUSH 30(R7)"); //SR
      __asm__ __volatile__ (" PUSH 28(R7)"); //PCH
      __asm__ __volatile__ (" PUSH 26(R7)"); //PCL
      __asm__ __volatile__ (" PUSH 24(R7)"); //R15
      __asm__ __volatile__ (" PUSH 22(R7)"); //R14
      __asm__ __volatile__ (" PUSH 20(R7)"); //R13
      __asm__ __volatile__ (" PUSH 18(R7)"); //R12
      __asm__ __volatile__ (" PUSH 16(R7)"); //R11
      __asm__ __volatile__ (" PUSH 14(R7)"); //R10
      __asm__ __volatile__ (" PUSH 12(R7)"); //R9
      __asm__ __volatile__ (" PUSH 10(R7)");  //R8
      __asm__ __volatile__ (" PUSH 8(R7)");  //R7
      __asm__ __volatile__ (" PUSH 6(R7)");  //R6
      __asm__ __volatile__ (" PUSH 4(R7)");  //R5
      __asm__ __volatile__ (" PUSH 2(R7)");  //R4
      __asm__ __volatile__ (" PUSH 0(R7)");  //R3

      __asm__ __volatile__ (" POP R3");
      __asm__ __volatile__ (" POP R4");
      __asm__ __volatile__ (" POP R5");
      __asm__ __volatile__ (" POP R6");
      __asm__ __volatile__ (" POP R7");
      __asm__ __volatile__ (" POP R8");
      __asm__ __volatile__ (" POP R9");
      __asm__ __volatile__ (" POP R10");
      __asm__ __volatile__ (" POP R11");
      __asm__ __volatile__ (" POP R12");
      __asm__ __volatile__ (" POP R13");
      __asm__ __volatile__ (" POP R14");
      __asm__ __volatile__ (" POP R15");
      __asm__ __volatile__ (" POP 6(SP)");
      __asm__ __volatile__ (" POP 2(SP)");
      __asm__ __volatile__ (" POP SR");

  */
}
