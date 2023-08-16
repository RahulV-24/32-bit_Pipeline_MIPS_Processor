`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:15:40 03/24/2023
// Design Name:   Top
// Module Name:   E:/ca_ass1/Comparc_assignment/Testbench_1.v
// Project Name:  Comparc_assignment
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Testbench_1;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		clk = 0; reset =1;
		#20 reset = 0;
		#20 reset = 1;
		#420 $stop; 
	end
	always begin
		#20 clk = ~clk;
	end
endmodule

