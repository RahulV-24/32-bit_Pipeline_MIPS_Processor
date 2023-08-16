`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2023 01:35:25
// Design Name: 
// Module Name: mux3
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


module mux3(
input [1:0] sel,
input [31:0] inp0,
input [31:0] inp1,
input [31:0] inp2,
output [31:0] mux_out
    );
    reg [31:0] out;
       //ALU source for lw/sw and R type instructions
       always @(*)
       begin
        case (sel)
			2'd0: out = inp0 ;
			2'd1: out = inp1;
			2'd2: out = inp2;
			//default: out = inp0;
		endcase
		end
		assign mux_out = out;
		
endmodule
