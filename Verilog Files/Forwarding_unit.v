`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2023 23:11:56
// Design Name: 
// Module Name: Forwarding_unit
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


module Forwarding_unit(

    input [4:0] EX_MEM_rd,
    input [4:0] MEM_WB_rd,
    input [4:0] ID_EX_rs,
    input [4:0] ID_EX_rt,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,

    output [1:0] forwardA,
    output [1:0] forwardB
    );
    
    reg [1:0] fdA,fdB;
    always  @(*)
    begin
       if( EX_MEM_RegWrite && (EX_MEM_rd!=0) && (EX_MEM_rd == ID_EX_rs))
            fdA = 2'd2; 
       else if( MEM_WB_RegWrite && (MEM_WB_rd!=0) && (MEM_WB_rd == ID_EX_rs))
            fdA = 2'd1;
       else 
            fdA = 2'd0;
                 
       if( EX_MEM_RegWrite && (EX_MEM_rd!=0) && (EX_MEM_rd == ID_EX_rt))
            fdB = 2'd2; 
        
       else if( MEM_WB_RegWrite && (MEM_WB_rd!=0) && (MEM_WB_rd == ID_EX_rt))
            fdB = 2'd1;
       else 
            fdB = 2'd0; 
    end
    
    assign forwardA = fdA;
    assign forwardB = fdB;
    
endmodule
