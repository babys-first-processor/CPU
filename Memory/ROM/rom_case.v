module rom_case(out, address, oe);
output reg[31:0] out;
input [15:0] address;
input oe;

always @*
	begin
		if (oe) 
			case (address)
				16'h8000: out = 32'b10001001000_000000000111_11111_00010;
				16'h8001: out = 32'b10001001000_000000001110_00010_00011;
				16'h8002: out = 32'b0011001100110011;
				16'h8003: out = 32'b1100110011001100;
				16'h8004: out = 32'b0101010101010101;
				16'h8005: out = 32'b1010101010101010;
				//...
				16'h8FFD: out = 32'b0000000011111111;
				16'h8FFE: out = 32'b1111111100000000;
				16'h8FFF: out = 32'b1111111111111111;
				default: out = 32'b0000000000000000;
				//this should be updated eventually to use .mem files from assembler?
			endcase
		else out <= 32'bz;
		end
endmodule

			
			