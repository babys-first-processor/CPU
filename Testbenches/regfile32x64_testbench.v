module regfile32x64_tb;
	// create registers for holding the simulated input values to the DUT
	reg [4:0]SA, SB, DA;
	reg [63:0]D;
	reg W, reset, clock;
	// create wires for the output of the DUT
	wire [63:0]A, B;
	
regfile32x64 dut (.rdDataA(A), .rdDataB(B), .rdAddrA(SA), .rdAddrB(SB), .wrData(D), .wrAddr(DA), .write(W), .reset(reset), .clk(clock));

initial begin
	reset = 1'b1;
	write = 1'b0;
	wrAddr = 3'b0;
	wrData = 16'b0;
	#100;
	reset = 1'b0;
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
