`include"Panta_Debounce.v"
`include"Move.v"
`include"Storage.v"
`include"PWM_XY.v"
module Main_F4 (input wire sysclk,
input wire Bt_Up,
input wire Bt_Down,
input wire Bt_Left,
input wire Bt_Right,
input wire Bt_Reset,
input wire reset, 
input wire Storage_SW,
output wire Pulse_X,
output wire Pulse_Y);

wire Up_deb, Down_deb, Left_deb , Right_deb, reset_deb;
reg [5:0] Duty_X;
reg [5:0] Duty_Y;
reg [5:0] DC_X;// output from Storage
reg [5:0] DC_Y;//output form Storage

Panta_Debounce Pan_Deb (.X0(Bt_Up),.X1(Bt_Down),.X2(Bt_Left),.X3(Bt_Right),.X4(Bt_Reset),
.reset(reset),.X0_deb(Up_deb),.X1_deb(Down_deb),.X2_deb(Left_deb),.X3_deb(Right_deb),
.X4_deb(Reset_deb),.sysclk(sysclk));

Move Move (.Bt_Up(Up_deb),.Bt_Down(Down_deb),.Bt_Left(Left_deb),.Bt_Right(Right_deb),
.Duty_X(Duty_X),.Duty_Y(Duty_Y));

Storage Storage (.Storage_SW(Storage_SW),.sysclk(sysclk),.Duty_X(Duty_X),.Duty_Y(Duty_Y),
.reset(reset_deb),.DC_X(DC_X),.DC_Y(DC_Y));

PWM_XY PWM_Duo(.sysclk(sysclk),.Duty_X(DC_X),.Duty_Y(DC_Y),Pulse_X(Pulse_X),Pulse_Y(Pulse_Y));
endmodule