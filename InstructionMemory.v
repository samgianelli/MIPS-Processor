`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    reg [31:0] InstArray [127:0];
    reg [31:0] temp;
    
    integer i;
    
    initial begin
       for (i='h00000000; i<='d127; i = i+'d1) begin
          InstArray[i] = 32'h00000000;
       end
       /*InstArray[ 0 ] <= 32'b00000000000000000100000000100000; //add $t0 ,$0, $0
       InstArray[ 1 ] <= 32'b00000000000000000100000000100000; //add $t0 ,$0, $0
       InstArray[ 2 ] <= 32'b00000000000000000100100000100000; //add $t1 ,$0, $0
       InstArray[ 3 ] <= 32'b00000000000000000101000000100000; //add $t2 ,$0, $0
       InstArray[ 4 ] <= 32'b00000001001000000100000000100000; //add $t0, $t1, $0
       InstArray[ 5 ] <= 32'b00000000000000000101000000100000; //add $t2 ,$0, $0*/
       
       // TestCases
       
       InstArray[0] = 32'b00110100000001000000000000000000;	//	main:		ori	$a0, $zero, 0
       InstArray[1] = 32'b00001000000000000000000000000100;    //            j    start
       InstArray[2] = 32'b00100000000001000000000000001010;    //            addi    $a0, $zero, 10
       InstArray[3] = 32'b00100000000001000000000000001010;    //            addi    $a0, $zero, 10
       InstArray[4] = 32'b10001100100100000000000000000100;    //    start:        lw    $s0, 4($a0)
       InstArray[5] = 32'b10001100100100000000000000001000;    //            lw    $s0, 8($a0)
       InstArray[6] = 32'b10101100100100000000000000000000;    //            sw    $s0, 0($a0)
       InstArray[7] = 32'b10101100100100000000000000001100;    //            sw    $s0, 12($a0)
       InstArray[8] = 32'b10001100100100010000000000000000;    //            lw    $s1, 0($a0)
       InstArray[9] = 32'b10001100100100100000000000001100;    //            lw    $s2, 12($a0)
       InstArray[10] = 32'b00010010000000000000000000000011;    //            beq    $s0, $zero, branch1
       InstArray[11] = 32'b00000010000000001000100000100000;    //            add    $s1, $s0, $zero
       InstArray[12] = 32'b00010010000100010000000000000001;    //            beq    $s0, $s1, branch1
       InstArray[13] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[14] = 32'b00000110000000010000000000000000;    //    branch1:    bgez    $s0, branch1
       InstArray[15] = 32'b00000110000000010000000000000000;    //            bgez    $s0, branch1
       InstArray[16] = 32'b00000110000000011111111111111111;    //            bgez    $s0, branch1
       InstArray[17] = 32'b00000110000000011111111111111110;    //            bgez    $s0, branch1
       InstArray[18] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[19] = 32'b00100000000100001111111111111111;    //    branch2:    addi    $s0, $zero, -1
       InstArray[20] = 32'b00011110000000000000000000000011;    //            bgtz    $s0, branch3
       InstArray[21] = 32'b00100000000100000000000000000001;    //            addi    $s0, $zero, 1
       InstArray[22] = 32'b00011110000000000000000000000001;    //            bgtz    $s0, branch3
       InstArray[23] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[24] = 32'b00000110000000000000000000000011;    //    branch3:    bltz    $s0, branch4
       InstArray[25] = 32'b00100000000100001111111111111111;    //            addi    $s0, $zero, -1
       InstArray[26] = 32'b00000110000000000000000000000001;    //            bltz    $s0, branch4
       InstArray[27] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[28] = 32'b00100000000100011111111111111111;    //    branch4:    addi    $s1, $zero, -1
       InstArray[29] = 32'b00010110000100010000000000000010;    //            bne    $s0, $s1, branch5
       InstArray[30] = 32'b00010110000000000000000000000001;    //            bne    $s0, $zero, branch5
       InstArray[31] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[32] = 32'b00100000000100000000000010000000;    //    branch5:    addi    $s0, $zero, 128
       InstArray[33] = 32'b10100000100100000000000000000000;    //            sb    $s0, 0($a0)
       InstArray[34] = 32'b10000000100100000000000000000000;    //            lb    $s0, 0($a0)
       InstArray[35] = 32'b00011010000000000000000000000001;    //            blez    $s0, branch6
       InstArray[36] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[37] = 32'b00100000000100001111111111111111;    //    branch6:    addi    $s0, $zero, -1
       InstArray[38] = 32'b10100100100100000000000000000000;    //            sh    $s0, 0($a0)
       InstArray[39] = 32'b00100000000100000000000000000000;    //            addi    $s0, $zero, 0
       InstArray[40] = 32'b10000100100100000000000000000000;    //            lh    $s0, 0($a0)
       InstArray[41] = 32'b00011010000000000000000000000001;    //            blez    $s0, branch7
       InstArray[42] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[43] = 32'b00100000000100001111111111111111;    //    branch7:    addi    $s0, $zero, -1
       InstArray[44] = 32'b00111100000100000000000000000001;    //            lui    $s0, 1
       InstArray[45] = 32'b00000110000000010000000000000001;    //            bgez    $s0, branch8
       InstArray[46] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[47] = 32'b00001000000000000000000000110001;    //    branch8:    j    jump1
       InstArray[48] = 32'b00100010000100001111111111111110;    //            addi    $s0, $s0, -2
       InstArray[49] = 32'b00001100000000000000000000110011;    //    jump1:        jal    jal1
       InstArray[50] = 32'b00001000000000000000000000000100;    //            j    start
       InstArray[51] = 32'b00000011111000000000000000001000;    //    jal1:        jr    $ra
       InstArray[52] = 32'b00001000000000000000000000110101;    //            j    error
       InstArray[53] = 32'b00000000000000000000000000001000;    //    error:        jr    $zero
       InstArray[54] = 32'b00110100000000100000000000001010;    //            ori    $v0, $zero, 10
       InstArray[55] = 32'b00000000000000000000000000000000;    //            nop

    end 
    
    /* Please fill in the implementation here */
    always @(Address) begin
    //temp <= Address >> 2;
    Instruction <= InstArray[Address >> 2];
    //Instruction <= Address;
    end
    

endmodule
