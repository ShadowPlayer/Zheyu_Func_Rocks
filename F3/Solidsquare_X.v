module Solidsquare_X(input wire sysclk,
input wire Enable_SW_3,
output wire Pulse);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [6:0] Duty_Cycle = 0;

assign Pulse = (Count < Duty_Cycle) * Enable_SW_3;

always @(posedge sysclk)begin
	count<=count+1'b1;
	if (&count==1)
		DC_Index<=DC_Index+1'b1;	
	end
always @ (DC_Index)begin
	if (DC_Index<6'd32)begin
		Duty_Cycle <= 7'd64; // 64 making the Pulse determination block can achieve 100% i.e. == 63 
	end else begin	
		Duty_Cycle <= 6'b0;
	end
	end
endmodule