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


module MEM_WB(
    input clk,
    input [31:0] ir,
    input [31:0] aluout,
    input [31:0] readdata,
    
    input  RegWrite,
    input  MemtoReg,
    
    output [31:0] ir_out,
    output [31:0] aluout_out,
    output [31:0] readdata_out,
    
    output  RegWrite_out,
    output  MemtoReg_out
    
    );
    
    reg [31:0] mem[2:0];
    reg control_mem [1:0];
    
    always @(*)
    begin
         mem[0] = ir;
         mem[1] = aluout;
         mem[2] = readdata;
         
         control_mem[0] = RegWrite;
         control_mem[1] = MemtoReg;
         
    end
    
    assign ir_out = mem[0];
    assign aluout_out = mem[1];
    assign readdata_out = mem[2];
    
    assign RegWrite_out = control_mem[0];
    assign MemtoReg_out = control_mem[1];

      
endmodule
