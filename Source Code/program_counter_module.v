`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Program Counter block of microprocessor.

///////////////////////////////////////////////////////////////////

module program_counter_module(ins,ins_pm,current_address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);

//output declaration
output [19:0] ins, ins_pm;
output [7:0] current_address;

//input declaration
input [7:0] jmp_loc;
input pc_mux_sel, stall, stall_pm, reset, clk;

//wire and reg declaration
wire [7:0] current_address_temp, mux_temp, incre_mux_temp;
reg [7:0] address_hold, next_address;
reg [19:0] reg_op;
reg init;
wire ena=1'b1;
wire [19:0] ins_pm_temp;
wire [7:0] next_address_t, address_hold_t;
wire [19:0] reg_op_t;


//multiplexers
assign current_address_temp = (stall==1'b0) ?next_address:address_hold;		//if the stall signal is 1 than we have to hold the address of present ins else we have to opt for next address
assign mux_temp = (pc_mux_sel==1'b0) ?current_address_temp:jmp_loc;		//if there is a jump ins than we have to pass the jump location to next mux else current address
assign current_address = (init == 1'b0) ?8'b0:mux_temp;

//increment block
assign incre_mux_temp = current_address + 8'b00000001;		//for getting the next address we have to increment current address by 1


assign next_address_t = (reset == 1'b1) ?incre_mux_temp:8'b00000000;		//next_address_t is a temporary wire that stores the value of incre_mux_temp if reset is 1 otherwise it stores 0 (next_address_t is a wire that gives the value to next_address at posedge clock)
assign address_hold_t = (reset == 1'b1) ?current_address:8'b00000000;	//address_hold_t is a temporary wire that stores the value of current_address if reset is 1 otherwise it stores 0 (address_hold_t is a wire that gives the value to address_hold at posedge clock)
assign reg_op_t = (reset == 1'b1) ?ins:20'b0;		//reg_op_t is a temporary wire that stores the value of ins if reset is 1 otherwise it stores 0 (reg_op_t is a wire that gives the value to reg_op at posedge clock)

always@(posedge clk)		//the following block will execute at posedge of clock
begin
	next_address <= next_address_t;
	address_hold <= address_hold_t;
	init <= reset;		
	reg_op <= reg_op_t;
end


prg_cnt_ipcore program_counter (			//calling the instance of program counter ip core
  .clka(clk), // input clka
  .ena(ena), // input ena
  .addra(current_address), // input [7 : 0] addra
  .douta(ins_pm_temp) // output [19 : 0] douta
);


//multiplexer
assign ins = (stall_pm == 1'b1) ?reg_op:ins_pm_temp;		//if stall_pm is 1 than we are holding the value of ins else we will pass the new instruction
assign ins_pm = (init == 1'b1) ?ins:20'b0;		//if init(output of a dff) is 1 than assignning ins to ins_pm else 0

endmodule
