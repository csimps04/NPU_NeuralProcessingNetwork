

void writeDataBRAM();
//Writes the weights and the data into the BRAM
//Waits for the uart to send the start signal first
//Writes the number of layers, then the weights, then the data size, then the data
