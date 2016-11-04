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
       // Lab 9-13
       //InstArray[0] = 32'b00100000000100000000000000000001;
       //InstArray[1] = 32'b00100000000100010000000000000001;
       //InstArray[2] = 32'b00000010000100011000000000100100;
       //InstArray[3] = 32'b00000010000000001000000000100100;
       //InstArray[4] = 32'b00000010001100001000000000100010;
       //InstArray[5] = 32'b00000010000000001000000000100111;
       //InstArray[6] = 32'b00000010000000001000000000100111;
       //InstArray[7] = 32'b00000000000000001000000000100101;
       //InstArray[8] = 32'b00000010001000001000000000100101;
       //InstArray[9] = 32'b00000000000100001000000010000000;
       //InstArray[10] = 32'b00000010001100001000000000000100;
       //InstArray[11] = 32'b00000010000000001000000000101010;
       //InstArray[12] = 32'b00000010000100011000000000101010;
       //InstArray[13] = 32'b00000000000100011000000001000011;
       //InstArray[14] = 32'b00000000000100011000000000000111;
       //InstArray[15] = 32'b00000000000100011000000001000010;
       //InstArray[16] = 32'b00000000000100011000000011000000;
       //InstArray[17] = 32'b00000000000100001000000011000010;
       //InstArray[18] = 32'b00000010001100001000000000000100;
       //InstArray[19] = 32'b00000010001100001000000000000110;
       //InstArray[20] = 32'b00000010000100011000000000100110;
       //InstArray[21] = 32'b00000010000100011000000000100110;
       //InstArray[22] = 32'b00100000000100100000000000000100;
       //InstArray[23] = 32'b01110010000100101000000000000010;
       //InstArray[24] = 32'b00100010000100000000000000000100;
       //InstArray[25] = 32'b00110010000100000000000000000000;
       //InstArray[26] = 32'b00110110000100000000000000000001;
       //InstArray[27] = 32'b00101010000100000000000000000000;
       //InstArray[28] = 32'b00101010000100000000000000000001;
       //InstArray[29] = 32'b00111010000100000000000000000001;
       //InstArray[30] = 32'b00111010000100000000000000000001;
       //InstArray[31] = 32'b00100000000100001111111111111110;
       //InstArray[32] = 32'b00100000000100010000000000000010;
       //InstArray[33] = 32'b00000010001100001001000000101011;
       //InstArray[34] = 32'b00101110001100001111111111111110;
       //InstArray[35] = 32'b00000010001000001000000000001010;
       //InstArray[36] = 32'b00000000000100011000000000001011;
       //InstArray[37] = 32'b00000010001100101000000000100000;
       //InstArray[38] = 32'b00100000000100001111111111111110;
       //InstArray[39] = 32'b00000010001100001000100000100001;
       //InstArray[40] = 32'b00100100000100011111111111111111;
       //InstArray[41] = 32'b00100000000100100000000000100000;
       //InstArray[42] = 32'b00000010001100100000000000011000;
       //InstArray[43] = 32'b00000000000000001010000000010000;
       //InstArray[44] = 32'b00000000000000001010100000010010;
       //InstArray[45] = 32'b00000010001100100000000000011001;
       //InstArray[46] = 32'b00000000000000001010000000010000;
       //InstArray[47] = 32'b00000000000000001010100000010010;
       //InstArray[48] = 32'b01110010001100100000000000000000;
       //InstArray[49] = 32'b00000000000000001010000000010000;
       //InstArray[50] = 32'b00000000000000001010100000010010;
       //InstArray[51] = 32'b00000010010000000000000000010001;
       //InstArray[52] = 32'b00000010001000000000000000010011;
       //InstArray[53] = 32'b00000000000000001010000000010000;
       //InstArray[54] = 32'b00000000000000001010100000010010;
       //InstArray[55] = 32'b00110010001100011111111111111111;
       //InstArray[56] = 32'b01110010100100100000000000000100;
       //InstArray[57] = 32'b00000000000000001010000000010000;
       //InstArray[58] = 32'b00000000000000001010100000010010;
       //InstArray[59] = 32'b00100000000100100000000000000001;
       //InstArray[60] = 32'b00000000001100101000111111000010;
       //InstArray[61] = 32'b00100000000101000000000000011111;
       //InstArray[62] = 32'b00000010100100011000100001000110;
       //InstArray[63] = 32'b00110100000100010000111111110000;
       //InstArray[64] = 32'b01111100000100011010010000100000;
       //InstArray[65] = 32'b01111100000100011010011000100000;
       
       // Lab 14-15
       InstArray[0] = 32'h34040000;	//	main:		ori	$a0, $zero, 0
       InstArray[1] = 32'h08000004;    //            j    start
       InstArray[2] = 32'h2004000a;    //            addi    $a0, $zero, 10
       InstArray[3] = 32'h2004000a;    //            addi    $a0, $zero, 10
       InstArray[4] = 32'h8c900004;    //    start:        lw    $s0, 4($a0)
       InstArray[5] = 32'h8c900008;    //            lw    $s0, 8($a0)
       InstArray[6] = 32'hac900000;    //            sw    $s0, 0($a0)
       InstArray[7] = 32'hac90000c;    //            sw    $s0, 12($a0)
       InstArray[8] = 32'h8c910000;    //            lw    $s1, 0($a0)
       InstArray[9] = 32'h8c92000c;    //            lw    $s2, 12($a0)
       InstArray[10] = 32'h12000003;    //            beq    $s0, $zero, branch1
       InstArray[11] = 32'h02008820;    //            add    $s1, $s0, $zero
       InstArray[12] = 32'h12110001;    //            beq    $s0, $s1, branch1
       InstArray[13] = 32'h08000037;    //            j    error
       InstArray[14] = 32'h2010ffff;    //    branch1:    addi    $s0, $zero, -1
       InstArray[15] = 32'h0601fff4;    //            bgez    $s0, start
       InstArray[16] = 32'h22100001;    //            addi    $s0, $s0, 1
       InstArray[17] = 32'h06010001;    //            bgez    $s0, branch2
       InstArray[18] = 32'h08000037;    //            j    error
       InstArray[19] = 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
       InstArray[20] = 32'h1E000005;    //            bgtz    $s0, branch3
       InstArray[21] = 32'h20100001;    //            addi    $s0, $zero, 1
       InstArray[22] = 32'h20100001;    //            addi    $s0, $zero, 1
       InstArray[23] = 32'h20100001;    //            addi    $s0, $zero, 1
       InstArray[24] = 32'h1E000001;    //            bgtz    $s0, branch3
       InstArray[25] = 32'h08000037;    //            j    error
       InstArray[26] = 32'h06000003;    //    branch3:    bltz    $s0, branch4
       InstArray[27] = 32'h2010ffff;    //            addi    $s0, $zero, -1
       InstArray[28] = 32'h06000001;    //            bltz    $s0, branch4
       InstArray[29] = 32'h08000037;    //            j    error
       InstArray[30] = 32'h2011ffff;    //    branch4:    addi    $s1, $zero, -1
       InstArray[31] = 32'h16110002;    //            bne    $s0, $s1, branch5
       InstArray[32] = 32'h16000001;    //            bne    $s0, $zero, branch5
       InstArray[33] = 32'h08000037;    //            j    error
       InstArray[34] = 32'h20100080;    //    branch5:    addi    $s0, $zero, 128
       InstArray[35] = 32'ha0900000;    //            sb    $s0, 0($a0)
       InstArray[36] = 32'h80900000;    //            lb    $s0, 0($a0)
       InstArray[37] = 32'h1a000001;    //            blez    $s0, branch6
       InstArray[38] = 32'h08000037;    //            j    error
       InstArray[39] = 32'h2010ffff;    //    branch6:    addi    $s0, $zero, -1
       InstArray[40] = 32'ha4900000;    //            sh    $s0, 0($a0)
       InstArray[41] = 32'h20100000;    //            addi    $s0, $zero, 0
       InstArray[42] = 32'h84900000;    //            lh    $s0, 0($a0)
       InstArray[43] = 32'h1a000001;    //            blez    $s0, branch7
       InstArray[44] = 32'h08000037;    //            j    error
       InstArray[45] = 32'h2010ffff;    //    branch7:    addi    $s0, $zero, -1
       InstArray[46] = 32'h3c100001;    //            lui    $s0, 1
       InstArray[47] = 32'h06010001;    //            bgez    $s0, branch8
       InstArray[48] = 32'h08000037;    //            j    error
       InstArray[49] = 32'h08000033;    //    branch8:    j    jump1
       InstArray[50] = 32'h2210fffe;    //            addi    $s0, $s0, -2
       InstArray[51] = 32'h0c000035;    //    jump1:        jal    jal1
       InstArray[52] = 32'h08000004;    //            j    start
       InstArray[53] = 32'h03e00008;    //    jal1:        jr    $ra
       InstArray[54] = 32'h08000037;    //            j    error
       InstArray[55] = 32'h00000008;    //    error:        jr    $zero
       InstArray[56] = 32'h3402000a;    //            ori    $v0, $zero, 10
       InstArray[57] = 32'h00000000;    //            nop
    end 
    
    /* Please fill in the implementation here */
    always @(Address) begin
    //temp <= Address >> 2;
    Instruction <= InstArray[Address >> 2];
    //Instruction <= Address;
    end
    

endmodule