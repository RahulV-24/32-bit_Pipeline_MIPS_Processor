`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:30 03/21/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [31:0] A,
    input [31:0] B,
    input [2:0] ALU_control,
    output reg [31:0] Result,
    output reg Zero
    );
	
	always@(A or B or ALU_control)
		begin
			case(ALU_control)
				3'b000: 
					Result <= A&B;
				3'b001:
					Result <= A|B;
				3'b010:
					Result <= A+B;
				3'b110:
					Result <= A-B;
				3'b111:
					if(A<B)
						Result <= 1;
					else
						Result <= 0;
			endcase
	end
	
	always@(Result)
	begin
	if(Result==0)
				Zero <= 1;
			else
				Zero <= 0;
	end
endmodule
