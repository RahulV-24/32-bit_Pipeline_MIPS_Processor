`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:24 03/21/2023 
// Design Name: 
// Module Name:    Instruction_Memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Instruction_Memory(
	 input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code
    );

    //36 locations of 32 bit memory, byte adressable
	reg [7:0] Mem[51:0];
	 
	 assign Instruction_Code = {Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3]};
	 
	 always @(reset)
	 begin
		if(reset==1)
			begin
                $readmemh("instruction_memory.mem",Mem);
			end
		end	
endmodule
