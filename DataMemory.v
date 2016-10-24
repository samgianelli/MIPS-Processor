`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, MemOp); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [3:0] MemOp;
    reg [31:0] MemArray [0:1023];

    output reg [31:0] ReadData; // Contents of memory location at Address

    integer i;
    /* Please fill in the implementation here */
    initial begin
        for (i=10'b0000000000; i<=10'b1111111111; i = i+10'b0000000001) begin
            MemArray[i] = 32'h00000000;
        end
        //.word 0, 1, 2, 3, 4 , -1
        MemArray[0] <= 32'd0;
        MemArray[1] <= 32'd1;
        MemArray[2] <= 32'd2;
        MemArray[3] <= 32'd3;
        MemArray[4] <= 32'd4;
        MemArray[5] <= -32'd1;        
    end
    
    always @(posedge Clk) begin
        if (MemWrite == 1'b1)
            if (MemOp[3:0] == 4'b1000) begin  //sh
                if (Address[1:0] == 2'b00) begin
                    MemArray[Address[11:2]][15:0] <= WriteData[15:0];
                end
                else if (Address[1:0] == 2'b00) begin
                    MemArray[Address[11:2]][23:8] <= WriteData[15:0];
                end
                else if (Address[1:0] == 2'b00) begin
                    MemArray[Address[11:2]][31:15] <= WriteData[15:0];
                end
                else begin
                    MemArray[Address[11:2]][15:0] <= WriteData[15:0]; //Not sure
                end               
            end
            else if (MemOp[3:0] == 4'b0100) begin //sb
                if (Address[1:0] == 2'b00) begin
                    MemArray[Address[11:2]][7:0] <= WriteData[7:0];
                end
                else if (Address[1:0] == 2'b01) begin
                    MemArray[Address[11:2]][15:8] <= WriteData[7:0];
                end
                else if (Address[1:0] == 2'b10) begin
                    MemArray[Address[11:2]][23:16] <= WriteData[7:0];
                end
                else begin 
                    MemArray[Address[11:2]][31:24] <= WriteData[7:0]; //Not sure
                end
                
            end
            else  if (MemOp[3:0] == 4'b1100)begin //sw
                MemArray[Address[11:2]] <= WriteData;
            end
    end
    
    always @(MemRead) begin
        if (MemRead == 1) begin
            if (MemOp[3:0] == 4'b0100) begin //lh
                if (Address[1:0] == 2'b00) begin
                    ReadData <= {{16{MemArray[Address[11:2]][15]}},{MemArray[Address[11:2]][15:0]}};                
                end
                else if (Address[1:0] == 2'b01) begin
                    ReadData <= {{16{MemArray[Address[11:2]][23]}},{MemArray[Address[11:2]][23:8]}}; 
                end                
                else if (Address[1:0] == 2'b10) begin
                    ReadData <= {{16{MemArray[Address[11:2]][31]}},{MemArray[Address[11:2]][31:16]}};                 
                end            
                else begin
                    ReadData <= {{16{MemArray[Address[11:2]][15]}},{MemArray[Address[11:2]][15:0]}}; 
                end            
            end
            else if (MemOp[3:0] == 4'b0001) begin  //lb
                if (Address[1:0] == 2'b00) begin
                    ReadData <= {{24{MemArray[Address[11:2]][7]}},{MemArray[Address[11:2]][7:0]}};                
                end
                else if (Address[1:0] == 2'b01) begin
                    ReadData <= {{24{MemArray[Address[11:2]][15]}},{MemArray[Address[11:2]][15:8]}}; 
                end                
                else if (Address[1:0] == 2'b10) begin
                    ReadData <= {{24{MemArray[Address[11:2]][23]}},{MemArray[Address[11:2]][23:16]}};                 
                end            
                else begin
                    ReadData <= {{24{MemArray[Address[11:2]][31]}},{MemArray[Address[11:2]][31:24]}}; 
                end
            end
            else if (MemOp[3:0] == 4'b0011)begin //lw
                ReadData <= MemArray[Address[11:2]];
            end
        end   
    end
endmodule
