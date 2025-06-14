`timescale 1ns/10ps
module cpu(clk, reset);
	input logic clk, reset;
	logic Reg2Loc, Uncondbranch, Branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, link, BReg;
	logic zero, negative, overflow, carry_out, branch0;
	logic [31:0] immIn;
	logic [63:0] DataOut, address_ID, result, read_data, WriteData, PCLink, address, ReadData2, addfour, ReadData1, B, immInExtd, PCin, PCout, brAddr64, branching, mux1out, BRegAddr, cbzAddr,
				address_IF, result_WB, PCLink_IF, PCLink_ID, PCLink_EX, PCLink_MEM, PCLink_WB, immInExtd_ID, read_data_MEM, ReadData1_ID, result_EX, result_MEM, B_EX, ReadData2_ID, inB, A, forwardA_EX, forwardA_MEM, forwardB_EX, forwardB_MEM, DataOut_WB,
				Fwd_MEM, Fwd_WB, inB_EX;
	logic [2:0] ALUOp, ALUOp_ID;
	logic [1:0] forwardA, forwardB, BRegFwd, CBZFwd;
	logic [31:0] instruction, instruction_IF, instruction_ID;
	logic [4:0] WriteRegister, ReadRegister1, ReadRegister2, RegRd_ID, RegRd_EX, RegRn_ID, RegRn_EX, RegRn_MEM, RegRm_ID, RegRm_EX, RegRm_MEM, RegRd_MEM, RegRd_WB;
	logic lt, le, gt, ge, ne, eq, le_next, gt_next, ge_next, ne_next, eq_next, lt_next, BrFlag, flagout, BrTaken, CBZFlag, setFlag, cbz, RegWrite_EX, RegWrite_ID, RegWrite_MEM, RegWrite_WB, forwardFlags, bcondflags;
	
	//---------------------------------------------------------------------IF Stage-------------------------------------------------------------------------------
	programCounter PC(.clk, .in(PCin), .out(PCout), .reset);

	assign PCLink = addfour;

	chip64 adder(.inA(PCout), .inB(64'd4), .out(addfour), .cntrl(3'b010));

	//Select between output from previous mux (PC+4 or branching) and BReg.
	//Select signal is BReg, directly from control unit.

	instructmem instructions(.address, .instruction, .clk);

	assign address = PCout;

	D_FF64bit addresses(.clk, .reset, .d(address), .q(address_IF));
	D_FF32bit instructions1(.clk, .reset, .d(instruction), .q(instruction_IF));
	D_FF64bit pclinks(.clk, .reset, .d(PCLink), .q(PCLink_IF));

	//---------------------------------------------------------------------ID Stage-------------------------------------------------------------------------------
	control ctrl(.instruction(instruction_IF), .Reg2Loc, .Uncondbranch, .Branch, .MemtoReg, .ALUOp, .MemRead, .MemWrite, .ALUSrc, .RegWrite, .immIn, .link, .BReg, .branch0, .setFlag);

	//Regfile I/0
	mux2_15bit regMux(.out(ReadRegister2), .i0(instruction_IF[20:16]), .i1(instruction_IF[4:0]), .sel(Reg2Loc));
	regfile register(.ReadRegister1(instruction_IF[9:5]), .ReadRegister2, .WriteRegister, .WriteData, .ReadData1, .ReadData2, .RegWrite(RegWrite_MEM), .clk);
	assign immInExtd = {{32{immIn[31]}}, immIn};
	//Regfile I/0

	//Branch logic
	and #50 a0(BrFlag, Branch, bcondflags);
	and #50 a1(CBZFlag, branch0, cbzflag);
	or # 50 o2(BrTaken, BrFlag, Uncondbranch, CBZFlag);

	assign cbzflag = ~(|cbzAddr);
									//Result_WB not created yet. Make Registers for WBEnd
	//PCLink forwarding logic
	mux4_164bit forwardBReg (.sel(BRegFwd), .i({result_MEM, result, result_EX, ReadData2}), .out(BRegAddr));
	mux4_164bit cbzFwd (.sel(CBZFwd), .i({result_MEM, result, result_EX, ReadData2}), .out(cbzAddr));
	assign brAddr64 = {{30{immIn[25]}}, immIn, 2'b0};
	chip64 adder1(.inA(address_IF), .inB(brAddr64), .out(branching), .cntrl(3'b010));
	mux2_164bit sel1(.out(mux1out), .i0(branching), .i1(BRegAddr), .sel(BReg));
	mux2_164bit sel2(.out(PCin), .i0(addfour), .i1(mux1out), .sel(BrTaken));

	mux16_1 flagMux(.sel(instruction_IF[3:0]), .i({2'd0, le_next, gt_next, lt_next, ge_next, 8'd0, ne_next, eq_next}), .out(flagout));
	mux16_1 flagMux1(.sel(instruction_IF[3:0]), .i({2'd0, le, gt, lt, ge, 8'd0, ne, eq}), .out(forwardFlags));
	mux2_1 branchForwarded(.i0(flagout), .i1(forwardFlags), .out(bcondflags), .sel(flagForward)); //takes care of B.cond with no delay.
	//Branch logic
	
	//ID/EX Signals
	cntrlReg #(.W(9)) exSig(.clk, .reset, .in({Uncondbranch, Branch, branch0, BReg, setFlag, ALUSrc, ALUOp}), .out({Uncondbranch_ID, Branch_ID, branch0_ID, BReg_ID, SetFlag_ID, ALUSrc_ID, ALUOp_ID}));
	cntrlReg #(.W(2)) memSig(.clk, .reset, .in({MemRead, MemWrite}), .out({MemRead_ID, MemWrite_ID}));
	cntrlReg #(.W(3)) wbSig (.clk, .reset, .in({MemtoReg, RegWrite, link}), .out({MemtoReg_ID, RegWrite_ID, link_ID}));
	D_FF64bit r0 (.clk, .reset, .d(ReadData1), .q(ReadData1_ID));
	D_FF32bit r1 (.clk, .reset, .d(instruction_IF), .q(instruction_ID));
	D_FF64bit r2 (.clk, .reset, .d(ReadData2), .q(ReadData2_ID));
	D_FF64bit r3(.clk, .reset, .d(immInExtd), .q(immInExtd_ID));
	D_FF64bit pclinks1(.clk, .reset, .d(PCLink_IF), .q(PCLink_ID));
	D_FF5bit r4(.clk, .reset, .d(ReadRegister2), .q(RegRm_ID));
	D_FF5bit r5(.clk, .reset, .d(instruction_IF[9:5]), .q(RegRn_ID));
	D_FF5bit r6(.clk, .reset, .d(instruction_IF[4:0]), .q(RegRd_ID));

	//---------------------------------------------------------------------EX Stage-------------------------------------------------------------------------------
	
	//assigning BCond logic based on flags
	assign eq = zero;
	not #50 n0(ne, zero);
	assign lt = negative;
	not # 50 n1(gt, le);
	or #50 o0(ge, gt, eq);
	or #50 o1(le, lt, eq);
	
	D_FFEn eqReg(.clk, .reset, .q(eq_next), .d(eq), .enable(SetFlag_ID));
	D_FFEn geReg(.clk, .reset, .q(ge_next), .d(ge), .enable(SetFlag_ID));
	D_FFEn gtReg(.clk, .reset, .q(gt_next), .d(gt), .enable(SetFlag_ID));
	D_FFEn leReg(.clk, .reset, .q(le_next), .d(le), .enable(SetFlag_ID));
	D_FFEn ltReg(.clk, .reset, .q(lt_next), .d(lt), .enable(SetFlag_ID));
	D_FFEn neReg(.clk, .reset, .q(ne_next), .d(ne), .enable(SetFlag_ID));

	//BL X30 forwarding
	mux2_164bit blinker0(.sel(BLFwd), .i0(DataOut), .i1(PCLink_MEM), .out(Fwd_MEM));
	mux2_164bit blinker1(.sel(BLFwd), .i0(DataOut_WB), .i1(PCLink_WB), .out(Fwd_WB));
	
	//MemtoReg select logic, selecting between ALUResult and Memory data to be written to register.

	mux4_164bit forwardBMux(.out(inB), .i({Fwd_WB, result_EX, Fwd_MEM, ReadData2_ID}), .sel(forwardB));
	mux4_164bit forwardAMux(.out(A), .i({Fwd_WB, result_EX, Fwd_MEM, ReadData1_ID}), .sel(forwardA));
	mux2_164bit aluMux(.out(B), .i0(inB), .i1(immInExtd_ID), .sel(ALUSrc_ID));

	alu arithmetic(.A, .B, .cntrl(ALUOp_ID), .zero, .overflow, .negative, .carry_out, .result);

	D_FF64bit r7(.clk, .reset, .d(result), .q(result_EX));
	D_FF64bit r17(.clk, .reset, .d(address_IF), .q(address_ID));
	D_FF64bit pclinks123(.clk, .reset, .d(PCLink_ID), .q(PCLink_EX));
	D_FF5bit r9(.clk, .reset, .d(RegRm_ID), .q(RegRm_EX));
	D_FF5bit r10(.clk, .reset, .d(RegRn_ID), .q(RegRn_EX));
	D_FF5bit r11(.clk, .reset, .d(RegRd_ID), .q(RegRd_EX));
	cntrlReg #(.W(2)) memSig2 (.clk, .reset, .in({MemRead_ID, MemWrite_ID}), .out({MemRead_EX, MemWrite_EX}));
	D_FF64bit DataWriteReg (.clk, .reset, .d(inB), .q(inB_EX));
	cntrlReg #(.W(4)) wbSig2 (.clk, .reset, .in({MemtoReg_ID, RegWrite_ID, link_ID, Uncondbranch_ID}), .out({MemtoReg_EX, RegWrite_EX, link_EX, Uncondbranch_EX}));

	//---------------------------------------------------------------------MEM Stage-------------------------------------------------------------------------------
	
	datamem memory(.address(result_EX), .write_enable(MemWrite_EX), .read_enable(MemRead_EX), .write_data(inB_EX), .clk, .xfer_size(4'b1000), .read_data);

	D_FF64bit r12(.clk, .reset, .d(read_data), .q(read_data_MEM));
	D_FF64bit r13(.clk, .reset, .d(result_EX), .q(result_MEM));
	D_FF5bit r16(.clk, .reset, .d(RegRd_EX), .q(RegRd_MEM));
	D_FF64bit pclinks2(.clk, .reset, .d(PCLink_EX), .q(PCLink_MEM));

	cntrlReg #(.W(5)) wbSig3 (.clk, .reset, .in({MemtoReg_EX, RegWrite_EX, link_EX, Uncondbranch_EX, MemWrite_EX}), .out({MemtoReg_MEM, RegWrite_MEM, link_MEM, Uncondbranch_MEM, MemWrite_MEM}));

	//---------------------------------------------------------------------WB Stage-------------------------------------------------------------------------------

	mux2_164bit datamemout(.out(DataOut), .i0(result_MEM), .i1(read_data_MEM), .sel(MemtoReg_MEM));

	mux2_15bit BLink1(.out(WriteRegister), .i0(RegRd_MEM), .i1(5'b11110), .sel(link_MEM));
	
	mux2_164bit BLink0(.out(WriteData), .i0(DataOut), .i1(PCLink_MEM), .sel(link_MEM));

	D_FF5bit r18(.clk, .reset, .d(RegRd_MEM), .q(RegRd_WB));
	D_FF64bit r19(.clk, .reset, .d(DataOut), .q(DataOut_WB));
	D_FF64bit r20(.clk, .reset, .d(result_MEM), .q(result_WB));
	D_FF64bit pclinks3(.clk, .reset, .d(PCLink_MEM), .q(PCLink_WB));

	cntrlReg #(.W(2)) wbRegSig4 (.clk, .reset, .in({RegWrite_MEM, Uncondbranch_MEM}), .out({RegWrite_WB, Uncondbranch_WB}));
	forwarding fwdUnit(.RegWrite_WB, .RegRd_WB, .regWriteEx(RegWrite_EX), .regWriteMem(RegWrite_MEM), .RegRdEx(RegRd_EX), .RegRdMem(RegRd_MEM), .RegRn_ID, .RegRm_ID, .forwardA, .forwardB, .flagForward, .SetFlag_ID, .BRegFwd, .Branch, .RegRd_ID, .RegRd_IF(instruction_IF[4:0]), .BReg, .CBZFwd, .branch0, .Uncondbranch_MEM, .Uncondbranch_WB, .BLFwd, .MemWrite_ID, .MemWrite_EX, .MemWrite_MEM);

endmodule

module cpu_tb();
	logic clk, reset;
	
	cpu dut(.*);
	integer i;
	parameter clock_period = 50000;
	
	initial begin
		clk = 0;
		forever #(clock_period/2) clk = ~clk;
	end
	
	initial begin
		reset = 1; @(posedge clk);
		reset = 0; @(posedge clk);
		repeat(1024) @(posedge clk);
		$stop;
	end
endmodule


	
	