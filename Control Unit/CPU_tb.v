module CPU_tb;

reg clk, rst;
wire [3:0] status;
wire [63:0] D, r0, r1, r2, r3, r4, r5, r6, r7;
wire [33:0] control_word;
wire [31:0] IR_Out;
wire [1:0] EX0_sel;
wire AS, PC_Sel, K_Sel, IL, SL, C0, MW, RW;
wire [1:0] NS, DS, PS;
wire [4:0] FS, DA, SA, SB;
wire [63:0] ALU_out, K;

CPU dut(clk, rst, status);
assign r0 = dut.core.r0;
assign r1 = dut.core.r1;
assign r2 = dut.core.r2;
assign r3 = dut.core.r3;
assign r4 = dut.core.r4;
assign r5 = dut.core.r5;
assign r6 = dut.core.r6;
assign r7 = dut.core.r7;
assign D = dut.core.D;
assign ALU_out = dut.core.regfile_alu_ram.F;
assign K = dut.K;

assign control_word = dut.control_word;
assign IR_Out = dut.core.IR_Out;
assign EX0_sel = dut.CU.EX0_sel;
assign AS = dut.AS;
assign PC_Sel = dut.PC_Sel;
assign K_Sel = dut.K_Sel;
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

assign dut.core.regfile_alu_ram.ram0.mem[12'h800] = {32'b0, 32'b1001000100_000000000111_11111_00010};
assign dut.core.regfile_alu_ram.ram0.mem[12'h801] = {32'b0, 32'b1001000100_000000001110_00010_00011};
assign dut.core.regfile_alu_ram.ram0.mem[12'h802] = {32'b0, 32'b11111000000_000001110_00_00010_00011};
assign dut.core.regfile_alu_ram.ram0.mem[12'h803] = {32'b0, 32'b11111000010_000000000_00_00011_00001};

always begin
	#10 clk = ~clk;
end
	
initial begin
	clk <= 1'b0;
	rst <= 1'b1;
	#20;
	rst <= 1'b0;
	
	#200;
	$stop;
end
endmodule
