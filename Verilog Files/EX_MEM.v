`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 20:43:50
// Design Name: 
// Module Name: IF_ID MEM
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


module EX_MEM(
    input clk,
    input [31:0] ir,
    input [31:0] aluout,
    input zero,
    input [31:0] rt,
    
    input  jump, branch,
	input  RegWrite,
	input  MemWrite,
	input  MemRead,
	input  MemtoReg,
    
    output [31:0] ir_out,
    output [31:0] aluout_out,
    output zero_out,
    output [31:0] rt_out,
    
    output  jump_out, branch_out,
	output  RegWrite_out,
	output  MemWrite_out,
	output  MemRead_out,
    output  MemtoReg_out
    
    );
    
    reg [31:0] mem[2:0];
    reg mem0;
    reg control_mem [5:0];
    
    always @(*)
    begin
         mem[0] = ir;
         mem[1] = aluout;
         mem[2] = rt;
         mem0 = zero;
         
         control_mem[0] = jump;
         control_mem[1] = branch;
         control_mem[2] = RegWrite;
         control_mem[3] = MemWrite;
         control_mem[4] = MemRead;
         control_mem[5] = MemtoReg;
    end
    
    assign ir_out = mem[0];
    assign aluout_out = mem[1];
    assign rt_out = mem[2];
    assign zero_out = mem0;
    
    assign jump_out = control_mem[0];
    assign branch_out = control_mem[1];
    assign RegWrite_out = control_mem[2];
    assign MemWrite_out = control_mem[3];
    assign MemRead_out = control_mem[4];
    assign MemtoReg_out = control_mem[5];
    
        
endmodule
