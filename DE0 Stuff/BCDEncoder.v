module BCDEncoder(bin, bcd);

input [11:0] bin;
output reg[15:0] bcd;
reg [11:0] i;   
     
//Always block - implement the Double Dabble algorithm
always @(bin)
   begin
     bcd = 16'b0; //initialize bcd to zero.
       for (i = 12'd0; i < 12'd12; i = i+12'd1) //run for 12 iterations
         begin
           bcd = {bcd[14:0],bin[11-i]}; //concatenation
                  
           //if a hex digit of 'bcd' is more than 4, add 3 to it.  
             if(i < 6'd11 && bcd[3:0] > 4) 
                bcd[3:0] = bcd[3:0] + 4'd3;
             if(i < 6'd11 && bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 4'd3;
             if(i < 6'd11 && bcd[11:8] > 4)
                bcd[11:8] = bcd[11:8] + 4'd3; 
				 if(i < 6'd11 && bcd[15:12] > 4)
					 bcd[15:12] = bcd[15:12] + 4'd3;
         end
     end     
                
endmodule

// Binary to BCD code from http://verilogcodes.blogspot.com/2015/10/verilog-code-for-8-bit-binary-to-bcd.html
// Maybe could've coded it myself, but this was readily available and now hopefully adequately cited. 