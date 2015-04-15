//TB_Squarewave_Generator.v
//`include"Squarewave_Generator.v"
`timescale 1ns / 1ns
module TB_Squarewave_Generator;
wire Pulse;
reg Enable_SW_3;
reg clock;

Squarewave_Generator UUT(
.Pulse(Pulse),
.sysclk(clock),
.Enable_SW_3(Enable_SW_3));

initial begin: clockdef // clock definition block (only useful for synchroniser)
	clock = 1'b1;
	forever #10 clock=~clock; //the clock flips every 5ns
end

initial begin
   $dumpfile("Squarewave_Generator.vcd");
   $dumpvars(Pulse);
end

initial begin: stopat
   #5000000; $finish;
end
initial begin: signals
	Enable_SW_3 = 1;
   #2000 Enable_SW_3=0;
   #8000 Enable_SW_3=1;
   #10000 Enable_SW_3=0;
   #12000 Enable_SW_3= 1;
end

endmodule