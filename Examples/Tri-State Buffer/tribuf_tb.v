module tribuf_tb;

reg in, control;
wire out;

tribuf uut (.in(in), .out(out), .control(control));

initial begin
	control = 1'b1;
	in = 1'b0;
	#5;
	in = 1'b1;
	#5
	in = 1'b0;
	control = 1'b0;
	#5;
	in = 1'b1;
	#5;
	in = 1'b0;
	control = 1'b1;
	#5 $stop;
end
endmodule
