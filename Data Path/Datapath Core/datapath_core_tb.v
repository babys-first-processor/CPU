module datapath_core_tb;

reg clk, rst, AS, PC_Sel, K_Sel, IL, SL, C0, MW, RW;
reg [1:0] PS;
reg [2:0] DS;
reg [4:0] FS, DA, SA, SB;
reg [63:0] K;
wire [3:0] SF;
wire [31:0] IR_Out, PC_Contents;
wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, mem0;

datapath_core dut(clk, rst, AS, DS, PS, PC_Sel, K_Sel, IL, SL, FS, C0, MW, RW, DA, SA, SB, K, SF, IR_Out);

assign dut.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000111_11111_00010};
assign dut.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b1001000100_000000001110_00010_00011};
assign dut.regfile_alu_ram.ram0.mem[12'h802] = {32'b0, 32'b11111000000_000001110_00_00010_00011};
assign dut.regfile_alu_ram.ram0.mem[12'h803] = {32'b0, 32'b11111000010_000000000_00_00011_00001};
assign r0 = dut.r0;
assign r1 = dut.r1;
assign r2 = dut.r2;
assign r3 = dut.r3;
assign r4 = dut.r4;
assign r5 = dut.r5;
assign r6 = dut.r6;
assign r7 = dut.r7;
assign PC_Contents = dut.PC_out;
assign mem0 = dut.regfile_alu_ram.ram0.mem[5'd21];


always begin
	#5 clk = ~clk;
end
	
initial begin
	clk <= 1'b0;
	rst <= 1'b1;
	#15;
	rst <= 1'b0;
	
	//Instruction Fetch - gets instruction from rom and stores in IR
	K <= 64'hx;
	AS <= 1'b0;
	DS <= 2'b11;
	PS <= 2'b01;
	K_Sel <= 1'bx;
	PC_Sel <= 1'bx;
	IL <= 1'b1;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'bx;
	SB <= 5'bx;
	DA <= 5'bx;
	RW <= 1'b0;
	MW <= 1'b0;
	
	#10;
	//ADDI X2, X31, 7 - This will be determined by control unit from IR input. 
	K <= 64'h0000_0000_0000_0007;
	AS <= 1'b0;
	DS <= 2'b00;
	PS <= 2'b00;
	K_Sel <= 1'b1;
	PC_Sel <= 1'bx;
	IL <= 1'b0;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b11111;
	SB <= 5'bx;
	DA <= 5'b00010;
	RW <= 1'b1;
	MW <= 1'b0;
	
	#10;
	
	//Instruction Fetch - gets instruction from rom and stores in IR
	K <= 64'hx;
	AS <= 1'b0;
	DS <= 2'b11;
	PS <= 2'b01;
	K_Sel <= 1'bx;
	PC_Sel <= 1'bx;
	IL <= 1'b1;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'bx;
	SB <= 5'bx;
	DA <= 5'bx;
	RW <= 1'b0;
	MW <= 1'b0;
	
	#10;
	//ADDI X3, X2, 14 = 21 decimal
	K <= 64'h0000_0000_0000_000E;
	AS <= 1'b0;
	DS <= 2'b00;
	PS <= 2'b00;
	K_Sel <= 1'b1;
	PC_Sel <= 1'bx;
	IL <= 1'b0;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00010;
	SB <= 5'bx;
	DA <= 5'b00011;
	RW <= 1'b1;
	MW <= 1'b0;
	
	#10;
	
	//Instruction Fetch - gets instruction from rom and stores in IR
	K <= 64'hx;
	AS <= 1'b1;
	DS <= 2'b11;
	PS <= 2'b01;
	K_Sel <= 1'bx;
	PC_Sel <= 1'bx;
	IL <= 1'b1;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'bx;
	SB <= 5'bx;
	DA <= 5'bx;
	RW <= 1'b0;
	MW <= 1'b0;
	
	#10;
	
	//STUR X3, [X2, #14] writes value in X3 to M[X2 + 14] = M[21]
	K <= 64'h0000_0000_0000_000E;
	AS <= 1'b0;
	DS <= 2'b01;
	PS <= 2'b00;
	K_Sel <= 1'b1;
	PC_Sel <= 1'bx;
	IL <= 1'b0;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00010;
	SB <= 5'b00011;
	DA <= 5'bx;
	RW <= 1'b0;
	MW <= 1'b1;
	
	#10;
	
	//Instruction Fetch - gets instruction from rom and stores in IR
	K <= 64'hx;
	AS <= 1'b1;
	DS <= 2'b11;
	PS <= 2'b01;
	K_Sel <= 1'bx;
	PC_Sel <= 1'bx;
	IL <= 1'b1;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'bx;
	SB <= 5'bx;
	DA <= 5'bx;
	RW <= 1'b0;
	MW <= 1'b0;
	
	#10;
	
	//LDUR X1, [X3, #0] 
	//X1 should have 21 when finished. 
	K <= 64'h0000_0000_0000_0000;
	AS <= 1'b0;
	DS <= 2'b11;
	PS <= 2'b00;
	K_Sel <= 1'b1;
	PC_Sel <= 1'bx;
	IL <= 1'b0;
	SL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00011;
	SB <= 5'bx;
	DA <= 5'b00001;
	RW <= 1'b1;
	MW <= 1'b0;
	
	#30;
	$stop;
end

endmodule
