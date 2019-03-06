module regfile_and_alu_datapath(
	input W, clk, rst, EN_ALU, EN_B, K_SEL, C0,
	input [4:0] SA, SB, DA, FS,
	input [63:0] K,
	output [3:0] Status,
	output [63:0] r0, r1, r2, r3, r4, r5, r6, r7);

wire [63:0] A, B, F, D, Mux_out;

regfile32x64 regfile(.rdDataA(A), .rdDataB(B), .rdAddrA(SA), .rdAddrB(SB), .wrData(D), .wrAddr(DA), .write(W), .reset(rst), .clk(clk), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7));
ALU_LEGv8 alu(.A(A), .B(Mux_out), .FS(FS), .C0(C0), .F(F), .status(Status));

Mux2to1 const_sel(.F(Mux_out), .A(K), .B(B), .Sel(K_SEL)); //A is constant, B is output from reg file
tribuf B_enable(.in(B), .out(D), .control(EN_B)); //Connects B from regfile to data bus when enabled, high z otherwise
tribuf ALU_enable(.in(F), .out(D), .control(EN_ALU)); //connects output of alu to data bus when enabled, high z otherwise

endmodule //end regfile_and_alu_datapath

module Mux2to1(
	input [63:0] A, B,
	input Sel,
	output [63:0] F);
	
assign F = Sel ? A : B; // if FS is 0, choose B, else chose A. 
endmodule//end mux

module tribuf(
	input [63:0] in,
	input control,
	output [63:0] out);
	
assign  out = control ? in : 64'bz;
endmodule //end tribuf


