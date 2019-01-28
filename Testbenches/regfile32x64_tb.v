module regfile32x64_tb;
reg clk;
reg write;
reg [4:0] wrAddr;
reg [63:0] wrData;
reg[4:0] rdAddrA, rdAddrB;

wire[63:0] rdDataA, rdDataB;

regfile32x64 uut (
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
	wrAddr = 5'b0;
	wrData = 64'b0;
	rdAddrA = 5'bx;
	rdAddrB = 5'bx;
	#100;
	
	wrAddr = 32'h00; //register 0
	#100;
	wrData = 64'hFFFAFFFFFFFFFFFF; //all ones
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'h08; //register 8
	#100;
	wrData = 64'hAAAAAAAAAAAAAAAA; //Alternating ones and zeroes
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'h0F; //register 15
	#100;
	wrData = 64'hCCCCCCCCCCCCCCCC; //pairs 11001100....
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'h1F;//register 31
	#100;
	wrData = 64'hF0F0F0F0F0F0F0F0; //1111000011110000....
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	rdAddrA = 5'h00;
	rdAddrB = 5'h08;
	#100;
	rdAddrA = 5'h0F;
	rdAddrB = 5'h1F;
	#100; $stop;
end
endmodule
