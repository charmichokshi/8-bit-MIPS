`timescale 1ns / 1ps


///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the write back module of our microprocessor.

///////////////////////////////////////////////////////////////////

module write_back_tb;

	// Inputs
	reg [7:0] mux_ans_dm;
	reg reset;
	reg clk;

	// Outputs
	wire [7:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back_module uut (
		.mux_ans_dm(mux_ans_dm), 
		.ans_wb(ans_wb), 
		.reset(reset), 
		.clk(clk)
	);

always #500 clk=~clk;
	initial begin
		// Initialize Inputs
		mux_ans_dm = 32'hff;
		reset = 1'b1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#200;
		reset=1'b0;
		
		#550;
		reset=1'b1;
		
		#1250;
		mux_ans_dm=32'h0f;
        
		// Add stimulus here

	end
      
endmodule


