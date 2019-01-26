module CLA_adder64bit_tb;

reg [63:0] A, B;
wire [63:0] S;
wire CF;

CLA_adder64bit uut (.A(A), .B(B), .S(S), .CF(CF));

initial begin
	#10;
	A = 64'hFFFF0000FFFF0000;
	B = 64'h00000000FFFFFFFF;
	#10;
	A = 64'hCCCCCCCCCCCCCCCC;
	B = 64'h0111111111111111;
	#10;
	A = 64'hFFFFFFFFFFFFFFFF;
	B = 64'h0000000000000001;
	#10; $stop;
end
endmodule
