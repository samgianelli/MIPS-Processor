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
       
       InstArray[0] = 32'b00100000000100000000000000000001;	//	main:	addi	$s0, $zero, 1
       InstArray[1] = 32'b00100000000100010000000000000001;    //        addi    $s1, $zero, 1
       InstArray[2] = 32'b00000010000100011000000000100100;    //        and    $s0, $s0, $s1
       InstArray[3] = 32'b00000010000000001000000000100100;    //        and    $s0, $s0, $zero
       InstArray[4] = 32'b00000010001100001000000000100010;    //        sub    $s0, $s1, $s0
       InstArray[5] = 32'b00000010000000001000000000100111;    //        nor    $s0, $s0, $zero
       InstArray[6] = 32'b00000010000000001000000000100111;    //        nor    $s0, $s0, $zero
       InstArray[7] = 32'b00000000000000001000000000100101;    //        or    $s0, $zero, $zero
       InstArray[8] = 32'b00000010001000001000000000100101;    //        or    $s0, $s1, $zero
       InstArray[9] = 32'b00000000000100001000000010000000;    //        sll    $s0, $s0, 2
       InstArray[10] = 32'b00000010001100001000000000000100;    //        sllv    $s0, $s0, $s1
       InstArray[11] = 32'b00000010000000001000000000101010;    //        slt    $s0, $s0, $zero
       InstArray[12] = 32'b00000010000100011000000000101010;    //        slt    $s0, $s0, $s1
       InstArray[13] = 32'b00000000000100011000000001000011;    //        sra    $s0, $s1, 1
       InstArray[14] = 32'b00000000000100011000000000000111;    //        srav    $s0, $s1, $zero
       InstArray[15] = 32'b00000000000100011000000001000010;    //        srl    $s0, $s1, 1
       InstArray[16] = 32'b00000000000100011000000011000000;    //        sll    $s0, $s1, 3
       InstArray[17] = 32'b00000000000100001000000011000010;    //        srl    $s0, $s0, 3
       InstArray[18] = 32'b00000010001100001000000000000100;    //        sllv    $s0, $s0, $s1
       InstArray[19] = 32'b00000010001100001000000000000110;    //        srlv    $s0, $s0, $s1
       InstArray[20] = 32'b00000010000100011000000000100110;    //        xor    $s0, $s0, $s1
       InstArray[21] = 32'b00000010000100011000000000100110;    //        xor    $s0, $s0, $s1
       InstArray[22] = 32'b00100000000100100000000000000100;    //        addi    $s2, $zero, 4
       InstArray[23] = 32'b01110010000100101000000000000010;    //        mul    $s0, $s0, $s2
       InstArray[24] = 32'b00100010000100000000000000000100;    //        addi    $s0, $s0, 4
       InstArray[25] = 32'b00110010000100000000000000000000;    //        andi    $s0, $s0, 0
       InstArray[26] = 32'b00110110000100000000000000000001;    //        ori    $s0, $s0, 1
       InstArray[27] = 32'b00101010000100000000000000000000;    //        slti    $s0, $s0, 0
       InstArray[28] = 32'b00101010000100000000000000000001;    //        slti    $s0, $s0, 1
       InstArray[29] = 32'b00111010000100000000000000000001;    //        xori    $s0, $s0, 1
       InstArray[30] = 32'b00111010000100000000000000000001;    //        xori    $s0, $s0, 1
       InstArray[31] = 32'b00100000000100001111111111111110;    //        addi    $s0, $zero, -2
       InstArray[32] = 32'b00100000000100010000000000000010;    //        addi    $s1, $zero, 2
       InstArray[33] = 32'b00000010001100001001000000101011;    //        sltu    $s2, $s1, $s0
       InstArray[34] = 32'b00101110001100001111111111111110;    //        sltiu    $s0, $s1, -2
       InstArray[35] = 32'b00000010001000001000000000001010;    //        movz    $s0, $s1, $zero
       InstArray[36] = 32'b00000000000100011000000000001011;    //        movn    $s0, $zero, $s1
       InstArray[37] = 32'b00000010001100101000000000100000;    //        add    $s0, $s1, $s2
       InstArray[38] = 32'b00100000000100001111111111111110;    //        addi    $s0, $zero, -2
       InstArray[39] = 32'b00000010001100001000100000100001;    //        addu    $s1, $s1, $s0
       InstArray[40] = 32'b00100100000100011111111111111111;    //        addiu    $s1, $zero, -1
       InstArray[41] = 32'b00100000000100100000000000100000;    //        addi    $s2, $zero, 32
       InstArray[42] = 32'b00000010001100100000000000011000;    //        mult    $s1, $s2
       InstArray[43] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
       InstArray[44] = 32'b00000000000000001010100000010010;    //        mflo    $s5
       InstArray[45] = 32'b00000010001100100000000000011001;    //        multu    $s1, $s2
       InstArray[46] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
       InstArray[47] = 32'b00000000000000001010100000010010;    //        mflo    $s5
       InstArray[48] = 32'b01110010001100100000000000000000;    //        madd    $s1, $s2
       InstArray[49] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
       InstArray[50] = 32'b00000000000000001010100000010010;    //        mflo    $s5
       InstArray[51] = 32'b00000010010000000000000000010001;    //        mthi    $s2
       InstArray[52] = 32'b00000010001000000000000000010011;    //        mtlo    $s1
       InstArray[53] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
       InstArray[54] = 32'b00000000000000001010100000010010;    //        mflo    $s5
       InstArray[55] = 32'b00110010001100011111111111111111;    //        andi    $s1, , $s1, 65535
       InstArray[56] = 32'b01110010100100100000000000000100;    //        msub    $s4, , $s2
       InstArray[57] = 32'b00000000000000001010000000010000;    //        mfhi    $s4
       InstArray[58] = 32'b00000000000000001010100000010010;    //        mflo    $s5
       InstArray[59] = 32'b00100000000100100000000000000001;    //        addi    $s2, $zero, 1
       InstArray[60] = 32'b00000000001100101000111111000010;    //        rotr    $s1, $s2, 31
       InstArray[61] = 32'b00100000000101000000000000011111;    //        addi    $s4, $zero, 31
       InstArray[62] = 32'b00000010100100011000100001000110;    //        rotrv    $s1, $s1, $s4
       //InstArray[63] = 32'b00000000000000000000000000000000;    //        nop
       InstArray[63] = 32'b00110100000100010000111111110000;
       InstArray[64] = 32'b01111100000100011010010000100000;    //        seb    $s4, $s1
       InstArray[65] = 32'b01111100000100011010011000100000;    //        seh    $s4, , $s1
    end 
    
    /* Please fill in the implementation here */
    always @(Address) begin
    //temp <= Address >> 2;
    Instruction <= InstArray[Address >> 2];
    //Instruction <= Address;
    end
    

endmodule
