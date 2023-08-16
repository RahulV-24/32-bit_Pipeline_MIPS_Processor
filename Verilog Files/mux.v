`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 22:46:58
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux(
input sel,
input [31:0] inp0,
input [31:0] inp1,
output [31:0] mux_out
    );
    reg [31:0] out;
       //ALU source for lw/sw and R type instructions
       always @(*)
       begin
        case (sel)
			0: out <= inp0 ;
			1: out <= inp1;
		endcase
		end
		assign mux_out = out;
		
endmodule
