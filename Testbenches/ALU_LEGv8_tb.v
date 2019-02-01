module ALU_LEGv8_tb;
	reg [63:0] A, B;
	reg [4:0] FS;
	reg C0;
	wire [63:0] F;
	wire [3:0] status;
	
	ALU_LEGv8 dut (A, B, FS, C0, F, status);
	
	
	initial begin
		FS <= 5'b00000; // A AND B
		A <= 64'b110;
		B <= 64'b011;
		#5 
		FS <= 5'b00100; // A OR B
		#5 
		FS <= 5'b01000; // A + B
		C0 <= 1'b0;
		#5 FS <= 5'b01100; // A XOR B
		#5 FS <= 5'b00011; // ~A AND ~B = A NOR B
		#5 FS <= 5'b00111; // ~A OR ~B = A NAND B
		#5 FS <= 5'b10000; // shift left
		#5 FS <= 5'b10100; // shift right
		#5 A <= 64'h8000000000000000;
		#5 $stop;
	end
endmodule