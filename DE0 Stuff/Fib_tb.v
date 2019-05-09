module Fib_tb;


reg clk, rst;
wire [3:0] status;
wire [2:0] constant_sel;
wire [63:0] D, reg_out, r1, r2, r3, r4, r5, r6, r7;
wire [33:0] control_word;
wire [31:0] IR_Out;
wire [1:0] EX0_sel;
wire AS, PC_Sel, K_Sel, IL, SL, C0, MW, RW;
wire [1:0] NS, DS, PS;
wire [4:0] FS, DA, SA, SB;
wire [63:0] ALU_out, K;
wire [1:0] state;
wire [31:0] PC_out;
wire [31:0] ADDR;

wire [9:0] LEDG;
wire [6:0] HEX3, HEX2, HEX1, HEX0;

Fib dut(.CLOCK_50(clk), .BUTTON(rst), .LEDG(LEDG), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));

assign ADDR = dut.CPU.core.ADDR;
assign reg_out = dut.register;
assign status = dut.status;
assign r1 = dut.CPU.core.r1;
assign r2 = dut.CPU.core.r2;
assign r3 = dut.CPU.core.r3;
assign r4 = dut.CPU.core.r4;
assign r5 = dut.CPU.core.r5;
assign r6 = dut.CPU.core.r6;
assign r7 = dut.CPU.core.r7;
assign D = dut.CPU.core.D;
assign ALU_out = dut.CPU.core.regfile_alu_ram.F;

assign PC_out = dut.CPU.core.PC_out;
assign K = dut.CPU.K;
assign control_word = dut.CPU.control_word;
assign state = dut.CPU.CU.state;
assign IR_Out = dut.CPU.core.IR_Out;
assign EX0_sel = dut.CPU.CU.EX0_sel;
assign AS = dut.CPU.AS;
assign PC_Sel = dut.CPU.PC_Sel;
assign K_Sel = dut.CPU.K_Sel;
assign constant_sel = dut.CPU.CU.constant_sel;
assign IL = dut.CPU.CPU.IL;
assign SL = dut.CPU.CPU.SL;
assign C0 = dut.CPU.C0;
assign MW = dut.CPU.MW;
assign RW = dut.CPU.RW;
assign NS = dut.CPU.NS;
assign DS = dut.CPU.DS;
assign PS = dut.CPU.PS;
assign FS = dut.CPU.FS;
assign DA = dut.CPU.DA;
assign SA = dut.CPU.SA;
assign SB = dut.CPU.SB;


//Fibbonacci Sequence

//in C based language

//int main(void) {
//  int x, y, z;
//  while(1) { //always
//    x = 0;
//		y = 1;
//    do {
//      printf("%d\n, x); //print x as a decimal, newline after each x
//      z = x + y; 
//      x = y;
//      y = z;  //these three lines add up x and y, then "move" values left from z to y to x
//    } while (x < 9999); //max that can be shown on DE0 HEX3-HEX0 --- while not overflowed
//  }
//}

// in Assembly:
//0x800 : ADDI X0, X31, 0
//0x801 : ADDI X1, X31, 1
//0x802 : ADD X2, X1, X0
//0x803 : ADD X0, X1, X31
//0x804 : ADD X1, X2, X31
//0x805 : CMPI X0, 9999
//0x806 : B.GT 0x800
//0x807 : B 0x802 

/*
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000000_11111_00000}; //ADDI
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b1001000100_000000000001_11111_00001}; //ADDI
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h802] = {32'b0, 32'b10001011000_00000_000000_00001_00010}; //ADD
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h803] = {32'b0, 32'b10001011000_11111_000000_00001_00000}; //ADD
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h804] = {32'b0, 32'b10001011000_11111_000000_00010_00001}; //ADD
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h805] = {32'b0, 10'b1111000100, 12'd9999, 10'b00000_11111}; //CMPI
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h806] = {32'b0, 32'b01010100_0000000100000000000_0_1100}; //B.GT
assign dut.CPU.core.regfile_alu_ram.ram0.mem[12'h807] = {32'b0, 32'b000101_00000000000000100000000010}; //B
*/
`timescale 1s/1s 

always begin
	#10 clk = ~clk;
end
	
initial begin
	clk <= 1'b0;
	rst <= 1'b0;
	#10;
	rst <= 1'b1;
	
	#50000;
	$stop;
end
endmodule