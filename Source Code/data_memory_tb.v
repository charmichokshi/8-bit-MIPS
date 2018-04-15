`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the data memory module of our microprocessor.

///////////////////////////////////////////////////////////////////

module data_memory_tb;

	// Inputs
	reg [7:0] ans_ex;
	reg [7:0] B_Bypass;
	reg [4:0] RW_ex;
	reg mem_en_ex;
	reg mem_rw_ex;
	reg mem_mux_sel_ex;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] mux_ans_dm;
	wire [4:0] RW_dm;

	// Instantiate the Unit Under Test (UUT)
	data_memory_module uut (
		.ans_ex(ans_ex), 
		.B_Bypass(B_Bypass), 
		.RW_ex(RW_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_ex(mem_mux_sel_ex), 
		.clk(clk), 
		.reset(reset), 
		.mux_ans_dm(mux_ans_dm), 
		.RW_dm(RW_dm)
	);

	

   always #500 clk = ~clk;   			//changing the value of clk after every 500 ns		

	initial begin
		//Inputs at 0 ns
		clk = 0;
		ans_ex = 16'h05;		//value in hexa decimal
		B_Bypass = 16'h50;
		RW_ex = 16'h1f;
		mem_en_ex = 0;
		mem_rw_ex = 0;
		mem_mux_sel_ex = 1'b1;	//value in binary
		reset = 1'b1;

		#200;     		//After 200 ns reset changes from 1 to 0
      reset=1'b0;
		  
		#600;         //After 600 ns reset changes from 0 to 1
		reset=1'b1;
		  
		#1200;      //After 1200 ns mem_en_ex changes from 0 to 1
		 mem_en_ex=1'b1;
		 
		#1000;    //After 1000 ns mem_rw_ex changes from 0 to 1
		mem_rw_ex=1'b1;
		 
		#1000;   //After 1000 ns mem_rw_ex changes from 1 to 0
		mem_rw_ex=1'b0;
		 
		#1000;  //After 1000 ns mem_mux_sel_ex changes from 1 to 0
		mem_mux_sel_ex=1'b0;
		 
	end
      
endmodule 		//body of code ends here