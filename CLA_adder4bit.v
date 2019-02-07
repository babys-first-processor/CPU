module CLA_adder4bit(
	input Cin, 
	input [3:0] A,
	input [3:0] B,
	output [3:0] S,
	output  Cout);


wire [3:0] G, P, C;

	assign G = A & B; //generate when A and B are high, regardless of carry from previous bit
	assign P = A ^ B; //propogate when carry bit and either A or B is high, aka xor
	
	assign C[0] = G[0] | (P[0]&Cin);
	assign C[1] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&Cin);
	assign C[2] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin);
	assign C[3] = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin);
	
	assign S[0] = P[0] ^ Cin;
	assign S[3:1] = P[3:1] ^ C[2:0];
	assign Cout = C[3];



endmodule
