module CPU_tb;

reg clk, rst;
wire [3:0] status;
wire [2:0] constant_sel;
wire [63:0] D, reg_out, r1, r2, r3, r4, r5, r6, r7;
wire [33:0] control_word;
wire [31:0] IR_Out;
wire [1:0] EX0_sel;
wire AS, PC_Sel, K_Sel, IL, SL, C0, MW, RW, ram_select, rom_select;
wire [1:0] NS, DS, PS;
wire [4:0] FS, DA, SA, SB;
wire [63:0] ALU_out, K;
wire [1:0] state;
wire [31:0] PC_out, rom_out;

CPU dut(clk, rst, reg_out, status);

assign r1 = dut.core.r1;
assign r2 = dut.core.r2;
assign r3 = dut.core.r3;
assign r4 = dut.core.r4;
assign r5 = dut.core.r5;
assign r6 = dut.core.r6;
assign r7 = dut.core.r7;
assign D = dut.core.D;
assign ALU_out = dut.core.regfile_alu_ram.F;


assign ram_select = dut.core.regfile_alu_ram.ram_select;
assign rom_select = dut.core.regfile_alu_ram.rom_select;
assign rom_out = dut.core.regfile_alu_ram.rom_out;
assign PC_out = dut.core.PC_out;
assign K = dut.K;
assign control_word = dut.control_word;
assign state = dut.CU.state;
assign IR_Out = dut.core.IR_Out;
assign EX0_sel = dut.CU.EX0_sel;
assign AS = dut.AS;
assign PC_Sel = dut.PC_Sel;
assign K_Sel = dut.K_Sel;
assign constant_sel = dut.CU.constant_sel;
assign IL = dut.IL;
assign SL = dut.SL;
assign C0 = dut.C0;
assign MW = dut.MW;
assign RW = dut.RW;
assign NS = dut.NS;
assign DS = dut.DS;
assign PS = dut.PS;
assign FS = dut.FS;
assign DA = dut.DA;
assign SA = dut.SA;
assign SB = dut.SB;

/*
assign dut.core.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000000_11111_11111}; //ADDI X31, X31, #0 = NOP
assign dut.core.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b1001000100_000000000111_11111_00010}; //ADDI X2, X31 #7
assign dut.core.regfile_alu_ram.ram0.mem[12'h802] = {32'b0, 32'b1001000100_000000001110_00010_00011}; //ADDI X3, X2, #14
assign dut.core.regfile_alu_ram.ram0.mem[12'h803] = {32'b0, 32'b111100101_11_0000000000000111_00011}; //MOVK X2, #21, LSL 64
assign dut.core.regfile_alu_ram.ram0.mem[12'h804] = {32'b0, 32'b110100101_11_0000000000010101_00010};	//MOVK X3, #7, LSL 64
assign dut.core.regfile_alu_ram.ram0.mem[12'h805] = {32'b0, 32'b1001000100_000000000000_11111_11111}; //ADDI X31, X31, #0 = NOP
//assign dut.core.regfile_alu_ram.ram0.mem[12'h804] = {32'b0, 32'b}
*/

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
assign dut.core.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000000_11111_00000}; //ADDI
assign dut.core.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b1001000100_000000000001_11111_00001}; //ADDI
assign dut.core.regfile_alu_ram.ram0.mem[12'h802] = {32'b0, 32'b10001011000_00000_000000_00001_00010}; //ADD
assign dut.core.regfile_alu_ram.ram0.mem[12'h803] = {32'b0, 32'b10001011000_11111_000000_00001_00000}; //ADD
assign dut.core.regfile_alu_ram.ram0.mem[12'h804] = {32'b0, 32'b10001011000_11111_000000_00010_00001}; //ADD
assign dut.core.regfile_alu_ram.ram0.mem[12'h805] = {32'b0, 10'b1111000100, 12'd9999, 10'b00000_11111}; //CMPI
assign dut.core.regfile_alu_ram.ram0.mem[12'h806] = {32'b0, 32'b01010100_0000000100000000000_0_1100}; //B.GT
//assign dut.core.regfile_alu_ram.ram0.mem[12'h807] = {32'b0, 32'b1001000100_000000000000_11111_11111}; //NOP
assign dut.core.regfile_alu_ram.ram0.mem[12'h807] = {32'b0, 32'b000101_00000000000000100000000010}; //B
//assign dut.core.regfile_alu_ram.ram0.mem[12'h808] = {32'b0, 32'b1001000100_000000000000_11111_11111}; //NOP



assign dut.core.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000000_11111_11111};
assign dut.core.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b000101_00000000000000100001010000}; //B 0x850
assign dut.core.regfile_alu_ram.ram0.mem[12'h850] = {32'b0, 32'b000101_00000000000000100000000001}; //B 0x800
assign dut.core.regfile_alu_ram.ram0.mem[12'h851] = {32'b0, 32'b1001000100_000000000000_11111_11111}; //NOP
*/

always begin
	#10 clk = ~clk;
end
	
initial begin
	clk <= 1'b0;
	rst <= 1'b1;
	#15;
	rst <= 1'b0;
	
	#50000;
	$stop;
end
endmodule
