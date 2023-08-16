`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 22:25:44
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input clk,
    input [31:0] ir,
    input [31:0] npc,
    input [31:0] rs,
    input [31:0] rt,
    input [31:0] s_ext,
    
    input  jump, branch,
	input  RegWrite,
	input  MemWrite,
	input  MemRead,                       //control signal input
	input  [1:0]ALU_op,
	input  ALU_Src,
	input  RegDst,
	input  MemtoReg,
	
    output [31:0] ir_out,
    output [31:0] npc_out,
    output [31:0] rs_out,
    output [31:0] rt_out,
    output [31:0] s_ext_out,
    
    output  jump_out, branch_out,
	output  RegWrite_out,
	output  MemWrite_out,
	output  MemRead_out,                    //control ssignal output
	output  [1:0]ALU_op_out,
	output  ALU_Src_out,
	output  RegDst_out,
	output  MemtoReg_out
    
    );
    
    reg [31:0] mem[4:0];
    reg control_mem [9:0];
    
    always @(*)
    begin
         mem[0] = ir;
         mem[1] = npc;
         mem[2] = rs;
         mem[3] = rt;
         mem[4] = s_ext;
         control_mem[0] = jump;
         control_mem[1] = branch;
         control_mem[2] = RegWrite;
         control_mem[3] = MemWrite;
         control_mem[4] = MemRead;
         control_mem[5] = ALU_op[1];
         control_mem[6] = ALU_op[0];
         control_mem[7] = ALU_Src;
         control_mem[8] = RegDst;
         control_mem[9] = MemtoReg;
         
    end
    
    assign ir_out = mem[0];
    assign npc_out = mem[1];
    assign rs_out = mem[2];
    assign rt_out = mem[3];
    assign s_ext_out = mem[4];
    
    assign jump_out = control_mem[0];
    assign branch_out = control_mem[1];
    assign RegWrite_out = control_mem[2];
    assign MemWrite_out = control_mem[3];
    assign MemRead_out = control_mem[4];
    assign ALU_op_out[1] = control_mem[5];
    assign ALU_op_out[0] = control_mem[6];
    assign ALU_Src_out = control_mem[7];
    assign RegDst_out = control_mem[8];
    assign MemtoReg_out = control_mem[9];
 
endmodule
