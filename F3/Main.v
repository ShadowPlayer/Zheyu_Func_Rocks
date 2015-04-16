`include"Key_Proc.v"
`include"Shape_Pulse.v"
`include"Tripledebounce.v"
module Main (input wire sysclk,
input wire Bt_Next,
input wire Bt_Pre,
input wire Bt_Auto,
input wire reset, 
output wire Pulse_X,
output wire Pulse_Y);

wire Next_deb, Pre_deb, Auto_deb;
reg [3:0] Enable_SW

Tripledebounce TB (.X0(Bt_Next),.X1(Bt_Pre),.X2(Bt_Auto),.reset(reset),
.X0_deb(Next_deb),.X1_deb(Pre_deb),.X2_deb(Auto_deb),.sysclk(sysclk));

Key_Proc KP(.sysclk(sysclk),.Bt_Next(Bt_Next),.Bt_Pre(Bt_Pre),
.Bt_Auto(Bt_Auto),.Enable_SW(Enable_SW));


Shape_Pulse SP (.sysclk(sysclk),.Enable_SW(Enable_SW),.Pulse_X(Pulse_X),
.Pulse_Y(Pulse_Y));

endmodule