//TB_Divider.v
//`include"Divider.v"
`timescale 1ns / 1ns
module TB_Main;
reg [3:0] Enable_SW;
reg reset;
reg Bt_Plus;
reg Bt_Minus;
reg clock;
wire Pulse;

Main UUT(.Enable_SW(Enable_SW),
.sysclk(clock),
.reset(reset),
.Bt_Minus(Bt_Minus),
.Bt_Plus(Bt_Plus),
.Pulse(Pulse));

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
	Enable_SW[0]=1;//Sine
	Enable_SW[1]=1;//Saw
	Enable_SW[2]=1;//Tri
	Enable_SW[3]=1;//Squ
	
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