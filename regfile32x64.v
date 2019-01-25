module regfile32x64(
	input clk, 
	input write,
	input [4:0] wrAddr,
   input [63:0] wrData,
   input [4:0] rdAddrA,
   output [63:0] rdDataA,
   input [4:0] rdAddrB,
   output [63:0] rdDataB);
 
reg[63:0] reg0,  reg1,  reg2,  reg3,  reg4,  reg5,  reg6,  reg7,
			 reg8,  reg9,  reg10, reg11, reg12, reg13, reg14, reg15,
			 reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, 
			 reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31; //address is from 5'h00 to 5'h1F
			 
assign rdDataA = rdAddrA == 0  ? reg0  :
					  rdAddrA == 1  ? reg1  :
					  rdAddrA == 2  ? reg2  :
					  rdAddrA == 3  ? reg3  :
					  rdAddrA == 4  ? reg4  :
					  rdAddrA == 5  ? reg5  :
					  rdAddrA == 6  ? reg6  :
					  rdAddrA == 7  ? reg7  :
					  rdAddrA == 8  ? reg8  :
					  rdAddrA == 9  ? reg9  :
					  rdAddrA == 10 ? reg10 :
					  rdAddrA == 11 ? reg11 :
					  rdAddrA == 12 ? reg12 :
					  rdAddrA == 13 ? reg13 :
					  rdAddrA == 14 ? reg14 :
					  rdAddrA == 15 ? reg15 :
					  rdAddrA == 16 ? reg16 :
					  rdAddrA == 17 ? reg17 :
					  rdAddrA == 18 ? reg18 :
					  rdAddrA == 19 ? reg19 :
					  rdAddrA == 20 ? reg20 :
					  rdAddrA == 21 ? reg21 :
					  rdAddrA == 22 ? reg22 :
					  rdAddrA == 23 ? reg23 :
					  rdAddrA == 24 ? reg24 :
					  rdAddrA == 25 ? reg25 :
					  rdAddrA == 26 ? reg26 :
					  rdAddrA == 27 ? reg27 :
					  rdAddrA == 28 ? reg28 :
					  rdAddrA == 29 ? reg29 :
					  rdAddrA == 30 ? reg30 :
					  rdAddrA == 31 ? reg31 : 0;
assign rdDataB = rdAddrB == 0  ? reg0  :
					  rdAddrB == 1  ? reg1  :
					  rdAddrB == 2  ? reg2  :
					  rdAddrB == 3  ? reg3  :
					  rdAddrB == 4  ? reg4  :
					  rdAddrB == 5  ? reg5  :
					  rdAddrB == 6  ? reg6  :
					  rdAddrB == 7  ? reg7  :
					  rdAddrB == 8  ? reg8  :
					  rdAddrB == 9  ? reg9  :
					  rdAddrB == 10 ? reg10 :
					  rdAddrB == 11 ? reg11 :
					  rdAddrB == 12 ? reg12 :
					  rdAddrB == 13 ? reg13 :
					  rdAddrB == 14 ? reg14 :
					  rdAddrB == 15 ? reg15 :
					  rdAddrB == 16 ? reg16 :
					  rdAddrB == 17 ? reg17 :
					  rdAddrB == 18 ? reg18 :
					  rdAddrB == 19 ? reg19 :
					  rdAddrB == 20 ? reg20 :
					  rdAddrB == 21 ? reg21 :
					  rdAddrB == 22 ? reg22 :
					  rdAddrB == 23 ? reg23 :
					  rdAddrB == 24 ? reg24 :
					  rdAddrB == 25 ? reg25 :
					  rdAddrB == 26 ? reg26 :
					  rdAddrB == 27 ? reg27 :
					  rdAddrB == 28 ? reg28 :
					  rdAddrB == 29 ? reg29 :
					  rdAddrB == 30 ? reg30 :
					  rdAddrB == 31 ? reg31 : 0;
 
always @(posedge clk) begin
	if (write)
		case(wrAddr)
			0: begin
				reg0 <= wrData;
			end
			1: begin
				reg1 <= wrData;
			end
			2: begin
				reg2 <= wrData;
			end
			3: begin
				reg3 <= wrData;
			end
			4: begin
				reg4 <= wrData;
			end
			5: begin
				reg5 <= wrData;
			end
			6: begin
				reg6 <= wrData;
			end
			7: begin
				reg7 <= wrData;
			end
			8: begin
				reg8 <= wrData;
			end
			9: begin
				reg9 <= wrData;
			end
			10: begin
				reg10 <= wrData;
			end
			11: begin
				reg11 <= wrData;
			end
			12: begin
				reg12 <= wrData;
			end
			13: begin
				reg13 <= wrData;
			end
			14: begin
				reg14 <= wrData;
			end
			15: begin
				reg15 <= wrData;
			end
			16: begin
				reg16 <= wrData;
			end
			17: begin
				reg17 <= wrData;
			end
			18: begin
				reg18 <= wrData;
			end
			19: begin
				reg19 <= wrData;
			end
			20: begin
				reg20 <= wrData;
			end
			21: begin
				reg21 <= wrData;
			end
			22: begin
				reg22 <= wrData;
			end
			23: begin
				reg23 <= wrData;
			end
			24: begin
				reg24 <= wrData;
			end
			25: begin
				reg25 <= wrData;
			end
			26: begin
				reg26 <= wrData;
			end
			27: begin
				reg27 <= wrData;
			end
			28: begin
				reg28 <= wrData;
			end
			29: begin
				reg29 <= wrData;
			end
			30: begin
				reg30 <= wrData;
			end
			31: begin
				reg31 <= wrData;
			end
		endcase
	end
endmodule
