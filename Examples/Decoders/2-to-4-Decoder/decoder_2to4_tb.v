module decoder_2to4_tb;
wire Y3, Y2, Y1, Y0;
reg A, B; reg en;
decoder_2to4 DUT (.Y3(Y3), .Y2(Y2), .Y1(Y1), .Y0(Y0), .A(A), .B(B), .en(en));
initial
begin
$timeformat (-9, 1, "ns", 6); #1;
	A = 1'b0;
	B = 1'b0;
	en = 1'b0;
	#9;
	en = 1'b1;
	#10
	A=1'b0;
	B=1'b1;
	#10
	A=1'b1;
	B=1'b0;
	#10
	A=1'b1;
	B=1'b1;
	#5;
	en = 1'b0;
	#5; 
end
always @(A or B or en)
	#1 $display("t=%t", $time, "en=%b", en, "A=%b", A, "B=%b", B, "Y=%b%b%b%b", Y3, Y2, Y1, Y0);
endmodule
