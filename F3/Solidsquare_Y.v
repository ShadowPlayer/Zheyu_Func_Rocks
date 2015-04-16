module Solidsquare_Y(input wire sysclk,
input wire Enable_SW_3,
output wire Pulse);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [5:0] Amp_Index = 0;
reg [6:0] Duty_Cycle = 0;

assign Pulse = (count < Duty_Cycle) * Enable_SW_3;

always @(posedge sysclk)begin
	count<=count+1'b1;
	if (&count==1)
		DC_Index<=DC_Index+1'b1;
	end
	
always @ (DC_Index)begin
	if (&DC_Index==1)
		Amp_Index <= Amp_Index+1'b1;	
	
	if (6'd15 < DC_Index & DC_Index <6'd48)begin
		Duty_Cycle <= Amp_Index; /* 50% duty cycle Square wave with  
		amplitude during each period varying from 0% to approximately 100%*/
	end else begin	
		Duty_Cycle <= 6'b0;
	end
	end
endmodule