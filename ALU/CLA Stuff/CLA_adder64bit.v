module CLA_adder64bit(
	input Cin,
	input [63:0] A, B, 
	output [63:0] S,
	output Cout);


wire [15:0] Carry;

//create 4 bit adders (64 bits required, 64/4 = 16 modules required
CLA_adder4bit nibble0
(.Cin(Cin),     .A(A[3:0]),   .B(B[3:0]),   .S(S[3:0]),    .Cout(Carry[0]));
CLA_adder4bit nibble1
(.Cin(Carry[0]), .A(A[7:4]),   .B(B[7:4]),   .S(S[7:4]),    .Cout(Carry[1]));
CLA_adder4bit nibble2
(.Cin(Carry[1]), .A(A[11:8]),  .B(B[11:8]),  .S(S[11:8]),   .Cout(Carry[2]));
CLA_adder4bit nibble3
(.Cin(Carry[2]), .A(A[15:12]), .B(B[15:12]), .S(S[15:12]), .Cout(Carry[3]));
CLA_adder4bit nibble4
(.Cin(Carry[3]), .A(A[19:16]), .B(B[19:16]), .S(S[19:16]), .Cout(Carry[4]));
CLA_adder4bit nibble5
(.Cin(Carry[4]), .A(A[23:20]), .B(B[23:20]), .S(S[23:20]), .Cout(Carry[5]));
CLA_adder4bit nibble6
(.Cin(Carry[5]), .A(A[27:24]), .B(B[27:24]), .S(S[27:24]), .Cout(Carry[6]));
CLA_adder4bit nibble7
(.Cin(Carry[6]), .A(A[31:28]), .B(B[31:28]), .S(S[31:28]), .Cout(Carry[7]));
CLA_adder4bit nibble8
(.Cin(Carry[7]), .A(A[35:32]), .B(B[35:32]), .S(S[35:32]), .Cout(Carry[8]));
CLA_adder4bit nibble9
(.Cin(Carry[8]), .A(A[39:36]), .B(B[39:36]), .S(S[39:36]), .Cout(Carry[9]));
CLA_adder4bit nibble10
(.Cin(Carry[9]), .A(A[43:40]), .B(B[43:40]), .S(S[43:40]), .Cout(Carry[10]));
CLA_adder4bit nibble11
(.Cin(Carry[10]),.A(A[47:44]), .B(B[47:44]), .S(S[47:44]), .Cout(Carry[11]));
CLA_adder4bit nibble12
(.Cin(Carry[11]),.A(A[51:48]), .B(B[51:48]), .S(S[51:48]), .Cout(Carry[12]));
CLA_adder4bit nibble13
(.Cin(Carry[12]),.A(A[55:52]), .B(B[55:52]), .S(S[55:52]), .Cout(Carry[13]));
CLA_adder4bit nibble14
(.Cin(Carry[13]),.A(A[59:56]), .B(B[59:56]), .S(S[59:56]), .Cout(Carry[14]));
CLA_adder4bit nibble15
(.Cin(Carry[14]),.A(A[63:60]), .B(B[63:60]), .S(S[63:60]), .Cout(Carry[15]));
					
assign Cout = Carry[15];



/////////////////////////////////////////////////////////////////////////////
//
// WIP - Using multiple levels of CLA logic instead of cascading 4-bit adders
//
/////////////////////////////////////////////////////////////////////////////


endmodule
				
