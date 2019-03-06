module CLA_adder16bit(
	input [15:0] A, B,
	input Cin,
	output [15:0] S,
	output Cout);
	
wire [3:0] G, P, C;
CLA_logic CLABlock(.P(P), .G(G), .C(C), .Cin(Cin));


	assign G = A & B; //generate when A and B are high, regardless of carry from previous bit
	assign P = A ^ B; //propogate when carry bit and either A or B is high, aka xor
	
	assign S[0] = P[0] ^ Cin;
	assign S[3:1] = P[3:1] ^ C[2:0];
	assign Cout = C[3];
endmodule