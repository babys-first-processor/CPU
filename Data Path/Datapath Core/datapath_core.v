module datapath_core(
	input clk,						//clock
	input rst, 						//reset
	input AS, 						//Address Select
	input [1:0] DS, 				//Data Select
	input [1:0] PS, 				//PC function select
	input PC_Sel, 					//Choose A or K for PC_in
	input K_Sel, 					//Choose B or K for ALU in
	input IL, 						//Instruction Register Load
	input SL, 						//Status Load
	input [4:0] FS, 				//ALU function select
	input C0, 						//Carry input for ALU
	input MW, 						//Memory write
	input RW, 						//Regfile write
	input [4:0] DA, 				//Regfile D address
	input [4:0] SA, SB, 			//Regfile A address and B address
	input [63:0] K, 				//Constant input
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7,
	output reg [3:0] SF, 		//Status Flags
	output [31:0] IR_Out);     //Output from instruction register

wire EN_ADDR_ALU, EN_ADDR_PC, EN_DATA_ALU, EN_DATA_B, EN_DATA_PC, MR;
wire [3:0]Status;
wire [63:0] D;
wire [31:0] ADDR, PC_in, PC_out;


//1 to 2 decoder for Address
assign {EN_ADDR_PC, EN_ADDR_ALU} = AS == 1'b0 ? 2'b01 : 2'b10;

//2 to 4 decoder for Data
assign {MR, EN_DATA_PC, EN_DATA_B, EN_DATA_ALU} = DS == 2'b00 ? 4'b0001 :
																  DS == 2'b01 ? 4'b0010 :
																  DS == 2'b10 ? 4'b0100 :
																  DS == 2'b11 ? 4'b1000 : 4'b0001;


//DFF for status flags
parameter STATUS_DEFAULT = 4'b0000;
always @(posedge clk or posedge rst)
	begin
		if (rst) SF <= STATUS_DEFAULT;
		else if (SL) SF <= Status;
		else SF <= SF;
	end

//regfile alu ram
ram_datapath regfile_alu_ram(.W(RW), .clk(clk), .rst(rst), .EN_ALU(EN_DATA_ALU), .EN_B(EN_DATA_B), .EN_ADDR(EN_ADDR_ALU), 
.K_SEL(K_Sel), .PC_SEL(PC_Sel), .C0(C0), .WE(MW), .OE(MR), .SA(SA), .SB(SB), .DA(DA), .FS(FS), .K(K),
.Status(Status), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .D(D), .ADDR(ADDR), .PC_in(PC_in));
defparam regfile_alu_ram.ram0.DATA_WIDTH = 64;
defparam regfile_alu_ram.ram0.ADDR_WIDTH = 12;

//rom
//rom_case rom(.out(D[31:0]), .address(ADDR[15:0]), .oe(MR));

//program counter
program_counter PC(.clk(clk), .rst(rst), .in(PC_in), .PS(PS), .out(PC_out));
defparam PC.PC_RESET_VALUE = 12'h800;

//instruction register
RegisterNbit IR(.Q(IR_Out), .D(D[31:0]), .L(IL), .R(rst), .clock(clk));
defparam IR.N = 32;

//tri state buffers for buses
tribuf32 addr_pc(.in(PC_out), .control(EN_ADDR_PC), .out(ADDR));
tribuf64 data_pc(.in({32'b0, PC_out}), .control(EN_DATA_PC), .out(D));

	
endmodule	