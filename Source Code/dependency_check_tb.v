`timescale 1ns / 1ps


///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the dependency check module of our microprocessor.

///////////////////////////////////////////////////////////////////

module dependency_check_tb;

	// Inputs
	reg [19:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [1:0] mux_sel_a;
	wire [1:0] mux_sel_b;
	wire imm_sel;
	wire [7:0] Imm;
	wire mem_en_dec;
	wire mem_rw_dec;
	wire mem_mux_sel_dec;
	wire [4:0] RW_dec;
	wire [4:0] op_dec;

	// Instantiate the Unit Under Test (UUT)
	dependency_check_module uut (
		.ins(ins), 
		.clk(clk), 
		.reset(reset), 
		.mux_sel_a(mux_sel_a), 
		.mux_sel_b(mux_sel_b), 
		.imm_sel(imm_sel), 
		.Imm(Imm), 
		.mem_en_dec(mem_en_dec), 
		.mem_rw_dec(mem_rw_dec), 
		.mem_mux_sel_dec(mem_mux_sel_dec), 
		.RW_dec(RW_dec), 
		.op_dec(op_dec)
	);

	always #500 clk = ~clk;		//changing the value of clk after every 500 ns		
	
	initial begin
	
		// Initialize Inputs
		ins = 20'b00000_00000_00000_00000;		//Inputs at 0 ns in binary
		clk = 1'b0;
		reset = 1'b1;

		#200;     		//After 200 ns reset changes from 1 to 0
      reset=1'b0;
		  
		#600;         //After 600 ns reset changes from 0 to 1
		reset=1'b1;
		
		#200;		//After 200 ns changing the value of ins and so on
		ins = 20'b00000_00001_00010_00011;

		#1000;
		ins = 20'b10100_00100_00001_00000;
 
      #2000;
		ins = 20'b00100_00101_00001_00100;
		
		#1000;
		ins = 20'b01101_00110_00001_00101;
        
	end
      
endmodule		//end of code