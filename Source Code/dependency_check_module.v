`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Dependency Check block of microprocessor.

///////////////////////////////////////////////////////////////////

module dependency_check_module(ins,clk,reset,mux_sel_a,mux_sel_b,imm_sel,Imm,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,RW_dec,op_dec);

input [19:0] ins;			//input declaration of 20 bit instruction
input reset,clk;		//input declaration of 1 bit reset and clk

output [1:0] mux_sel_a, mux_sel_b;		//output declaration 
output reg [7:0] Imm;
output imm_sel;
output mem_en_dec, mem_rw_dec, mem_mux_sel_dec;
output reg [4:0] RW_dec, op_dec;

wire [4:0] op_dec_temp,op_dec_temp_t,r1_t, r3_t, r4_t, r5_t, r6_t, r2_t;		//wire declaration
wire a1,a2,a3,and_imm,ld_st,a4,a5,a7,a8,a9,a10,dout_1,o1;
wire [14:0] extend_out;
wire c1, c2, c3, c4, c5, c6;		//output of comparators
wire [14:0] a0;		//output of and gate
wire [7:0] r0_t;

reg [4:0] r1, r3, r4, r5, r6;		//output of registers
assign op_dec_temp = ins[19:15];		//assigning 5 MSB bits of ins to op_dec_temp

assign a0 = extend_out & ins[14:0];		//anding each bit of extend_out and ins, assigning it to a0 

//gate level modeling
and(a1,~op_dec_temp[0],~op_dec_temp[1],~op_dec_temp[2],op_dec_temp[3],op_dec_temp[4]);		
and(a2,op_dec_temp[2],op_dec_temp[3],op_dec_temp[4]);
and(a3,~op_dec_temp[0],~op_dec_temp[1],op_dec_temp[2],~op_dec_temp[3],op_dec_temp[4],~dout_1);
and(and_imm,op_dec_temp[3],~op_dec_temp[4]);		//The value of and_imm is 1 if the addressing mode is of immediate type
and(ld_st,~op_dec_temp[1],op_dec_temp[2],~op_dec_temp[3],op_dec_temp[4]);	//The value of ld_st is 1 if the instruction is either a load instruction or store instruction

and(a4,op_dec_temp[0],~mem_rw_dec);
and(a5,ld_st,~mem_en_dec);

and(mem_mux_sel_dec,~mem_rw_dec,mem_en_dec);
nor(o1,a1,a2,dout_1);	


//creating instances of d flip flop flipflop(input, output, reset, clk)
d_flipflop dff1(a3,dout_1,reset,clk);
d_flipflop dff2(a4,mem_rw_dec,reset,clk);
d_flipflop dff3(a5,mem_en_dec,reset,clk);
d_flipflop dff4(and_imm,imm_sel,reset,clk);

assign extend_out = (o1 == 1'b1) ?15'b111111111111111 : 15'b000000000000000;		//this acts as an extend block

assign r0_t = (reset==1'b1) ?{3'b000,ins[4:0]} :8'b00000000;
assign r1_t = (reset==1'b1) ?a0[9:5] :5'b00000;		//this will store RA of current address

assign r2_t = (reset==1'b1) ?a0[14:10] :5'b00000;		//this will store the RW of current ins
assign r3_t = (reset==1'b1) ?RW_dec :5'b00000;		//this will store the RW of third last stage(execution block)
assign r4_t = (reset==1'b1) ?r3 :5'b00000;		//this will store the RW of second last stage(data memory block)
assign r5_t = (reset==1'b1) ?r4 :5'b00000;		//this will store the RW of last stage(write back block)
assign r6_t = (reset==1'b1) ?a0[4:0] :5'b00000;		//this will store RB of current address

assign op_dec_temp_t = (reset==1'b1) ?op_dec_temp :5'b00000;

//register
always@(posedge clk)		//this statement shows that the block will execute when the clock is at posedge
begin		
		Imm <= r0_t;		
		r1 <= r1_t;		
		RW_dec <= r2_t;		
		r3 <= r3_t;		
		r4 <= r4_t;		
		r5 <= r5_t;		
		r6 <= r6_t;		
		op_dec <= op_dec_temp_t;		
end

//the following statements acts as comparator(if the inputs of comparator are equal than output is also 1 else 0)
assign c1 = (r1 == r3) ?1'b1:1'b0;		//if r1 and r3 are equal, then c1 is assigned 1 else 0
assign c2 = (r1 == r4) ?1'b1:1'b0;
assign c3 = (r1 == r5) ?1'b1:1'b0;
assign c4 = (r6 == r3) ?1'b1:1'b0;
assign c5 = (r6 == r4) ?1'b1:1'b0;
assign c6 = (r6 == r5) ?1'b1:1'b0;

//gate level modeling
and(a7, ~c1, c2);
and(a8, ~c1, ~c2, c3);
and(a9, ~c4, c5);
and(a10, ~c4, ~c5, c6);

/*		 To check the dependency of current instruction with previous three instructions
		 and to enable data forwarding in pipeline we are generating 
		 'mux_sel_a' and 'mux_sel_b' signals.
*/

//priority encoder
assign mux_sel_a = (a8 == 1'b1) ?2'b11:((a7 == 1'b1) ?(2'b10) :((c1 == 1'b1) ?2'b01:2'b00));
assign mux_sel_b = (a10 == 1'b1) ?2'b11:((a9 == 1'b1) ?(2'b10) :((c4 == 1'b1) ?2'b01:2'b00));

endmodule
//end of code