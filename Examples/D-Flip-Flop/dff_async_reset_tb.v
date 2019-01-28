module dff_async_reset_tb;
wire q;
reg data, reset;
reg clk, enable;

dff_async_reset uut (.data(data), .clk(clk), .enable(enable), .reset(reset), .q(q));

initial begin
$timeformat(-9, 1, "ns", 6); #1;
clk = 1'b0;
data = 1'b0;
enable = 1'b1;
reset = 1'b1; //active low reset
#9
enable = 1'b0;
data = 1'b1;
#10;
enable = 1'b1;
#5;
data = 1'b0;
#5;
enable = 1'b0;
#10;
data = 1'b1;
#5;
enable = 1'b1;
#5;
enable = 1'b0;
#5;
data = 1'b0;
#5;
reset = 1'b0;
#5;
reset = 1'b1;
#10 $stop;
end

always 
#1 clk = !clk; //clock cycle is 2 ps

always @(data or enable or reset)
	$display("t=%t enable=%b data=%b reset=%b q=%b", $time, enable, data, reset, q);
	
endmodule
