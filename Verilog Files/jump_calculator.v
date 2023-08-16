`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2023 11:32:02 AM
// Design Name: 
// Module Name: jump_calculator
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


module jump_calculator(
    input [25:0] instr26,
    input [3:0] pcplus4,
    output [31:0] Jump_addr
    );
    
    wire [27:0] temp;
    assign temp = instr26<<2;
    assign Jump_Addr = {pcplus4, temp};
    
endmodule
