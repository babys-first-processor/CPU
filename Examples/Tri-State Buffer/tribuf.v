module tribuf (out, in, control);
	input in, control;
	output out;
	
	assign #2 out = control ? in : 1'bz;
endmodule
