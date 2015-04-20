//`include"Panta_Debounce.v"
//`include"Move.v"
//`include"Storage.v"
//`include"PWM_XY.v"
module Main_F4 (input wire sysclk,
input wire Bt_Up,
input wire Bt_Down,
input wire Bt_Left,
input wire Bt_Right,
input wire Reset_SW,
input wire Storage_SW,
input wire reset, 
output wire Pulse_X,
output wire Pulse_Y);

wire Up_deb, Down_deb, Left_deb , Right_deb;
wire [5:0] Duty_X;
wire [5:0] Duty_Y;
wire [5:0] DC_X;// output from Storage
wire [5:0] DC_Y;//output form Storage

Quad_Debounce Quad_Deb (.X0(Bt_Up),.X1(Bt_Down),.X2(Bt_Left),.X3(Bt_Right),
.reset(reset),.X0_deb(Up_deb),.X1_deb(Down_deb),.X2_deb(Left_deb),.X3_deb(Right_deb),
.sysclk(sysclk));

Move Move (.Bt_Up(Up_deb),.Bt_Down(Down_deb),.Bt_Left(Left_deb),.Bt_Right(Right_deb),
.Duty_X(Duty_X),.Duty_Y(Duty_Y));

Storage Storage (.Bt_Up(Up_deb),.Bt_Down(Down_deb),.Bt_Left(Left_deb),.Bt_Right(Right_deb),
.Storage_SW(Storage_SW),.sysclk(sysclk),.Duty_X(Duty_X),.Duty_Y(Duty_Y),
.Reset_SW(Reset_SW),.DC_X(DC_X),.DC_Y(DC_Y));

PWM_XY PWM_Duo(.sysclk(sysclk),.Duty_X(DC_X),.Duty_Y(DC_Y),.Pulse_X(Pulse_X),.Pulse_Y(Pulse_Y));
endmodule