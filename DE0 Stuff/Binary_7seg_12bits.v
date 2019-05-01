module Binary_7seg_12bits(
	input [11:0] in, //12 bit input
	output [27:0] out); //4 displays x 7 segments = 28 bit output


wire [15:0] bcd;

BCDEncoder BinaryToBCD(.bin(in), .bcd(bcd));

BCD_7seg Thousands(.in(bcd[15:12]), .out(out[27:21]));
BCD_7seg Hundreds(.in(bcd[11:8]), .out(out[20:14]));
BCD_7seg Tens(.in(bcd[7:4]), .out(out[13:7]));
BCD_7seg Ones(.in(bcd[3:0]), .out(out[6:0]));

endmodule
