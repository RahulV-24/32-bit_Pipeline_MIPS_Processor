`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:37 03/21/2023 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory(
	input [31:0] Address,
    input [31:0] Write_Data,
	 input MemWrite,
	 input MemRead,
	 input clk,reset,
    output reg [31:0] readdata
    );
	
	//32 locations of 32 bit memory 
	integer i;
	reg[7:0] Data[127:0];
    
    always @ (posedge clk, negedge reset)
    begin 
    if (reset == 1)
        begin
        for (i = 0; i<128; i= i+1) Data[i] <= i;
        end
    end
    always@(posedge clk)
    begin
        //write
    if(MemWrite == 1) 
    begin 
    Data[Address] <= Write_Data[7:0];
    Data[Address+1] <= Write_Data[15:8];
    Data[Address+2] <= Write_Data[23:16];
    Data[Address+3] <= Write_Data[31:24];
    end	
    end
	
	//always@(*)
	//   begin
		    //read
//			if(MemRead == 1) ReadData <= {Data[Address], Data[Address+1], Data[Address+2], Data[Address+3]};		
//		end
    reg [31:0] temp;
    
    always@(*)begin
        temp <= {Data[Address], Data[Address+1], Data[Address+2], Data[Address+3]};
        readdata <= MemRead?temp:32'hx;
    end
endmodule
