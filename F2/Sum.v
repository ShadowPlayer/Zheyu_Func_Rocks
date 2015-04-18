//`include"Sinewave_Generator.v"
//`include"Sawwave_Generator.v"
//`include"Triwave_Generator.v"
//`include"Squarewave_Generator.v"

module Sum (input wire Local_clk,
input wire [3:0] Enable_SW,
output wire Pulse);
//define automatic clipping factors
reg [2:0] Clip_Factor;
reg [5:0] count = 0;
wire [6:0] Duty_Output_Sine;
wire [6:0] Duty_Output_Tri;
wire [6:0] Duty_Output_Saw;
wire [6:0] Duty_Output_Square;
wire [6:0] Duty_Sum;

assign Pulse =(count < Duty_Sum);

always @(Enable_SW)begin
	case(Enable_SW)
		4'd3,4'd5,4'd6,4'd9,4'd10,4'd12: Clip_Factor=3'd2;
		4'd7,4'd11,4'd13,4'd14,4'd15: Clip_Factor=3'd4;
		default: Clip_Factor=3'd1;
	endcase
	if (Clip_Factor > 1'd1) begin
	Duty_Sum = (Duty_Output_Sine + Duty_Output_Saw + Duty_Output_Square + Duty_Output_Tri)/Clip_Factor;
	end else begin
	Duty_Sum = (Duty_Output_Sine + Duty_Output_Saw + Duty_Output_Square + Duty_Output_Tri);
	end
end



always @(posedge Local_clk) begin
	count<=count+1'b1;	
	end
	
Sinewave_Generator Slow_Sine(.sysclk(Local_clk),.Enable_SW_0(Enable_SW[0]),
.Duty_Output(Duty_Output_Sine));

Sawwave_Generator Slow_Saw(.sysclk(Local_clk),.Enable_SW_1(Enable_SW[1]),
.Duty_Output(Duty_Output_Saw));

Triwave_Generator Slow_Tri(.sysclk(Local_clk),.Enable_SW_2(Enable_SW[2]),
.Duty_Output(Duty_Output_Tri));

Squarewave_Generator Slow_Square(.sysclk(Local_clk),.Enable_SW_3(Enable_SW[3]),
.Duty_Output(Duty_Output_Square));



endmodule