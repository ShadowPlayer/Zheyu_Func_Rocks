//TB_Test.v
//`include"Test_RAM.v"
`timescale 1ns / 1ns
module TB_Test;
reg clock;
wire [5:0] DC_X;


Test_RAM UUT(.DC_X(DC_X),
.sysclk(clock));

initial begin: clockdef // clock definition block (only useful for synchroniser)
	clock = 1'b1;
	forever #10 clock=~clock; //the clock flips every 5ns
end

initial begin
   $dumpfile("Test_RAM.vcd");
   $dumpvars();
end

initial begin: stopat
   #500; $finish;
end

endmodule