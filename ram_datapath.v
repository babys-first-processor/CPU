module ram_datapath(
	input W, //regfile write
	input clk, //clock
	input rst, //reset
	input EN_B, //Output B from regfile to data bus 
	input EN_ALU, //Output ALU to data bus
	input EN_ADDR, //Output ALU to address bus
	input K_SEL, //Choose to use B(0) for ALU input or K(1)
	input PC_SEL, //Choose to use ???(0) for Program Counter input or A(1)
	input C0, //Carry in bit to ALU
	input CS, //Chip select for RAM
	input WE, //RAM Write Enable
	input OE, //RAM Output Enable
	input [63:0] CU, //External signal to K or PC_in thru mux, from control unit
	input [4:0] SA, SB, DA, FS, //Regfile A address, B address, Write Address, ALU function select
	input [63:0] K, //Constant input from control word
	output [63:0] PC_in, //Input to program counter 
	output [3:0] Status, //status flags, Overflow (V), Carry(C), Negative(N), Zero(Z)
	output [63:0] r0, r1, r2, r3, r4, r5, r6, r7); //output from regfile for testing

wire [63:0] A, B, F, D, ADDR, B_out; //regfile A and B outputs, ALU output, Data bus, Address Bus, output from B/K mux

//instantiate submodules
regfile32x64 regfile(.rdDataA(A), .rdDataB(B), .rdAddrA(SA), .rdAddrB(SB), .wrData(D), .wrAddr(DA), .write(W), .reset(rst), .clk(clk), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7));
ALU_LEGv8 alu(.A(A), .B(B_out), .FS(FS), .C0(C0), .F(F), .status(Status));
ram_sp_sr_sw ram(.clk(~clk), .address(ADDR[11:0]), .data(D), .cs(CS), .we(WE),	.oe(OE));

//set size of ram
defparam ram.DATA_WIDTH = 64;
defparam ram.ADDR_WIDTH = 12;

//instantiate unnamed (see: simple) components
Mux2to1 const_sel(.F(B_out), .A(K), .B(B), .Sel(K_SEL)); //A is constant, B is output from reg file
Mux2to1 counter_sel(.F(PC_in), .A(A), .B(CU), .Sel(PC_SEL)); //A is output A from regfile, B is input from external source
tribuf B_enable(.in(B), .out(D), .control(EN_B)); //Connects B from regfile to data bus when enabled, high z otherwise
tribuf ALU_enable(.in(F), .out(D), .control(EN_ALU)); //connects output of alu to data bus when enabled, high z otherwise
tribuf ADDR_enable(.in(F), .out(ADDR), .control(EN_ADDR)); //connects output of alu to address bus when enabled, high z otherwise

endmodule //end regfile_and_alu_datapath

/*
//2-to-1 Mux definition
module Mux2to1(
	input [63:0] A, B,
	input Sel,
	output [63:0] F);
	
assign F = Sel ? A : B; // if FS is 0, choose B, else chose A. 
endmodule//end mux

//Tri-State Buffer definition
module tribuf(
	input [63:0] in,
	input control,
	output [63:0] out);
	
assign  out = control ? in : 64'bz;
endmodule //end tribuf
*/