`timescale 1ns / 1ps


///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the register bank module of our microprocessor.

///////////////////////////////////////////////////////////////////

module register_bank_tb;

	// Inputs
	reg [19:0] ins;
	reg [4:0] RW_dm;
	reg [7:0] ans_ex;
	reg [7:0] mux_ans_dm;
	reg [7:0] ans_wb;
	reg [7:0] imm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg imm_sel;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] A;
	wire [7:0] B;

	// Instantiate the Unit Under Test (UUT)
	register_bank_module uut (
		.ins(ins), 
		.RW_dm(RW_dm), 
		.ans_ex(ans_ex), 
		.mux_ans_dm(mux_ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.clk(clk), 
		.reset(reset), 
		.A(A), 
		.B(B)
	);

	always #500 clk = ~clk;			//changing the value of clk after every 500 ns		

	initial begin
		// Initialize Inputs
		clk = 0;					//Inputs at 0 ns
		ins = 20'b00000001010011000101;		//value in binary
		RW_dm = 16'h05;		//value in hexa decimal
		ans_ex = 16'h01;
		mux_ans_dm = 16'h02;
		ans_wb = 16'h03;
		imm = 16'h04;
		mux_sel_A = 16'h00;
		mux_sel_B = 16'h00;
		imm_sel = 1'b0;
		reset = 1'b1;

		#200;			//After 200 ns reset changes from 1 to 0
		reset = 1'b0;
		
		#600;			//After 500 ns reset changes from 0 to 1
		reset = 1'b1;
		
		#1000;		//After 1000 ns 
      RW_dm = 16'h06;			//RW_dm changes from 05H to 06H
		mux_ans_dm = 16'h05;		//mux_ans_dm changes from 02H to 05H
 
      #1000;		//after 1000 ns
		RW_dm = 16'h07;		//RW_dm changes from 06H to 07H
		mux_sel_A = 2'b01;		//mux_sel_A changes from 00H to 01H
 
      #1000;		//after 1000 ns
		mux_sel_A = 2'b10;		//mux_sel_A changes from 01H to 10H
		mux_sel_B = 2'b11;		//mux_sel_B changes from 00H to 11H
		
		#1000;		//after 1000 ns
		imm_sel=1'b1;		//imm_sel changes from 0 to 1

	end
      
endmodule		//body of code ends here