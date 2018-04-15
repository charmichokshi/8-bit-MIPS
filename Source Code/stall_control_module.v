`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Stall Control block of microprocessor.

///////////////////////////////////////////////////////////////////


module stall_control_module(stall,stall_pm,ins_pm,clk,reset);

output stall,stall_pm;		//declaring output

input clk,reset;				//declaring input
input [19:0] ins_pm;			//declaring input of 20 bits

wire [4:0] temp;				//declaring wire of 5 bits
wire Jump,LD,HLT,d1,d2,d3;		//declaring wires

assign temp = ins_pm[19:15];			//assigning bits from 15 to 19 of ins_pm to temp

//gate level modeling
and(HLT,temp[0],~temp[1],~temp[2],~temp[3],temp[4]);			//checking if the opcode is of HLT	
and(LD,~temp[0],~temp[1],temp[2],~temp[3],temp[4],~d1);		//checking if the opcode is of Load
and(Jump,temp[2],temp[3],temp[4],~d3);			//checking if the opcode is of Jump

or(stall,Jump,LD,HLT);		//if it is HLT or Jump or LD than making stall signal 1

//creating instances of d flip flop ( d_flipflop(input, output, reset, clk) )
d_flipflop dff1(LD,d1,reset,clk);		//stalling for 1 clk cycle for LD instruction

//staling for total 2 clk cycles for Jump instruction
d_flipflop dff2(Jump,d2,reset,clk);		
d_flipflop dff3(d2,d3,reset,clk); 

d_flipflop dff4(stall,stall_pm,reset,clk);		//making stall_pm signal 1 after 1 clock cycle of stall

endmodule		//Body of code ends here
