module ram_datapath_tb;

reg W, clk, rst, EN_ALU, EN_B, EN_ADDR, K_SEL, PC_SEL, C0, CS, WE, OE;
reg [4:0] SA, SB, DA, FS;
reg [63:0] K, CU;
wire [3:0] Status;
wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, PC_in;
wire [63:0] mem0, mem1, D_debug;

assign mem0 = dut.ram.mem[12'h00F];
assign mem1 = dut.ram.mem[12'h0F0];
assign D_debug = dut.D;

ram_datapath dut(.W(W), .clk(clk), .rst(rst), .EN_ALU(EN_ALU), .EN_B(EN_B), .EN_ADDR(EN_ADDR), 
.K_SEL(K_SEL), .PC_SEL(PC_SEL), .C0(C0), .CS(CS), .WE(WE), .OE(OE), .SA(SA), .SB(SB), .DA(DA), .FS(FS), .K(K), .CU(CU), 
.Status(Status), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .PC_in(PC_in));


always begin
	#5 clk = ~clk;
end

initial begin
	clk <= 1'b0;
	rst <= 1'b1;
	CS <= 1'b0;
	#10;
	rst <= 1'b0;
	
	//begin loading values into regfile from K
	// ADDI X0, X31, K
	K <= 64'h0000_FFFF_0000_000F;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b11111;
	SB <= 5'bx;
	DA <= 5'b00000;
	EN_ALU <= 1'b1;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	
	//cont
	// ADDI X1, X31, K
	#10;
	K <= 64'hFFFF_0000_0000_00F0;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b11111;
	SB <= 5'bx;
	DA <= 5'b00001;
	EN_ALU <= 1'b1;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	
	//cont
	// ADDI X2, X31, K
	#10;
	K <= 64'h0123_4567_89AB_CDEF;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b11111;
	SB <= 5'bx;
	DA <= 5'b00010;
	EN_ALU <= 1'b1;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	
	//cont
	// ADDI X3, X31, K
	#10;
	K <= 64'hCCCC_CCCC_CCCC_CCCC;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b11111;
	SB <= 5'bx;
	DA <= 5'b00011;
	EN_ALU <= 1'b1;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	//end loading values into regfile from K
	
	//subtract a value from K and store in regfile
	// No assembly equivalent?? May add in future
	#10;
	K <= 64'hFFFF_FFFF_FFFF_FFFF;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b1;
	FS <= 5'b01010;
	SA <= 5'b00001;
	SB <= 5'bx;
	DA <= 5'b00100;
	EN_ALU <= 1'b1;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	
	//write from regfile directly to another register
	// ADD X5, X31, X1 <= MOV X5 X1
	#10;
	K <= 64'hx;
	CU <= 64'hx;
	K_SEL <= 1'b0;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'b11111;
	SB <= 5'b00001;
	DA <= 5'b00101;
	EN_ALU <= 1'b0;
	EN_B <= 1'b1;
	EN_ADDR <= 1'b0;
	W <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b0;
	
	//begin write values from registers to memory
	// STUR X2, [X0, 0]
	#20;
	K <= 64'h0000_0000_0000_0000;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00000; //address stored in reg0
	SB <= 5'b00010; //data in reg2
	DA <= 5'bx;
	EN_ALU <= 1'b0;
	EN_B <= 1'b1;
	EN_ADDR <= 1'b1;
	W <= 1'b0;
	CS <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b1;
	
	//cont
	// STUR X3, [X1, 0]
	#20;
	K <= 64'h0000_0000_0000_0000;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00001; //address in reg1
	SB <= 5'b00011; //data in reg3
	DA <= 5'bx;
	EN_ALU <= 1'b0;
	EN_B <= 1'b1;
	EN_ADDR <= 1'b1;
	W <= 1'b0;
	CS <= 1'b1;
	OE <= 1'b0;
	WE <= 1'b1;
	//end write from registers to memory
	
	//write value from memory to regfile
	// LDUR X6, [X0, 0]
	#15;
	K <= 64'h0000_0000_0000_0000;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00000; //memory address to read from
	SB <= 5'b00000;
	DA <= 5'b00110; //address to write to
	EN_ALU <= 1'b0;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b1;
	W <= 1'b1;
	CS <= 1'b1;
	WE <= 1'b0;
	OE <= 1'b1;
	
	
	//write another value from memory to regfile
	// LDUR X7, [X1, 0]
	#20;
	K <= 64'h0000_0000_0000_0000;
	CU <= 64'hx;
	K_SEL <= 1'b1;
	PC_SEL <= 1'b0;
	C0 <= 1'b0;
	FS <= 5'b01000;
	SA <= 5'b00001;
	SB <= 5'b00001;
	DA <= 5'b00111;
	EN_ALU <= 1'b0;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b1;
	CS <= 1'b1;
	WE <= 1'b0;
	OE <= 1'b1;
	W <= 1'b1;
	
	
	//output value from regfile to PC_in
	//BR X6
	#30;
	K <= 64'hx;
	CU <= 64'hx;
	K_SEL <= 1'b0;
	PC_SEL <= 1'b1;
	C0 <= 1'b0;
	FS <= 5'bx;
	SA <= 5'b00110;
	SB <= 5'bx;
	DA <= 5'bx;
	EN_ALU <= 1'b0;
	EN_B <= 1'b0;
	EN_ADDR <= 1'b0;
	OE <= 1'b0;
	WE <= 1'b0;
	W <= 1'b1;
	
	#30;
	$stop;
	
end

endmodule