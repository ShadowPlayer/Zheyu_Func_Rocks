`include"Circle_X.v"
`include"Circle_Y.v"
`include"Eight_X.v"
`include"Eight_Y.v"
`include"Square_X.v"
`include"Square_Y.v"
`include"Solidsquare_X.v"
`include"Solidsquare_Y.v"
module Shape_Pulse( input wire sysclk,
input wire [3:0] Enable_SW
output wire Pulse_X,
output wire Pulse_Y);

wire Circle_X;
wire Circle_Y;
wire Eight_X;
wire Eight_Y;
wire Square_X;
wire Square_Y;
wire Solidsquare_X;
wire Solidsquare_Y;
wire Output_X;
wire Output_Y;

assign Pulse_X = Output_X;
assign Pulse_Y = Output_Y;

always @ (*)begin
	case (En_switch)
	
