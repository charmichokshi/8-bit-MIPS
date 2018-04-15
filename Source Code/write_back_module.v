`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Write Back block of microprocessor.

///////////////////////////////////////////////////////////////////


module write_back_module(mux_ans_dm,ans_wb,reset,clk);

output reg [7:0] ans_wb;		//output declaration

input [7:0] mux_ans_dm;		//input declaration
input clk,reset;		

wire [7:0] ans_wb_t;		//temporary variable 

assign ans_wb_t = (reset==1'b1) ?mux_ans_dm:8'b00000000;		//assigning mux_ans_dm to ans_wb_t when reset is 1 else 0

always@(posedge clk)		//this block will work when the clock is at posedge
begin
		ans_wb <= ans_wb_t;		//at posedge clock giving the value of ans_wb_t to ans_wb
end

endmodule
