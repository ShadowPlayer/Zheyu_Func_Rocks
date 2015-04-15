`include"Frequency_Adj.v"//Finding Frequency Scale
`include"Divider.v"//frequency modulation 
//waveforms
`include"Sinewave_Generator.v"
`include"Sawwave_Generator.v"
`include"Triwave_Generator.v"
`include"Squarewave_Generator.v"
//doubledebouncer
`include"doubledebounce.v"
module Main (input wire sysclk,
input wire [3:0] Enable_SW,
input wire reset,
input wire Bt_Plus,
input wire Bt_Minus,
output wire Slow_wave_Sine,
output wire	Slow_wave_Saw,
output wire	Slow_wave_Tri,
output wire Slow_wave_Square);

// Variables
wire Slow_clk;//divider output
//debouncer output
wire Plus_deb;
wire Minus_deb;
//Frequency_Adj output, Waveforms' input
wire [5:0] Scale;

//Sub modules
// Button Debounce
doubledebounce DB (.X0(Bt_Plus),.X1(Bt_Minus),.reset(reset),.X0_deb(Plus_deb),
.X1_deb(Minus_deb),.sysclk(sysclk));
//Frequency Adjustment
Frequency_Adj Fq_Adj (.sysclk(sysclk),.Plus(Plus_deb),.Minus(Minus_deb),
.Scale(Scale));
//Frequency divider.
Divider Div(.Slow_clk(Slow_clk),
 .Scale(Scale),.sysclk(sysclk));// get a slowed lock 
//Waveforms Generator.
Sinewave_Generator Slow_Sine(.sysclk(Slow_clk),.Enable_SW_0(Enable_SW[0]),.Pulse(Slow_wave_Sine));

Sawwave_Generator Slow_Saw(.sysclk(Slow_clk),.Enable_SW_1(Enable_SW[1]),.Pulse(Slow_wave_Saw));

Triwave_Generator Slow_Tri(.sysclk(Slow_clk),.Enable_SW_2(Enable_SW[2]),.Pulse(Slow_wave_Tri));

Squarewave_Generator Slow_Square(.sysclk(Slow_clk),.Enable_SW_3(Enable_SW[3]),.Pulse(Slow_wave_Square));

endmodule