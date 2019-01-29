module regfile32x64_testbench;
	// create registers for holding the simulated input values to the DUT
	reg [4:0]SA, SB, DA;
	reg [63:0]D;
	reg W, reset, clock;
	// create wires for the output of the DUT
	wire [63:0]A, B;
	
	regfile32x64 dut (.rdDataA(A), .rdDataB(B), .rdAddrA(SA), .rdAddrB(SB), .wrData(D), .wrAddr(DA), .write(W), .reset(reset), .clk(clock));
	
	// give all inputs initial values
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		D <= 64'b0;
		W <= 1'b1;
		DA <= 5'd31; // write to register 0 first since D will be incremented before first clock
		SA <= 5'd30; // read from register 31 first on A bus
		SB <= 5'd29; // read from register 30 first on B bus
		#5 reset <= 1'b0; // delay 5 ticks then turn reset off
		#320 W <= 1'b0; // delay 320 ticks then turn write off
		#320 $stop; // delay another 320 ticks then stop the simulation
	end
	
	// simulate clock with period of 10 ticks
	always
		#5 clock <= ~clock;
		
	// every 10 ticks generate random data and increment SA, SB, and DA
	always begin
		#5 D <= {$random, $random}; // $random is a system command that generates a 32 random number
		DA <= DA + 5'b1;
		SA <= SA + 5'b1;
		SB <= SB + 5'b1;
		#5 ;
	end
	
	// create wires for each register in the dut then connect them accordingly so they
	// show up on the wave view in ModelSim automatically
	wire [63:0]R00, R01, R02, R03, R04, R05, R06, R07, R08, R09;
	wire [63:0]R10, R11, R12, R13, R14, R15, R16, R17, R18, R19;
	wire [63:0]R20, R21, R22, R23, R24, R25, R26, R27, R28, R29;
	wire [63:0]R30, R31;
	
	assign R00 = dut.Q0;
	assign R01 = dut.Q1;
	assign R02 = dut.Q2;
	assign R03 = dut.Q3;
	assign R04 = dut.Q4;
	assign R05 = dut.Q5;
	assign R06 = dut.Q6;
	assign R07 = dut.Q7;
	assign R08 = dut.Q8;
	assign R09 = dut.Q9;
	assign R10 = dut.Q10;
	assign R11 = dut.Q11;
	assign R12 = dut.Q12;
	assign R13 = dut.Q12;
	assign R14 = dut.Q14;
	assign R15 = dut.Q15;
	assign R16 = dut.Q16;
	assign R17 = dut.Q17;
	assign R18 = dut.Q18;
	assign R19 = dut.Q19;
	assign R20 = dut.Q20;
	assign R21 = dut.Q21;
	assign R22 = dut.Q22;
	assign R23 = dut.Q23;
	assign R24 = dut.Q24;
	assign R25 = dut.Q25;
	assign R26 = dut.Q26;
	assign R27 = dut.Q27;
	assign R28 = dut.Q28;
	assign R29 = dut.Q29;
	assign R30 = dut.Q30;
	assign R31 = dut.Q31;
	
endmodule
