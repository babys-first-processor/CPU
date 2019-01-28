module regfile4x16_tb;

reg clk;
reg write;
reg [2:0] wrAddr;
reg [15:0] wrData;
reg[2:0] rdAddrA, rdAddrB;

wire[15:0] rdDataA, rdDataB;

regfile4x16 uut (
	.write(write),
	.clk(clk),
	.wrAddr(wrAddr),
	.wrData(wrData),
	.rdAddrA(rdAddrA),
	.rdAddrB(rdAddrB),
	.rdDataA(rdDataA),
	.rdDataB(rdDataB));
	
initial clk = 0;
always #10 clk = !clk;
initial begin
	write = 1'b0;
	wrAddr = 3'b0;
	wrData = 16'b0;
	rdAddrA = 3'bx;
	rdAddrB = 3'bx;
	#100;
	
	wrAddr = 3'b000;
	#100;
	wrData = 16'hFFFF;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 3'b001;
	#100;
	wrData = 16'hAAAA;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 3'b010;
	#100;
	wrData = 16'hCCCC;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 3'b011;
	#100;
	wrData = 16'hF0F0;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	rdAddrA = 3'b000;
	rdAddrB = 3'b001;
	#100;
	rdAddrA = 3'b010;
	rdAddrB = 3'b011;
	#100; $stop;
end
endmodule
