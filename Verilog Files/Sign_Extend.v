`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:25 03/21/2023 
// Design Name: 
// Module Name:    Sign_Extend 
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
module Sign_Extend(
	input [15:0] Immediate,
	output [31:0] Extended
    );
    
    wire [31:0] sign_extended_imm;
	// left shift MSB bit and extend to fill 32 bits
	assign Extended = {{16{Immediate[15]}},Immediate[15:0]};
endmodule
