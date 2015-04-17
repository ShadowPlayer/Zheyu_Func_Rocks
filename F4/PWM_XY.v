module PWM_Generator(input wire sysclk,
input wire [5:0] Duty_X,
input wire [5:0] Duty_Y,
output wire Pulse_X,
output wire Pulse_Y);

reg [5:0] count = 0;

assign Pulse_X = (count < Duty_X);
assign Pulse_Y = (count < Duty_Y);

always @(posedge sysclk)
		count<=count+1'b1;
endmodule