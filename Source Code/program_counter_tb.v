`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the program counter module of our microprocessor.

///////////////////////////////////////////////////////////////////

module program_counter_tb;

	// Inputs
	reg [7:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [19:0] ins;
	wire [19:0] ins_pm;
	wire [7:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	program_counter_module uut (
		.ins(ins), 
		.ins_pm(ins_pm), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

	
   //generating the waveform of clock
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 1'b0;
		jmp_loc = 1'b0;
		pc_mux_sel = 1'b1;
		stall = 1'b0;
		stall_pm = 1'b0;
		reset = 1'b1;
		
		#2;
		reset = 1'b0;
		
		#5;
		reset = 1'b1;
		
		#3;
		pc_mux_sel = 1'b0;
		jmp_loc=8'h08;
		
		#30;
		stall=1'b1;
		
		#20;
		stall=1'b0;
		
		#10;
		pc_mux_sel = 1'b1;
    
	end
      
endmodule





