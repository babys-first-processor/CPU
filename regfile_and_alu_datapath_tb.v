module regfile_and_alu_datapath_tb;

reg W, clk, rst, EN_ALU, EN_B, K_SEL, C0;
reg [4:0] SA, SB, DA, FS;
reg [63:0] K;
wire [3:0] Status;
wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7;

regfile_and_alu_datapath dut(.W(W), .clk(clk), .rst(rst), .EN_ALU(EN_ALU), .EN_B(EN_B), .K_SEL(K_SEL), .C0(C0), .SA(SA), .SB(SB), .DA(DA), .FS(FS), .K(K), .Status(Status), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7));

always begin
	#5 clk = ~clk;
end

initial begin
	clk = 1'b0;
	rst = 1'b1;
	
	#10;
	rst = 1'b0;
	//begin loading values into regfile from K
	K = 64'h0000_0000_0000_FFFF;
	K_SEL = 1'b1;
	C0 = 1'b0;
	FS = 5'b01000;
	SA = 5'b11111;
	SB = 5'bx;
	DA = 5'b00000;
	EN_ALU = 1'b1;
	EN_B = 1'b0;
	W = 1'b1;

	#10;
	K = 64'h0000_0000_FFFF_0000;
	K_SEL = 1'b1;
	C0 = 1'b0;
	FS = 5'b01000;
	SA = 5'b11111;
	SB = 5'bx;
	DA = 5'b00001;
	EN_ALU = 1'b1;
	EN_B = 1'b0;
	W = 1'b1;
	
	
	#10;
	K = 64'h0000_FFFF_0000_0000;
	K_SEL = 1'b1;
	C0 = 1'b0;
	FS = 5'b01000;
	SA = 5'b11111;
	SB = 5'bx;
	DA = 5'b00010;
	EN_ALU = 1'b1;
	EN_B = 1'b0;
	W = 1'b1;
	
	#10;
	K = 64'hFFFF_0000_0000_0000;
	K_SEL = 1'b1;
	C0 = 1'b0;
	FS = 5'b01000;
	SA = 5'b11111;
	SB = 5'bx;
	DA = 5'b00011;
	EN_ALU = 1'b1;
	EN_B = 1'b0;
	W = 1'b1;
	//end loading values into regfile from K
	
	//subtract a value from K and store in regfile
	#10;
	K = 64'hFFFF_FFFF_FFFF_FFFF;
	K_SEL = 1'b1;
	C0 = 1'b1;
	FS = 5'b01010;
	SA = 5'b00001;
	SB = 5'bx;
	DA = 5'b00100;
	EN_ALU = 1'b1;
	EN_B = 1'b0;
	W = 1'b1;
	
	//write from regfile directly to another register
	#10;
	K = 64'hx;
	K_SEL = 1'b0;
	C0 = 1'b0;
	FS = 5'bx;
	SA = 5'b11111;
	SB = 5'b00001;
	DA = 5'b00101;
	EN_ALU = 1'b0;
	EN_B = 1'b1;
	W = 1'b1;
	
	#10;
	$stop;
	
end

endmodule
	