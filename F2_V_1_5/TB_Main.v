//TB_Divider.v
//`include"Divider.v"
`timescale 1ns / 1ns
module TB_Main;
reg [3:0] Enable_SW;
reg reset;
reg Bt_Plus;
reg Bt_Minus;
wire Slow_wave_Sine;
wire Slow_wave_Saw;
wire Slow_wave_Tri;
wire Slow_wave_Square;
reg clock;

Main UUT(
.Slow_wave_Sine(Slow_wave_Sine),
.Slow_wave_Saw(Slow_wave_Saw),
.Slow_wave_Tri(Slow_wave_Tri),
.Slow_wave_Square(Slow_wave_Square),
.Enable_SW(Enable_SW),
.sysclk(clock),
.reset(reset),
.Bt_Minus(Bt_Minus),
.Bt_Plus(Bt_Plus));

initial begin: clockdef // clock definition block (only useful for synchroniser)
	clock = 1'b1;
	forever #10 clock=~clock; //the clock flips every 5ns
end

initial begin
   $dumpfile("Main.vcd");
   $dumpvars();
end

initial begin: stopat
   #500000000; $finish;
end

initial begin: signals
	reset=0;
	Bt_Plus=0;
	Bt_Minus=0;
	Enable_SW[0]=1;
	Enable_SW[1]=1;
	Enable_SW[2]=1;
	Enable_SW[3]=1;
	
	#1 reset = 1'b1;
	#30 reset = 1'b0;

	#200 Bt_Plus= 1'b1;
	#130000000 Bt_Plus = 1'b0;
		
	#10000 Bt_Minus = 1'b1;
	#130000000 Bt_Minus = 1'b0;
		
	#10000 Bt_Plus = 1'b1;
	#130000000 Bt_Plus=1'b0;
				
	//#1; $finish;  // terminates simulation
end
endmodule