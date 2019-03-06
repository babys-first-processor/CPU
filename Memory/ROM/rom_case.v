module rom_case(out, address);
output reg[15:0] out;
input [7:0] address;

always @(address)
	begin
		case (address)
			8'h00: out = 16'b0000111100001111; 
			8'h01: out = 16'b1111000011110000;
			8'h02: out = 16'b0011001100110011;
			8'h03: out = 16'b1100110011001100;
			8'h04: out = 16'b0101010101010101;
			8'h05: out = 16'b1010101010101010;
			//...
			8'hFD: out = 16'b0000000011111111;
			8'hFE: out = 16'b1111111100000000;
			8'hFF: out = 16'b1111111111111111;
			default: out = 16'b0000000000000000;
		endcase
	end
endmodule

			
			