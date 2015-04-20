module Function_Switching (input wire [3:0] SW,
	input wire Bt_Up,
	input wire Bt_Down,
	input wire Bt_Left,
	input wire Bt_Right,
	input wire Bt_Centre,
	input wire sysclk,
	output wire [3:0] LEDs,
	output wire Pulse_X,
	output wire Pulse_Y);

reg [1:0] State = 2'b00;
reg [1:0] Snext = 2'b00;

parameter Function_1 = 2'b00;
parameter Function_2 = 2'b01;
parameter Function_3 = 2'b10;
parameter Function_4 = 2'b11;


always @(posedge Bt_Centre) begin
	SnextL<= Snext;
end	

always @(*) begin
	case (State)
	Function_1: begin
				Snext = Function_2;
				PWM_Generator F_1 (.sysclk(sysclk),.SW(SW),.Pulse(Pulse_X));
				LEDs=4'b0001;
				end
	Function_2: begin
				Snext = Function_3;
				Main_F2 F_2 (.sysclk(sysclk),.Enable_SW(SW),.Bt_Plus(Bt_Right),
					.Bt_Minus(Bt_Left),.Pulse(Pulse_X));
				LEDs=4'b0010;
				end
	Function_3: begin
				endSnext = Function_4;
				Main_F3 F_3 (.sysclk(sysclk),.Bt_Next(Bt_Right),
					.Bt_Pre(Bt_Left),.Bt_Auto(Bt_Down),.Pulse_X(Pulse_X),
					.Pulse_Y(Pulse_Y));
				LEDs=4'b0100;
				end
	Function_4: begin
				endSnext = Function_1;	
				Main_F4 F_4 (.sysclk(sysclk),.Bt_Up(Bt_Up),.Bt_Down(Bt_Down),
					.Bt_Left(Bt_Left),.Bt_Right(Bt_Right),.Reset_SW(SW[3]),
						Storage_SW(SW[0]),.Pulse_X(Pulse_X),Pule_Y(Pule_Y));
				LEDs=4'b1000;
				end
	endcase
end
endmodule