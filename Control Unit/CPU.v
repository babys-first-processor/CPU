module CPU(
	input clk,
	input rst,
	output reg [3:0] status);
	
wire AS; 						//Address Select
wire [1:0] DS; 				//Data Select
wire [1:0] PS; 				//PC function select
wire PC_Sel; 					//Choose A or K for PC_in
wire K_Sel; 					//Choose B or K for ALU in
wire IL; 						//Instruction Register Load
wire SL; 						//Status Load
wire [4:0] FS; 				//ALU function select
wire C0; 						//Carry wire for ALU
wire MW; 						//Memory write
wire RW; 						//Regfile write
wire [4:0] DA; 				//Regfile D address
wire [4:0] SA, SB; 			//Regfile A address and B address
wire [63:0] K; 				//Constant wire
wire [3:0] SF; 
wire [31:0] IR_Out;  		//wire from instruction register
wire [33:0] control_word;
wire [1:0] NS;

assign {NS, AS, DS, PS, PC_Sel, K_Sel, IL, SL, FS, C0, MW, RW, DA, SA, SB} = control_word;

datapath_core core(clk, rst, AS, DS, PS, PC_Sel, K_Sel, IL, SL, FS, C0, MW, RW, DA, SA, SB, K, SF, IR_Out);
ControlUnit CU(clk, rst, SF, IR_Out, control_word, K);

endmodule
