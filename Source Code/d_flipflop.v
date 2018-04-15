`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:37:07 10/14/2016 
// Design Name: 
// Module Name:    d_flipflop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module d_flipflop(A,B,reset,clk);

output reg B;		//output declaration

input A,reset,clk;		//input declaration
wire B_t;

assign B_t = (reset==1'b1) ?A :1'b0;


always@(posedge clk)		//this block will work when the clock is at posedge
begin
	B <= B_t;
end
endmodule		//body of code ends here
