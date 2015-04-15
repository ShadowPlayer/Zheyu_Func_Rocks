//TB_Triwave_Generator.v
//`include"Triwave_Generator.v"
`timescale 1ns / 1ns
module TB_Triwave_Generator;
wire Pulse;
reg Enable_SW_2;
reg clock;

Triwave_Generator UUT(
.Pulse(Pulse),
.Enable_SW_2(Enable_SW_2),
.sysclk(clock));

initial begin: clockdef // clock definition block (only useful for synchroniser)
	clock = 1'b1;
	forever #10 clock=~clock; //the clock flips every 5ns
end

initial begin
   $dumpfile("Triwave_Generator.vcd");
   $dumpvars(Pulse);
end

initial begin: stopat
   #500000; $finish;
end

initial begin: signals
	Enable_SW_2 = 1;
end

endmodule