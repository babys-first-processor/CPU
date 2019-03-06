module CLA_logic(
	input [3:0] Pi, //propogate 
	input [3:0] Gi, //generate
	input Cin,
	output [3:0] C);
	//output PG, GG);


assign C[0] = G[0] | (P[0]&Cin);
assign C[1] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&Cin);
assign C[2] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin);
assign C[3] = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin);

assign PG = P[3]&P[2]&P[1]&P[0]; //group propogate
assign GG =  G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]); //group generate
endmodule

	