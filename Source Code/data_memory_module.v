`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////

//GROUP NUMBER  - A05
//GROUP MEMBERS - ASHNA JAIN(201501008)
//					 - CHARMI CHOKSHI(201501021)
//              - MANASI DUBEY(201501051)
//DESCRIPTION:  - This is the Data Memory block of microprocessor.

///////////////////////////////////////////////////////////////////


module data_memory_module(ans_ex,B_Bypass,RW_ex,mem_en_ex,mem_rw_ex,mem_mux_sel_ex,clk,reset,mux_ans_dm,RW_dm);

input [7:0] ans_ex,B_Bypass;			//input declaration
input [4:0] RW_ex;
input mem_en_ex,mem_rw_ex,mem_mux_sel_ex,clk,reset;

output [7:0] mux_ans_dm;			//output declaration
output reg [4:0] RW_dm;


reg mem_mux_sel_dm;			//register declaration
reg [7:0] ans_reg;

wire mem_mux_sel_dm_t;		//temporary variables
wire [4:0] RW_dm_t;
wire [7:0] ans_reg_t;
wire [7:0] ans_dm;			


assign mem_mux_sel_dm_t = (reset==1'b1) ?mem_mux_sel_ex:1'b0;		//assigning mem_mux_sel_ex to mem_mux_sel_dm_t when reset is 1 else 0
assign RW_dm_t = (reset==1'b1) ?RW_ex:5'b00000;				//assigning RW_ex to RW_dm_t when reset is 1 else 0
assign ans_reg_t = (reset==1'b1) ?ans_ex:8'b00000000;			//assigning ans_ex to ans_reg_t when reset is 1 else 0

//register
always@(posedge clk)			//this statement shows that the block will execute when the clock is at posedge
begin 
		mem_mux_sel_dm <= mem_mux_sel_dm_t;			//assigning the value of  mem_mux_sel_ex to mem_mux_sel_dm_t using non blocking approach
		RW_dm <= RW_dm_t;					//assigning the value of  RW_ex_t to RW_dm using non blocking approach
		ans_reg <= ans_reg_t;				//assigning the value of  ans_ex_t to ans_reg using non blocking approach	
	
end

dm_ipcore data_memory (						//instance of ip core to fetch the data from given address
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [7 : 0] addra
  .dina(B_Bypass), // input [7 : 0] dina
  .douta(ans_dm) // output [7 : 0] douta
);

assign mux_ans_dm = (mem_mux_sel_dm==1'b1) ?ans_dm:ans_reg;			//this acts as a mux when mem_mux_sel_dm=1 ans_dm is assigned to mux_ans_dm otherwise ans_reg

endmodule		