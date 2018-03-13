#include <stdio.h>

#define BRAM_BASE 0x00000000
#define NPU_BASE 0x00000000
#define UART_IO 0x00000000

void writeUART(int data){
	*((int *)UART_IO) = data;
}

void writeNPU(int data, int address){
	*((int *)(NPU_BASE+address)) = data;
}

void writeBRAM(int data, int address){
	*((int *)(BRAM_BASE+address)) = data;
}

int readBRAM(int address) {
	return *((int *)(BRAM_BASE+address));
}

int readNPU(int address) {
	return *((int *)(NPU_BASE+address));
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
	int bottom = (int)((int)((infloat-((int)infloat)))<<12);
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

