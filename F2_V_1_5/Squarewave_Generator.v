module Squarewave_Generator(input wire sysclk,
input wire Enable_SW_3,
output wire Pulse);
reg [5:0] count = 0;
reg [5:0] Slow_count = 0;
assign Pulse = ~Slow_count[5]&Enable_SW_3;
always @(posedge sysclk)begin
	count<=count+1'b1;
	if (&count==1)
		Slow_count<=Slow_count+1'b1;	
	end
endmodule