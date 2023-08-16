`timescale 1ns / 1ps

module Jump_mux(
//input [31:0] PC,
input [31:0] Extend,
input reset, 
input clk,
output reg [31:0] PC_out,
input branch, jump, zero,
input [25:0] instr26
);

wire [31:0] mux1sel, pcplus4;
reg [31:0] muxout, branch_result;
reg [31:0] Jump_addr;
wire [31:0] pc;

assign mux1sel = branch & zero;
assign pcplus4 = pc+4;
assign pc = PC_out;

always @(negedge reset)
begin
    if(reset == 0)
    begin 
        PC_out <= 0;
    end  
end
always @(*)
begin
    branch_result <= pcplus4 + (Extend<<2);
    Jump_addr <= {pcplus4[31:28], (instr26<<2)};
    
    case(mux1sel)
        0: muxout <= pcplus4;
        1: muxout <= branch_result;
    endcase   
end
always@(posedge clk)
begin
    case(jump)
        0: PC_out <= muxout;
        1: PC_out <= Jump_addr;
    endcase
end
endmodule