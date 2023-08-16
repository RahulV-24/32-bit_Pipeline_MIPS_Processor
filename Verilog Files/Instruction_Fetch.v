`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:00 03/21/2023 
// Design Name: 
// Module Name:    Instruction_Fetch 
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
module Instruction_Fetch(
	input clk,
    input reset,
    output [31:0] Instruction_Code,
    input [31:0] PC
    );

	
	Instruction_Memory instruction_mem(.PC(PC),.reset(reset),.Instruction_Code(Instruction_Code));
	 
//	always @(posedge clk, negedge reset)
//		begin
//			if(reset==0)
//				PCpls4 <= 0;
//			else
//			    PCpls4 <= PC;
//		end


endmodule
