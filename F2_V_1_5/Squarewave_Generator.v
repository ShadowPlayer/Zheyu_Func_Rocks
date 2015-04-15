module Squarewave_Generator(input wire sysclk,
input wire Enable_SW_3,
input wire [2:0]Clip_Factor;
output wire [6:0] Duty_Output);

reg [5:0] count = 0;
reg [5:0] DC_Index = 0;
reg [6:0] Duty_Cycle = 0;

assign Duty_Output = Duty_Cycle & Enable_SW_3;

always @(posedge sysclk)begin
	count<=count+1'b1;
	if (&count==1)
		DC_Index<=DC_Index+1'b1;	
	end
	
always @ (DC_Index)begin
	case (Clip_Factor)
	default:
	if (DC_Index<6'd32)begin
		Duty_Cycle <= 7'd64; // 64 making the Pulse determination block can achieve 100%  
	end else begin	
		Duty_Cycle <= 6'b0;
	end
	3'd2:
	if (DC_Index<6'd32)begin
		Duty_Cycle <= 6'd32; // 32 making the Pulse determination block can achieve 50% 
	end else begin	
		Duty_Cycle <= 6'b0;
	end
	3'd4:
	if (DC_Index<6'd32)begin
		Duty_Cycle <= 6'd16; // 16 making the Pulse determination block can achieve 25% 
	end else begin	
		Duty_Cycle <= 6'b0;
	end
	endcase
	end
endmodule