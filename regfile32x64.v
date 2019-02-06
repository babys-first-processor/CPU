module regfile32x64(
	input clk,
	input write,
	input reset,
	input [4:0] wrAddr,
	input [63:0] wrData,
   input [4:0] rdAddrA,
   output [63:0] rdDataA,
   input [4:0] rdAddrB,
   output [63:0] rdDataB);

/*
wire [31:0] m; //decoder output
wire [63:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,
				Q8, Q9, Q10,Q11,Q12,Q13,Q14,Q15,
				Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,
				Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31;


Decoder5to32 DAddress(.S(wrAddr), .m(m));

Mux32to1Nbit #(64) MuxA(.F(rdDataA), .S(rdAddrA), .I00(Q0),  .I01(Q1),  .I02(Q2),  .I03(Q3), .I04(Q4),  .I05(Q5),  .I06(Q6),  .I07(Q7),
																  .I08(Q8),  .I09(Q9),  .I10(Q10), .I11(Q11),.I12(Q12), .I13(Q13), .I14(Q14), .I15(Q15),
																  .I16(Q16), .I17(Q17), .I18(Q18), .I19(Q19),.I20(Q20), .I21(Q21), .I22(Q22), .I23(Q23),
																  .I24(Q24), .I25(Q25), .I26(Q26), .I27(Q27),.I28(Q28), .I29(Q29), .I30(Q30), .I31(Q31));
																  
Mux32to1Nbit #(64) MuxB(.F(rdDataB), .S(rdAddrB), .I00(Q0),  .I01(Q1),  .I02(Q2),  .I03(Q3), .I04(Q4),  .I05(Q5),  .I06(Q6),  .I07(Q7),
																  .I08(Q8),  .I09(Q9),  .I10(Q10), .I11(Q11),.I12(Q12), .I13(Q13), .I14(Q14), .I15(Q15),
																  .I16(Q16), .I17(Q17), .I18(Q18), .I19(Q19),.I20(Q20), .I21(Q21), .I22(Q22), .I23(Q23),
																  .I24(Q24), .I25(Q25), .I26(Q26), .I27(Q27),.I28(Q28), .I29(Q29), .I30(Q30), .I31(Q31));


RegisterNbit #(64) reg0(.Q(Q0),  .D(wrData), .L(m[0] & write),  .R(reset), .clock(clk));
RegisterNbit #(64) reg1(.Q(Q1),  .D(wrData), .L(m[1] & write),  .R(reset), .clock(clk));  
RegisterNbit #(64) reg2(.Q(Q2),  .D(wrData), .L(m[2] & write),  .R(reset), .clock(clk)); 
RegisterNbit #(64) reg3(.Q(Q3),  .D(wrData), .L(m[3] & write),  .R(reset), .clock(clk));  
RegisterNbit #(64) reg4(.Q(Q4),  .D(wrData), .L(m[4] & write),  .R(reset), .clock(clk)); 
RegisterNbit #(64) reg5(.Q(Q5),  .D(wrData), .L(m[5] & write),  .R(reset), .clock(clk));  
RegisterNbit #(64) reg6(.Q(Q6),  .D(wrData), .L(m[6] & write),  .R(reset), .clock(clk)); 
RegisterNbit #(64) reg7(.Q(Q7),  .D(wrData), .L(m[7] & write),  .R(reset), .clock(clk));
RegisterNbit #(64) reg8(.Q(Q8),  .D(wrData), .L(m[8] & write),  .R(reset), .clock(clk)); 
RegisterNbit #(64) reg9(.Q(Q9),  .D(wrData), .L(m[9] & write),  .R(reset), .clock(clk));  
RegisterNbit #(64) reg10(.Q(Q10),.D(wrData), .L(m[10] & write), .R(reset), .clock(clk));
RegisterNbit #(64) reg11(.Q(Q11),.D(wrData), .L(m[11] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg12(.Q(Q12),.D(wrData), .L(m[12] & write), .R(reset), .clock(clk));
RegisterNbit #(64) reg13(.Q(Q13),.D(wrData), .L(m[13] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg14(.Q(Q14),.D(wrData), .L(m[14] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg15(.Q(Q15),.D(wrData), .L(m[15] & write), .R(reset), .clock(clk));
RegisterNbit #(64) reg16(.Q(Q16),.D(wrData), .L(m[16] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg17(.Q(Q17),.D(wrData), .L(m[17] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg18(.Q(Q18),.D(wrData), .L(m[18] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg19(.Q(Q19),.D(wrData), .L(m[19] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg20(.Q(Q20),.D(wrData), .L(m[20] & write), .R(reset), .clock(clk));
RegisterNbit #(64) reg21(.Q(Q21),.D(wrData), .L(m[21] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg22(.Q(Q22),.D(wrData), .L(m[22] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg23(.Q(Q23),.D(wrData), .L(m[23] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg24(.Q(Q24),.D(wrData), .L(m[24] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg25(.Q(Q25),.D(wrData), .L(m[25] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg26(.Q(Q26),.D(wrData), .L(m[26] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg27(.Q(Q27),.D(wrData), .L(m[27] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg28(.Q(Q28),.D(wrData), .L(m[28] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg29(.Q(Q29),.D(wrData), .L(m[29] & write), .R(reset), .clock(clk)); 
RegisterNbit #(64) reg30(.Q(Q30),.D(wrData), .L(m[30] & write), .R(reset), .clock(clk));
RegisterNbit #(64) reg31(.Q(Q31),.D(wrData), .L(m[31] & write), .R(reset), .clock(clk));
						 //address is from 5'h00 to 5'h1F
*/


//behavorial
				 
reg [63:0] reg0, reg1,  reg2, reg3, reg4, reg5, reg6, reg7, 
			  reg8, reg9, reg10,reg11,reg12,reg13,reg14,reg15,
			  reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,
			  reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31;
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


always @(posedge clk or posedge reset) 
	if (reset) begin
		reg0 <= 0; reg1 <= 0; reg2 <= 0; reg3 <= 0;
		reg4 <= 0; reg5 <= 0; reg6 <= 0; reg7 <= 0;
		reg8 <= 0; reg9 <= 0; reg10 <= 0; reg11 <= 0;
		reg12 <= 0; reg13 <= 0; reg14 <= 0; reg15 <= 0;
		reg16 <= 0; reg17 <= 0; reg18 <= 0; reg19 <= 0;
		reg20 <= 0; reg21 <= 0; reg22 <= 0; reg23 <= 0;
		reg24 <= 0; reg25 <= 0; reg26 <= 0; reg27 <= 0;
		reg28 <= 0; reg29 <= 0; reg30 <= 0; reg31 <= 0;
	end else if (write) begin
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
