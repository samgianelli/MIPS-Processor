`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================


// AND  | 0000
// OR   | 0001
// ADD  | 0010
// XOR  | 0011
// NOR  | 0100
// SRA  | 0101
// SUB  | 0110
// SLT  | 0111
// SLL  | 1000
// SRL  | 1001
// MUL  | 1010
//      | 1011
// ROT  | 1100
// SEB  | 1101
// SEH  | 1110
//      | 1111

// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, HiResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer               NOTE: Did not have the 'reg' in the outline file
	output reg [31:0] HiResult;
	output reg Zero;	    // Zero=1 if ALUResult == 0     NOTE: Did not have the 'reg' in the outline file

    /* Please fill in the implementation here... */
    always @(A, B, ALUControl, ALUResult) begin
        case (ALUControl)
            
            4'b0000: begin  //AND
                ALUResult <= A & B;
            end
        
            4'b0001: begin  //OR
                ALUResult <= A | B;
            end
            
            4'b0010: begin  //ADD
                ALUResult <= A + B;
            end
            
            4'b0011: begin  //XOR
                ALUResult <= A ^ B;
            end
            
            4'b0100: begin  //NOR
                ALUResult <= ~(A | B);
            end
            
            4'b0101: begin // SRA    can use >>> to sign extend signed values
                if (B[31] == 1'b1) begin
                     ALUResult <= (32'hffffffff << ('d32-A)) | (B >> A);
                end
                else begin 
                     ALUResult <= B >> A;                
                end
            end
            
            4'b0110: begin  //SUB
                ALUResult <= A - B;
            end
            
            4'b0111: begin  //SLT
                if (A < B)
                    ALUResult <= 32'h00000001;
                else
                    ALUResult <= 32'h00000000;
            end
            
            4'b1000: begin  //SLL
                ALUResult <= B << A;
            end
            
            4'b1001: begin  //SRL
                ALUResult <= B >> A;
            end
            
            4'b1010: begin  //MUL
                {{HiResult}, {ALUResult}} <= $signed(A * B);
            end
            
            4'b1011: begin //MUL U
                {{HiResult}, {ALUResult}} <= A * B;
            end
            
            4'b1100: begin  //ROT Right
                ALUResult <= (B << ('d32-A)) | (B >> A);
            end  
            
            4'b1101: begin  // SEB
                ALUResult <= {{24{B[7]}},{B[7:0]}};
            end
            
            4'b1110: begin // SEH
                ALUResult <= {{16{B[15]}},{B[15:0]}};
            end
            
            4'b1111: begin  //AND
                ALUResult <= A & {{16{1'b0}}, {B[15:0]}};
            end
            default: begin            //REMOVE IF THIS PROVES TO BE UNNECESSARY
                ALUResult <= 32'h00000000;
            end
            
        endcase
        
        if (ALUResult == 32'h00000000)  // FIXME: Outputs a cycle after the Zero
            Zero <= 1'b1;
        else
            Zero <= 1'b0;
        
    end

endmodule

