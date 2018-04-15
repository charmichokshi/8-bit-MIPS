`timescale 1ns / 1ps


///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the execution module of our microprocessor.

///////////////////////////////////////////////////////////////////

module execution_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] data_in;
	reg [4:0] op_dec;
	reg clk;
	reg mem_en_dec;
	reg mem_rw_dec;
	reg mem_mux_sel_dec;
	reg [4:0] RW_dec;
	reg reset;

	// Outputs
	wire [3:0] flag_ex;
	wire [7:0] ans_ex;
	wire [7:0] data_out;
	wire [7:0] B_Bypass;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_ex;
	wire [4:0] RW_ex;

	// Instantiate the Unit Under Test (UUT)
	execution_module uut (
		.flag_ex(flag_ex), 
		.ans_ex(ans_ex), 
		.data_out(data_out), 
		.B_Bypass(B_Bypass), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_ex(mem_mux_sel_ex), 
		.RW_ex(RW_ex), 
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.mem_en_dec(mem_en_dec), 
		.mem_rw_dec(mem_rw_dec), 
		.mem_mux_sel_dec(mem_mux_sel_dec), 
		.RW_dec(RW_dec), 
		.reset(reset)
	);

always #500 clk = ~clk;		//for changing the value of clock at each 500 ns
		
		initial begin
	 	
		clk=0;		//initialy clock is assigned to 0 and reset to 1
		reset=1;
		
		#200;	
		reset=0;
		
		#600;
		reset=1;
		
		#200;		//assignning values to inputs at 1000 ns
		A = 16'h40;
		B = 16'hC0;
		data_in = 16'h08;
		op_dec = 5'b00000;
		mem_en_dec = 0;
		mem_rw_dec = 0;
		mem_mux_sel_dec = 0;
		RW_dec = 5;
		
		#1000;	//changing the opcode at 2us and so on...
		op_dec = 5'b00001;
		
		#1000;
		op_dec = 5'b00010;
		
		
		#1000;
		op_dec = 5'b00100;
		
		#1000;
		op_dec = 5'b00101;
		
		#1000;
		op_dec = 5'b00110;
		
		#1000;
		op_dec = 5'b00111;
		
		#1000;
		op_dec = 5'b01000;
		
		#1000;
		op_dec = 5'b01001;
		
		#1000;
		op_dec = 5'b01010;
		
		#1000;
		op_dec = 5'b01100;
		
		#1000;
		op_dec = 5'b01101;
		
		#1000;
		op_dec = 5'b01110;
		
		#1000;
		op_dec = 5'b01111;
		
		#1000;
		op_dec = 5'b10000;
		
		#1000;
		op_dec = 5'b10001;
		
		#1000;
		op_dec = 5'b10100;
		
		#1000;
		op_dec = 5'b10101;
		
		#1000;
		op_dec = 5'b10110;
		
		#1000;
		op_dec = 5'b10111;
		
		#1000;
		op_dec = 5'b11000;
		
		#1000;
		A = 16'hC0;
		B = 16'h01;
		data_in = 16'h08;
		op_dec = 5'b11001;
		mem_en_dec = 1;
		mem_rw_dec = 1;
		mem_mux_sel_dec = 1;
		RW_dec = 10;
		
		#1000;
		op_dec = 5'b11010;
		
		#1000;
		op_dec = 5'b11011;
		
		#1000;
		op_dec = 5'b11100;
		
		#1000;
		op_dec = 5'b11101;
		
		#1000;
		op_dec = 5'b11110;
		
	   #1000;
		op_dec = 5'b11111;	
end
endmodule
