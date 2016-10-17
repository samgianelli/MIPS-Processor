`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    /* Fill in the implementation here ... */ 

    always @(inA, inB, sel) begin
        case(sel)
            1'b0: out = inA;
            1'b1: out = inB;
        endcase
    end
    
endmodule
