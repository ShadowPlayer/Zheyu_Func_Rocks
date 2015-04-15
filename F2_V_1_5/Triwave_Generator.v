module Triwave_Generator(input wire sysclk,
input wire Enable_SW_2,
input wire [2:0] Clip_Factor,
output wire [6:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [6:0] Duty_Cycle = 0;

assign Duty_Output = (Duty_Cycle/Clip_Factor) * Enable_SW_2;

always @(posedge sysclk)begin
	count<=count+1'b1;	
	if (&count==1)
		DC_Index<=DC_Index+1'b1;
	end
	
always @ (DC_Index) begin
	if (6'd0<DC_Index & DC_Index<6'd32)begin
		Duty_Cycle <= Duty_Cycle + 2'd2;
	end else if (DC_Index == 6'd32)begin
		Duty_Cycle <= 6'd62;
	end else if (6'd31<DC_Index & DC_Index<7'd64) begin
		Duty_Cycle <= Duty_Cycle - 2'd2;
	end
end
endmodule