module Triwave_Generator(input wire sysclk,
input wire Enable_SW_2,
input wire [5:0] Scale,
output wire [6:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [6:0] Duty_Cycle = 0;
reg [5:0] Index_Count = 0;	

assign Duty_Output = Duty_Cycle* Enable_SW_2;

always @(posedge sysclk)begin
	count<=count+1'b1;	
	if (&count==1)
		DC_Index<=DC_Index+1'b1;
	end

always @(DC_Index)begin
	if (DC_Index ==  (Scale - 6'b1)) begin
		Index_Count <= Index_Count + 1'b1;
		DC_Index <=1'b0;
	end
end
always @ (Index_Count) begin
	if (6'd0<Index_Count & Index_Count<6'd32)begin
		Duty_Cycle <= Duty_Cycle + 2'd2;
	end else if (Index_Count == 6'd32)begin
		Duty_Cycle <= 6'd62;
	end else if (6'd31<Index_Count & Index_Count<7'd64) begin
		Duty_Cycle <= Duty_Cycle - 2'd2;
	end
end
endmodule