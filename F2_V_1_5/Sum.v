module Sum (input wire Local_clk,
input wire [3:0] Enable_SW,
output wire Pulse);
//define automatic clipping factors
wire [2:0] Clip_Factor;
case(Enable_SW)
  4'd3,4'd5,4'd6,4'd9,4'd10,4'd12: Clip_Factor=3'd2;
  4'd7,4'd11,4'd13,4'd14,4'd15: Clip_Factor=3'd4;
  default: Clip_Factor=3'd1;
endcase
assign Pulse = (count < Duty_Cycle)