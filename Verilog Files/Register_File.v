`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:15 03/21/2023 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File(
    input [4:0] Read_Reg1,
    input [4:0] Read_Reg2,
    input [4:0] Write_Reg_Num,
    input [31:0] reg_write_data,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2,
    input RegWrite,
    input clk,
    input reset
    );
	
    //32 32bit registers
	reg [31:0] Reg_Memory[31:0];
	integer i; 
	
	//update Read_data
	assign Read_Data1 = Reg_Memory[Read_Reg1];
	assign Read_Data2 = Reg_Memory[Read_Reg2];
	
	//write
	always @(posedge clk, negedge reset)
	begin
	if (reset == 0)
	begin
	   //$readmemh("register_mem.mem",Reg_Memory);
	   for (i = 0; i<32; i= i+1) Reg_Memory[i] = i;
	end
	if (RegWrite == 1)
		begin
			Reg_Memory[Write_Reg_Num] <= reg_write_data;
		end
	end

endmodule
