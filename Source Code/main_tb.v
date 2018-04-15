`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the Top module of our microprocessor.

///////////////////////////////////////////////////////////////////

module main_tb;

	// Inputs
	reg [7:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [19:0] ins;
	wire [7:0] A;
	wire [7:0] B;
	wire [7:0] current_address;
	wire [7:0] ans_ex;
	wire [7:0] mux_ans_dm;
	wire [7:0] ans_wb;
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	main_module uut (
		.ins(ins), 
		.A(A), 
		.B(B), 
		.current_address(current_address), 
		.ans_ex(ans_ex), 
		.mux_ans_dm(mux_ans_dm), 
		.ans_wb(ans_wb), 
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset), 
		.data_out(data_out)
	);

	initial
	begin
		data_in = 0;
		interrupt = 0;
		clk = 1'b0;
		reset = 1'b1;
		#200; reset = 1'b0;
		#500; reset = 1'b1;
	end

always #500 clk = ~clk;			//changing the value of clk after every 500 ns		

endmodule
