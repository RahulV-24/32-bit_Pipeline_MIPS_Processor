`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:03 03/21/2023 
// Design Name: 
// Module Name:    ALU_Control 
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
module ALU_Control(
	 input [5:0] funct,
    input [1:0] ALU_op,
    output reg [2:0] ALU_control
    );
	 
	 always@(ALU_op, funct)
	 begin
	   case(ALU_op)
	       2'b00: ALU_control <= 3'b010; //add for lw, sw 
	       2'b01: ALU_control <= 3'b110; //sub for branch
	   endcase
	   case(funct)
	       6'b100000: ALU_control <= 3'b010; //add
	       6'b100010: ALU_control <= 3'b110; //sub
	       6'b100100: ALU_control <= 3'b000; //and
	       6'b100101: ALU_control <= 3'b001; //or
	       6'b101010: ALU_control <= 3'b111; //slt
	   endcase    
	 end
endmodule
