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


module IF_ID(
    input clk,
    input [31:0] ir,
    input [31:0] npc,
    output [31:0] ir_out,
    output [31:0] npc_out
    );
    
    reg [31:0] mem[1:0];
    
    always @(*)
    begin
         mem[1] = ir;
         mem[0] = npc;
    end
    
    assign ir_out = mem[1];
    assign npc_out = mem[0];
    
        
endmodule
