`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the jump control module of our microprocessor.

///////////////////////////////////////////////////////////////////

module jump_control_tb;

	// Inputs
	reg [19:0] ins;
	reg clk;
	reg interrupt;
	reg [7:0] current_address;
	reg [3:0] flag_ex;
	reg reset;

	// Outputs
	wire pc_mux_sel;
	wire [7:0] jmp_loc;

	// Instantiate the Unit Under Test (UUT)
	jump_control_module uut (
		.ins(ins), 
		.clk(clk), 
		.interrupt(interrupt), 
		.current_address(current_address), 
		.flag_ex(flag_ex), 
		.reset(reset), 
		.pc_mux_sel(pc_mux_sel), 
		.jmp_loc(jmp_loc)
	);

	always #500 clk = ~clk;		//changing the value of clk after every 500 ns		
	
	initial begin
		// Initialize Inputs st 0 ns
		ins = 20'h0;		//value in hexa decimal
		clk = 1'b0;
		interrupt = 1'b0;		//value in binary
		current_address = 8'h01;
		flag_ex = 4'h8;
		reset = 1'b1;


	  #200;		//After 200 ns reset changes from 1 to 0
	  reset=1'b0;
	  
	  #500;		//After 500 ns reset changes from 0 to 1 and so on...
	  reset=1'b1;
	  
	  #1000;
	  interrupt=1'b1;
	  
	  #1000;
	  interrupt=1'b0;
	  ins=20'h00008;
	  
	  #1000;
	  current_address=8'h04;
	  ins=20'hc0008;
	  
	  #1000;
	  ins=20'h80008;
	  
	  #1000;
	  ins=20'hf8008;
	  
	  #1000;
	  flag_ex=4'ha;

	end
      
endmodule		//code ends here
