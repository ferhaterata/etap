
#include <msp430.h>
#include "CheckPoint.h"
#define xstr(s) str(s)
#define str(s) #s


typedef struct  {

    unsigned int reg [2][34];
    unsigned int data [2][RAM_LENGTH];
    volatile unsigned int idx;

}saver  __attribute__ ((aligned (2)));

__nv unsigned int base_addrs_ram;
__nv unsigned int base_addrs_ram_size= RAM_LENGTH;
__nv unsigned int *data_ptr;
__nv unsigned int *ram_ptr=RAM_START;
__nv volatile unsigned int check=0;
__nv saver dataSec = {.idx=0};
__nv volatile unsigned int tt=0;
__nv volatile unsigned int *asm_base_addrs_reg;
__nv volatile unsigned int *asm_base_addrs_res_reg;
__nv volatile unsigned int restrore_idx;

inline __dma_word_copy(unsigned int from, unsigned int to, unsigned short size)
{
    // Configure DMA channel 0
    __data16_write_addr((unsigned short) &DMA0SA,(unsigned long) from);
                                              // Source block address
    __data16_write_addr((unsigned short) &DMA0DA,(unsigned long) to);
                                              // Destination single address
    DMA0SZ = size;                          // Block size
    DMA0CTL = DMADT_5 | DMASRCINCR_3 | DMADSTINCR_3; // Rpt, inc
    DMA0CTL |= DMAEN;                         // Enable DMA0
    DMA0CTL |= DMAREQ;                      // Trigger block transfer

}


void checkpoint(){

    // SAVE Registers




    __asm__ __volatile__ (" PUSH SP");
    __asm__ __volatile__ (" PUSH 12(SP)");
    __asm__ __volatile__ (" PUSH 0x00");
    __asm__ __volatile__ (" PUSH SR");

    __asm__ __volatile__ (" PUSH R15");
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


    asm_base_addrs_reg = &dataSec.reg [dataSec.idx];
    __asm__ __volatile__ (" PUSH R15");
    __asm__ __volatile__ (" POP R15");
    __asm__ __volatile__ ("MOVA  %0, R15"
                           : "=m" (asm_base_addrs_reg) );

    __asm__ __volatile__ (" MOV 0(SP),0(R15)");   //R3
    __asm__ __volatile__ (" MOV 2(SP),4(R15)");   //R4
    __asm__ __volatile__ (" MOV 4(SP),8(R15)");   //R5
    __asm__ __volatile__ (" MOV 6(SP),12(R15)");  //R6
    __asm__ __volatile__ (" MOV 8(SP),16(R15)");  //R7
    __asm__ __volatile__ (" MOV 10(SP),20(R15)"); //R8
    __asm__ __volatile__ (" MOV 12(SP),24(R15)"); //R9
    __asm__ __volatile__ (" MOV 14(SP),28(R15)"); //R10
    __asm__ __volatile__ (" MOV 16(SP),32(R15)"); //R11
    __asm__ __volatile__ (" MOV 18(SP),36(R15)"); //R12
    __asm__ __volatile__ (" MOV 20(SP),40(R15)"); //R13
    __asm__ __volatile__ (" MOV 22(SP),44(R15)"); //R14
    __asm__ __volatile__ (" MOV 24(SP),48(R15)"); //R15

    __asm__ __volatile__ (" MOV 26(SP),52(R15)"); //SR
    __asm__ __volatile__ (" MOV 30(SP),56(R15)"); //PC
    __asm__ __volatile__ (" MOV 32(SP),60(R15)"); //SP

    //save RAM
    base_addrs_ram=RAM_START;
    data_ptr=&dataSec.data[dataSec.idx];
    __dma_word_copy(base_addrs_ram,data_ptr,base_addrs_ram_size);
    //DMA0CTL |= DMAREQ;                      // Trigger block transfer


    tt ^=0x01;
    dataSec.idx ^=0x01;


    __asm__ __volatile__ (" MOV 0(R15),R3");   //R3
    __asm__ __volatile__ (" MOV 4(R15),R4");   //R4
    __asm__ __volatile__ (" MOV 8(R15),R5");   //R5
    __asm__ __volatile__ (" MOV 12(R15),R6");  //R6
    __asm__ __volatile__ (" MOV 16(R15),R7");  //R7
    __asm__ __volatile__ (" MOV 20(R15),R8"); //R8
    __asm__ __volatile__ (" MOV 24(R15),R9"); //R9
    __asm__ __volatile__ (" MOV 28(R15),R10"); //R10
    __asm__ __volatile__ (" MOV 32(R15),R11"); //R11
    __asm__ __volatile__ (" MOV 36(R15),R12"); //R12
    __asm__ __volatile__ (" MOV 40(R15),R13"); //R13
    __asm__ __volatile__ (" MOV 44(R15),R14"); //R14


    __asm__ __volatile__ (" MOV 52(R15),SR"); //SR
    __asm__ __volatile__ (" MOV 60(R15),SP"); //SP
    __asm__ __volatile__ (" MOV 48(R15),R15"); //R15


    check=1;

}


void restore() {

    if (check==0){
        return;
    }


    //restore RAM

    restrore_idx = dataSec.idx^0x01;
    base_addrs_ram=RAM_START;
    data_ptr=&dataSec.data[restrore_idx];
    asm_base_addrs_reg = &dataSec.reg [restrore_idx];

   __dma_word_copy(data_ptr,base_addrs_ram,base_addrs_ram_size);
   //DMA0CTL |= DMAREQ;                      // Trigger block transfer


   //asm_base_addrs_res_reg = asm_base_addrs_reg;
    //RESTORE Registers

   __asm__ __volatile__ ("MOVA  %0, R15"
                          : "=m" (asm_base_addrs_reg) );
   __asm__ __volatile__ (" MOV 60(R15) ,SP");
   __asm__ __volatile__ (" MOV.W 56(R15) ,4(SP)");
   __asm__ __volatile__ (" ADD #0x0C ,SP");
   __asm__ __volatile__ (" MOV.W 52(R15) ,SR");

   __asm__ __volatile__ (" MOV.A 44(R15) ,R14");
   __asm__ __volatile__ (" MOV.A 40(R15) ,R13");
   __asm__ __volatile__ (" MOV.A 36(R15) ,R12");
   __asm__ __volatile__ (" MOV.A 32(R15) ,R11");
   __asm__ __volatile__ (" MOV.A 28(R15) ,R10");
   __asm__ __volatile__ (" MOV.A 24(R15) ,R9");
   __asm__ __volatile__ (" MOV.A 20(R15) ,R8");
   __asm__ __volatile__ (" MOV.A 16(R15) ,R7");
   __asm__ __volatile__ (" MOV.A 12(R15) ,R6");
   __asm__ __volatile__ (" MOV.A 8(R15) ,R5");
   __asm__ __volatile__ (" MOV.A 4(R15) ,R4");
   __asm__ __volatile__ (" MOV.A 2(R15) ,R3");
   __asm__ __volatile__ (" PUSH 56(R15)");
   __asm__ __volatile__ (" MOV.A 48(R15) ,R15");
   __asm__ __volatile__ (" POP PC");

}





