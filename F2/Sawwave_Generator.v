module Sawwave_Generator(input wire sysclk,
input wire Enable_SW_1,
input wire [5:0] Scale,
output wire [6:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [5:0] Duty_Cycle = 0;
reg [5:0] Index_Count = 0;	

assign Duty_Output = Duty_Cycle * Enable_SW_1;

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

always @ (Index_Count)begin
	Duty_Cycle<=Duty_Cycle+1'b1;
end

endmodule


