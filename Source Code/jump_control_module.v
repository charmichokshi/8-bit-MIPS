`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Jump Control block of microprocessor.

///////////////////////////////////////////////////////////////////


module jump_control_module(ins,clk,interrupt,current_address,flag_ex,reset,pc_mux_sel,jmp_loc);

input [19:0] ins;		//input declaration of 20 bits
input clk,interrupt,reset;		//input declaration of 1 bit
input [3:0] flag_ex;			//input declaration of 4 bits
input [7:0] current_address;		//input declaration of 8 bits

output pc_mux_sel;		//output declaration of 1 bit
output [7:0] jmp_loc;		//output declaration of 8 bits

wire [4:0] temp;		//wire declaration
wire [7:0] jump_address;
wire jc,jnc,jz,jnz,jmp,ret, r3_t;
wire [7:0] m1,m2, r1_t;
wire [3:0] m4, r2_t;
wire [3:0] final_flag;
wire a1,a2,a3,a4;

reg r3;			//register declaration
reg [7:0] r1;
reg [3:0] r2;

assign temp = ins[19:15];		//assigning 5 MSB of ins to temp
assign jump_address = ins[7:0];		//assigning 8 LSB of ins to jump_address

//GATE LEVEL MODELING
and(jc,~temp[0],~temp[1],temp[2],temp[3],temp[4]);		//checking if the opcode is of jc(jump when carry) or not
and(jnc,temp[0],~temp[1],temp[2],temp[3],temp[4]);		//checking if the opcode is of jnc(jump when not carry) or not
and(jz,~temp[0],temp[1],temp[2],temp[3],temp[4]);		//checking if the opcode is of jz(jump when zero) or not
and(jnz,temp[0],temp[1],temp[2],temp[3],temp[4]);		//checking if the opcode is of jnc(jump when not carry) or not
and(jmp,~temp[0],~temp[1],~temp[2],temp[3],temp[4]);	//checking if the opcode is of jmp(unconditional jump) or not

and(ret,~temp[0],~temp[1],~temp[2],~temp[3],temp[4]);		//checking if the opcode is of ret(return) or not


/*		When interrupt signal value is '1', we stores 'current_address' and 'flag_ex' in the system,
		program will jump to location (8'hF0). 
		When interrupt process is over we are providing RET instruction to continue our main program,
		for that we need to reproduce 'current_address' and 'flag_ex' which was previously stored in system.
*/

assign m1= (interrupt==1'b1) ?current_address:r1;		//creating multiplexers using conditional operator
assign m2= (r3==1'b1) ? 8'hf0:jump_address;
assign jmp_loc= (ret==1'b1) ?r1:m2;
assign m4= (interrupt==1'b1) ?flag_ex:r2;
assign final_flag= (ret==1'b1) ?r2:flag_ex;


assign r3_t = (reset==1'b1) ?interrupt:1'b0;		//r3_t is a temporary wire that stores the value of interrupt if reset is 1 otherwise it stores 0 (r3_t is a wire that gives the value to r3 at posedge clock)
assign r1_t = (reset==1'b1) ?m1:8'b0;		//r1_t is a temporary wire that stores the value of m1 if reset is 1 otherwise it stores 0 (r1_t is a wire that gives the value to r1 at posedge clock)
assign r2_t = (reset==1'b1) ?m4:4'b0;		//r2_t is a temporary wire that stores the value of m4 if reset is 1 otherwise it stores 0 (r2_t is a wire that gives the value to r2 at posedge clock)

//register
always@(posedge clk)		//this statement shows that the block will execute when the clock is at posedge
begin
	r3 <= r3_t;		
	r1 <= r1_t;
	r2 <= r2_t;
end

and(a1,jc,final_flag[0]);		//output will be 1 when jc opcode is given and carry flag is 1
and(a2,jnc,~final_flag[0]);	//output will be 1 when jnc opcode is given and carry flag is 0 beacause it is a jump when not carry
and(a3,jz,final_flag[1]);		//output will be 1 when jz opcode is given and zero flag is 1
and(a4,jnz,~final_flag[1]);	//output will be 1 when jnz opcode is given and zero flag is 0 beacause it is a jump when not zero


/*		generating pc_mux_sel 1 if any of the jump instruction or ret is found
		which is the selection line for the pc mux to take either next address or jump address
*/
or(pc_mux_sel,a1,a2,a3,a4,jmp,r3,ret);		

endmodule		//code ends here
