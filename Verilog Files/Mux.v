`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 06:58:54 AM
// Design Name: 
// Module Name: Mux
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


module Mux(
    input alusrc,
    input [31:0] Read_Data2, Extend, ALU_out, readdata,
    input [4:0] rd, rt, 
    input RegDst, MemtoReg,
    //output reg [4:0] Write_Reg_Num,
    output reg [31:0]/* ALU_Src2,*/ reg_write_data
    );
    
    //Write Register selection
    always @ (*) 
    begin
	//	case(RegDst)
		//	0: Write_Reg_Num <= rt;
	   //  1: Write_Reg_Num <= rd;
	//	endcase
    //ALU source for lw/sw and R type instructions
       // case (alusrc)
		//	0: ALU_Src2 <= Read_Data2 ;
	//		1: ALU_Src2 <= Extend;
	//	endcase
    end
    always@(*)
    begin
	//	case (MemtoReg)
	//		0: reg_write_data <= ALU_out;
	//		1: reg_write_data <= readdata;
//		endcase
	end
        
endmodule
