module regfile32x64_under_test;
	// create registers for holding the simulated input values to the DUT
	reg [4:0]rdAddrA, rdAddrB, wrAddr;
	reg [63:0]wrData;
	reg write, reset, clock;
	// create wires for the output of the DUT
	wire [63:0]rdDataA, rdDataB;
	
regfile32x64 dut (.rdDataA(rdDataA), .rdDataB(rdDataB), .rdAddrA(rdAddrA), .rdAddrB(rdAddrB), .wrData(wrData), .wrAddr(wrAddr), .write(write), .reset(reset), .clk(clock));

always begin
	#5; clock = ~clock;
end

initial begin
	clock = 1'b0;
	reset = 1'b1;
	write = 1'b0;
	wrAddr = 5'b0;
	wrData = 64'b0;
	#100;
	reset = 1'b0;
	#100;
	wrAddr = 5'b00000;
	#100;
	wrData = 64'hFFFFFFFFFFFFFFFF;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'b00001;
	#100;
	wrData = 64'hAAAAAAAAAAAAAAAA;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'b00010;
	#100;
	wrData = 64'hCCCCCCCCCCCCCCCC;
	#100;
	
	write = 1'b0;
	#100;
	write = 1'b1;
	#100;
	wrAddr = 5'b00011;
	#100;
	wrData = 64'hF0F0F0F0F0F0F0F0;
	#100;
	
	write = 1'b0;
	#100;
	rdAddrA = 5'b00000;
	rdAddrB = 5'b00001;
	#100;
	rdAddrA = 5'b00010;
	rdAddrB = 5'b00011;
	#100;
	reset = 1'b1;
	rdAddrA = 5'b0;
	rdAddrB = 5'b00001;
	#100; $stop;
end
endmodule
