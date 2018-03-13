#include <stdio.h>
#include <time.h>


void delay(unsigned int mseconds) {
   clock_t goal = mseconds + clock();
   while (goal > clock());
}

#define BRAM_BASE 0x0000000000000000
#define NPU_BASE 0x0000000000000000
#define UART_IO 0x0000000000000000

#define NPU_CTRL 0x00000000
#define NPU_WEIGHT 0x00000000
#define NPU_DATA 0x00000000

#define BRAM_NUML 0x00000000
#define BRAM_WSTART 0x00000000
#define BRAM_DATASIZE 0x00000000
#define BRAM_DATASTART 0x00000000
#define BRAM_INSSIZE 0x00000000
#define BRAM_OUTSSIZE 0x00000000

#define OP_START 0x00000000
#define OP_LOADW 0x00000000
#define OP_LOADD 0x00000000

void writeUART(int data){
   *((int *)UART_IO) = data;
}

void writeNPU(int data, int address){
   ((int *)NPU_BASE)[address] = data;
}

void writeBRAM(int data, int address){
   ((int *)BRAM_BASE)[address] = data;
}

int readBRAM(int address) {
   return ((int *)BRAM_BASE)[address];
}

int readNPU(int address) {
   return ((int *)NPU_BASE)[address];
}

int readUART() {
   return *(int *)(UART_IO);
}

int dataConcat(int num1, int num2) {
   int i=num1, j=num2;
   i <<= 16;
   j &= 0x0000FFFF;
   return i+j;
}

int convertFixed(float infloat) {
   int top = ((int)infloat)%8;
   int bottom = (int)((int)((infloat-((int)infloat)))*(4096));
   int ret = 0x0;
   ret += top<<12;
   ret += bottom;
   return ret;
}

int upper(int data) {
   return data>>16;
}

int lower(int data) {
   return data&0x0000FFFF;
}

void poll(int* address, int comp) {
   while(*address!=comp)
      delay(1);
}

void writeDataBRAM() {
   int w1, w2, ww, i, data, ds, ins, outs;
   poll(UART_IO, OP_START);
   writeBRAM(readUART(), 0x0);
   for(i=0;i<256;i++) {
      w1=readUART();
      w2=readUART();
      ww=dataConcat(convertFixed((float)w1), convertFixed((float)w2));
      writeBRAM(ww, BRAM_WSTART+i);
   }
   data=readUART();
   writeBRAM(data, BRAM_DATASIZE);
   ins=readUART();
   writeBRAM(ins, BRAM_INSSIZE);
   outs=readUART();
   writeBRAM(outs, BRAM_OUTSSIZE);
   for(i=0;i<data;i++) {
      ds=readUART();
      writeBRAM(ds, BRAM_DATASTART+i);
   }
}
