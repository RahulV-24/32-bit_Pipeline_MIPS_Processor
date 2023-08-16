`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 12:01:50 AM
// Design Name: 
// Module Name: Top
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
module Top(
    input clk,
    input reset
);

wire [31:0] Instruction_Code, Result;
wire RegDst, RegWrite, MemtoReg, MemRead, MemWrite, branch, jump;
wire [1:0] ALU_op;
wire [31:0] ReadData1, ReadData2;
wire [4:0] Write_Reg_Num;
wire alusrc; 
wire [31:0] readdata, reg_write_data;
wire [31:0] ALU_src_1,ALU_src_2;
wire zero;
wire [31:0] Extend;
wire [2:0] ALUcontrol;
wire [31:0] PC;

wire WB_RegWrite;
wire [1:0] ForwardA,ForwardB;


////////////////////////////////////// IF START //////////////////////////////////////	

//Instruction Fetch
Instruction_Fetch ifet(
		.clk(clk),
		.reset(reset),
        .Instruction_Code(Instruction_Code),
        .PC(PC)
	);

	Jump_mux jumper(
	    .instr26(Instruction_Code[25:0]),
        .Extend(Extend),
        .PC_out(PC),
        .branch(branch),
        .jump(jump),
        .zero(zero),
        .clk(clk),
        .reset(reset)
	);
	
////////////////////////////////////// IF END //////////////////////////////////////
	 
wire [31:0] ID_PC;
wire [31:0] ID_Instruction_Code;

IF_ID  if_id(
        .clk(clk),                                       // IF/ID pipeline Register
        .ir(Instruction_Code),
        .npc(PC),
        .ir_out(ID_Instruction_Code),
        .npc_out(ID_PC)
   );
 
////////////////////////////////////// ID START //////////////////////////////////////	
	
//Register File
	Register_File regf(
		.clk(clk),
		.reset(reset),
		.Read_Reg1(ID_Instruction_Code[25:21]), 
		.Read_Reg2(ID_Instruction_Code[20:16]),
		.RegWrite(WB_RegWrite),
		.Write_Reg_Num(Write_Reg_Num),	
		.reg_write_data(reg_write_data),
		.Read_Data1(ReadData1),
		.Read_Data2(ReadData2)	
	);	
	
//SignExtend
	Sign_Extend signex(
		.Immediate(ID_Instruction_Code[15:0]),
		.Extended(Extend)
	);
	
//Control_Unit
	 Control_Unit mctrl(
		.opcode(ID_Instruction_Code[31:26]),
		.RegDst(RegDst),
		.RegWrite(RegWrite),
		.ALU_Src(alusrc),
		.MemtoReg(MemtoReg),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.ALU_op(ALU_op),
		.branch(branch),
		.jump(jump)	
	);
	
////////////////////////////////////// ID END //////////////////////////////////////	

//  ID/EX pipeline register 
wire [31:0] EX_PC;
wire [31:0] EX_Instruction_Code;
wire [31:0] EX_ReadData1;
wire [31:0] EX_ReadData2;
wire [31:0] EX_s_ext;

    wire EX_jump;
    wire EX_branch;
	wire EX_RegWrite;
	wire EX_MemWrite;
	wire EX_MemRead;
	wire [1:0] EX_ALU_op;
	wire EX_alusrc;
	wire EX_RegDst;
	wire EX_MemtoReg;
	
ID_EX  id_ex(
        .clk(clk),                                      // ID/EX pipeline Register
        .ir(ID_Instruction_Code),
        .npc(PC),
        .rs(ReadData1),
        .rt(ReadData2),
        .s_ext(Extend),
        
       .jump(jump),
       .branch(branch),
	   .RegWrite(RegWrite),
	   .MemWrite(MemWrite),
	   .MemRead(MemRead),                       //control signal input
	   .ALU_op(ALU_op),
	   .ALU_Src(alusrc),
	   .RegDst(RegDst),
	   .MemtoReg(MemtoReg),
        
        .ir_out(EX_Instruction_Code),
        .npc_out(EX_PC),
        .rs_out(EX_ReadData1),
        .rt_out(EX_ReadData2),
        .s_ext_out(EX_s_ext),
        
        .jump_out(EX_jump),
       .branch_out(EX_branch),
	   .RegWrite_out(EX_RegWrite),
	   .MemWrite_out(EX_MemWrite),
	   .MemRead_out(EX_MemRead),                       //control signal input
	   .ALU_op_out(EX_ALU_op),
	   .ALU_Src_out(EX_alusrc),
	   .RegDst_out(EX_RegDst),
	   .MemtoReg_out(EX_MemtoReg)
   );

////////////////////////////////////// EX START ////////////////////////////////////// 
wire [31:0] branch_add;

	mux branch_address(
	     .sel(EX_alusrc),
	     .inp0(EX_ReadData2),
	     .inp1(EX_s_ext),
	     .mux_out(branch_add)
	);
// mux for alu source 1	
	mux3 alusrc_mux2(
	     .sel(ForwardA),
	     .inp0(EX_ReadData1),
	     .inp1(reg_write_data),
	     .inp2(MEM_Result),
	     .mux_out(ALU_src_1)
	);

// mux for alu source 2		
	mux3 alusrc_mux(
	     .sel(ForwardB),
	     .inp0(branch_add),
	     .inp1(reg_write_data),
	     .inp2(MEM_Result),
	     .mux_out(ALU_src_2)
	);
	
//ALU
	ALU alu(
		.A(ALU_src_1),
		.B(ALU_src_2),
		.ALU_control(ALUcontrol),
		.Result(Result),
		.Zero(zero)
	);
	
// mux for destination register		
	mux destreg_mux(
	     .sel(EX_RegDst),
	     .inp0(EX_Instruction_Code[20:16]),
	     .inp1(EX_Instruction_Code[15:11]),
	     .mux_out(Write_Reg_Num)
	);


//ALUControl
	ALU_Control aluctrl(
		.ALU_op(EX_ALU_op),
		.funct(EX_Instruction_Code[5:0]),
		.ALU_control(ALUcontrol)
	);

//Forwarding unit
        Forwarding_unit fwd(
    .EX_MEM_rd(MEM_Instruction_Code[15:11]),
    .MEM_WB_rd(MEM_Instruction_Code[15:11]),
    .ID_EX_rs(EX_Instruction_Code[25:21]),
    .ID_EX_rt(EX_Instruction_Code[20:16]),
    .EX_MEM_RegWrite(EX_RegWrite),
    .MEM_WB_RegWrite(MEM_RegWrite),

    .forwardA(ForwardA),
    .forwardB(ForwardB)		
    );	
    
////////////////////////////////////// EX END //////////////////////////////////////
	 
wire [31:0] MEM_Result;
wire [31:0] MEM_Instruction_Code;
wire MEM_zero;
wire [31:0] MEM_rt;

    wire MEM_jump;
    wire MEM_branch;
	wire MEM_RegWrite;
	wire MEM_MemWrite;
	wire MEM_MemRead;
	wire MEM_MemtoReg;

EX_MEM  ex_mem(
        .clk(clk),                                       // EX/MEM pipeline Register
        .ir(Instruction_Code),
        .aluout(Result),
        .zero(zero),
        .rt(EX_ReadData2),
        
       .jump(EX_jump),
       .branch(EX_branch),
	   .RegWrite(EX_RegWrite),
	   .MemWrite(EX_MemWrite),
	   .MemRead(EX_MemRead),
	   .MemtoReg(EX_MemtoReg),
        
        .ir_out(MEM_Instruction_Code),
        .aluout_out(MEM_Result),
        .zero_out(MEM_zero),
        .rt_out(MEM_rt),
        
        .jump_out(MEM_jump),
       .branch_out(MEM_branch),
	   .RegWrite_out(MEM_RegWrite),
	   .MemWrite_out(MEM_MemWrite),
	   .MemRead_out(MEM_MemRead),
	   .MemtoReg_out(MEM_MemtoReg)
   );
 
////////////////////////////////////// MEM START //////////////////////////////////////
	
//DataMemory
Data_Memory  dm(		
		.clk(clk),
		.reset(reset),
		.Address(MEM_Result),
		.MemWrite(MEM_MemWrite),
		.MemRead(MEM_MemRead),
		.Write_Data(MEM_rt),
		.readdata(readdata)
	);

////////////////////////////////////// MEM END //////////////////////////////////////
	 
wire [31:0] WB_Result;
wire [31:0] WB_Instruction_Code;
wire [31:0] WB_readdata;

wire WB_MemtoReg;

MEM_WB  mem_wb(
        .clk(clk),                                       // MEM/WB pipeline Register
        .ir(Instruction_Code),
        .aluout(Result),
        .readdata(readdata),
        
        .RegWrite(MEM_RegWrite),
        .MemtoReg(MEM_MemtoReg),
        
        .ir_out(WB_Instruction_Code),
        .aluout_out(WB_Result),
        .readdata_out(WB_readdata),
        
        .RegWrite_out(WB_RegWrite),
         .MemtoReg_out(WB_MemtoReg)
   );
 
////////////////////////////////////// WB START //////////////////////////////////////

// mux for mem to reg		
	mux memtoreg_mux(
	     .sel(WB_MemtoReg),
	     .inp0(WB_readdata),
	     .inp1(WB_Result),
	     .mux_out(reg_write_data)
	);




	
endmodule