`timescale 1ns / 1ps


///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Test Bench of the stall control module of our microprocessor.

///////////////////////////////////////////////////////////////////

module stall_control_tb;

	// Inputs
	reg [19:0] ins_pm;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	stall_control_module uut (
		.stall(stall), 
		.stall_pm(stall_pm), 
		.ins_pm(ins_pm), 
		.clk(clk), 
		.reset(reset)
	);

	
   always #500 clk=~clk;		//changing the value of clk after every 500 ns
	 
	initial begin
	
		// Initialize Inputs
		clk = 1'b0;
		ins_pm = 20'h00000;		//value in hexadecimal
		reset = 1'b1;				//value in binary

		#200;			//after 200 ns reset changes from 1 to 0
		reset=1'b0;
		 
		#550;
		reset = 1'b1;

		#850;
		ins_pm = 20'ha0000;

   	#2000;
	   ins_pm=20'h00000;
		 
		#1000;
		ins_pm=20'hf0000;
		 
		#3000;
		ins_pm=20'h00000;
		 
		#1000;
		ins_pm=20'h88000;
		 
	end
      
endmodule		//body of code ends here

