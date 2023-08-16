`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:45 03/21/2023 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(
	input [5:0] opcode, //31:26 Instruction
	output reg jump, branch,
	output reg RegWrite,
	output reg MemWrite,
	output reg MemRead,
	output reg [1:0]ALU_op,
	output reg ALU_Src,
	output reg RegDst,
	output reg MemtoReg
    );

    always @(*) begin
		case(opcode)
			0: begin
				RegDst 		    <= 1;
				ALU_Src 		<= 0;
				MemtoReg		<= 0;
				RegWrite		<= 1;
				MemRead		    <= 0;
				MemWrite		<= 0;
				ALU_op			<= 2'b10;
				branch          <= 0;
				jump            <= 0; 
			end
			//load
			35: begin
				RegDst 		    <= 0;
				ALU_Src		    <= 1;
				MemtoReg		<= 1;
				RegWrite		<= 1;
				MemRead		    <= 1;
				MemWrite		<= 0;
				ALU_op			<= 2'b00;
				branch          <= 0;
				jump            <= 0;
			end
			//store
			43: begin
				RegDst 		    <= 0;
				MemtoReg		<= 0;
				RegWrite		<= 0;
				ALU_Src         <= 1;
				MemRead		    <= 0;
				MemWrite		<= 1;
				ALU_op			<= 2'b00;
				branch          <= 0;
				jump            <= 0;
			end
			
			//beq
			4: begin
				ALU_Src		    <= 0;
				RegWrite		<= 0;
				MemRead		    <= 0;
				MemWrite		<= 0;
				RegDst          <= 0;
				ALU_op			<= 2'b01;
				branch          <= 1;
				jump            <= 0;
				MemtoReg        <= 0;
			end
			
			//jump
			2: begin
				RegDst 		    <= 0;
				RegWrite		<= 0;
				MemRead		    <= 0;
				MemWrite		<= 0;
				MemtoReg        <= 0;
				RegDst          <= 0;
				ALU_Src		    <= 0;
				branch          <= 0;
				jump            <= 1;
				ALU_op			<= 2'bXX;
			end
			
			default : begin
			     RegDst 		    <= 0;
				RegWrite		<= 0;
				MemRead		    <= 0;
				MemWrite		<= 0;
				MemtoReg        <= 0;
				RegDst          <= 0;
				ALU_Src		    <= 0;
				branch          <= 0;
				jump            <= 0;
				ALU_op			<= 2'bXX;
			end
		endcase
	end

endmodule
