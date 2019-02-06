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
	#10;
	reset = 1'b0;
	write = 1'b1;
	wrAddr = 5'b00000;
	wrData = 64'hFFFFFFFFFFFFFFFF;
	#20;
	
	write = 1'b0;
	#5;
	write = 1'b1;
	#5;
	wrAddr = 5'b00001;
	wrData = 64'hAAAAAAAAAAAAAAAA;
	#20;
	/*
	write = 1'b0;
	#10;
	write = 1'b1;
	#10;
	wrAddr = 5'b00010;
	#20;
	wrData = 64'hCCCCCCCCCCCCCCCC;
	#20;
	
	write = 1'b0;
	#10;
	write = 1'b1;
	#10;
	wrAddr = 5'b00011;
	#20;
	wrData = 64'hF0F0F0F0F0F0F0F0;
	#10;
	*/
	write = 1'b0;
	rdAddrA = 5'b00000;
	rdAddrB = 5'b00001;
	#10;
	//rdAddrA = 5'b00010;
	//rdAddrB = 5'b00011;
	//#10;
	reset = 1'b1;
	rdAddrA = 5'b0;
	rdAddrB = 5'b00001;
	#10; $stop;
end
endmodule
