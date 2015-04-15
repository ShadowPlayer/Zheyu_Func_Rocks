//TB_Sinewave_Generator.v
//`include"Sinewave_Generator.v"
`timescale 1ns / 1ns
module TB_Sinewave_Generator;
wire Pulse;
reg clock;
reg Enable_SW_0;

Sinewave_Generator UUT(
.Pulse(Pulse),
.sysclk(clock),
.Enable_SW_0(Enable_SW_0));

initial begin: clockdef // clock definition block (only useful for synchroniser)
	clock = 1'b1;
	forever #10 clock=~clock; //the clock flips every 5ns
end

initial begin
   $dumpfile("Sinewave_Generator.vcd");
   $dumpvars(Pulse);
end

initial begin: stopat
   #500000; $finish;
end

initial begin: signals
	Enable_SW_0 = 1;
   #20000 Enable_SW_0=0;
   #80000 Enable_SW_0=1;
end
endmodule