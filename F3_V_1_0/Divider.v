module Divider(input wire sysclk,
input wire [5:0] Scale,
output wire Slow_clk);
reg [5:0] count = 0;
assign Slow_clk = (|count == 0);
always @(posedge sysclk) begin
	if (count == (Scale- 6'b1))
		count <= 6'b0;
	else
	count <= count + 1'b1;
end
endmodule