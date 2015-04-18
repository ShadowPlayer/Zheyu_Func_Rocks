module Sawwave_Generator(input wire sysclk,
input wire Enable_SW_1,
output wire [6:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] Duty_Cycle = 0;

assign Duty_Output = Duty_Cycle * Enable_SW_1;

always @(posedge sysclk)begin
	count<=count+1'b1;	
	if (&count==1)
		Duty_Cycle<=Duty_Cycle+1'b1;
	end
endmodule