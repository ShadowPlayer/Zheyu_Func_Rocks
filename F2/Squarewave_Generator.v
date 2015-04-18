module Squarewave_Generator(input wire sysclk,
input wire Enable_SW_3,
input wire [5:0] Scale,
output wire [5:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [5:0] Duty_Cycle = 0;
reg [5:0] Index_Count = 0;	

assign Duty_Output = Duty_Cycle * Enable_SW_3;

always @(posedge sysclk)begin
	count<=count+1'b1;
	if (DC_Index ==  (Scale - 6'b1)) begin
		Index_Count <= Index_Count + 1'b1;
		DC_Index <=1'b0;
		if (Index_Count<6'd32)begin
			Duty_Cycle <= 6'd63; 
		end else if (Index_Count<7'd64 & 6'd31<Index_Count)begin
			Duty_Cycle <= 6'b0;
		end
	end else begin 
		if (&count==1)
			DC_Index<=DC_Index+1'b1;
	end
end
endmodule