module rom_case_testbench; //module name
reg [7:0] address; //address select, 8 bits is 256 deep.
wire [15:0] out; //output bus, 16 bit words.

rom_case dut(.out(out), .address(address)); //instantiate dut

always #10 address = address + 1'b1; //runs every 10 clocks, adds 1 to address. 

initial begin //runs on launch
	address = 8'b0; //start address at 0
	#2560; //256 memory locations x 10 clocks each.
	$stop; //end simulation after each location is tested.
end //initial block
endmodule //end rom_case_testbench
