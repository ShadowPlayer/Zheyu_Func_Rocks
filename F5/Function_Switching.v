module Function_Switching (input wire [3:0] SW,
	input wire Bt_Up,
	input wire Bt_Down,
	input wire Bt_Left,
	input wire Bt_Right,
	input wire Bt_Centre,
	input wire sysclk,
	input wire reset, 
	output reg [3:0] LEDs,
	output reg Pulse_X,
	output reg Pulse_Y);

reg [1:0] State = 2'b00;
reg [1:0] Snext = 2'b00;
wire Up_deb, Down_deb, Left_deb , Right_deb,Centre_deb;
wire Pulse_F1, Pulse_F2, Pulse_F3X, Pulse_F3Y;

parameter Function_1 = 2'b00;
parameter Function_2 = 2'b01;
parameter Function_3 = 2'b10;
parameter Function_4 = 2'b11;


Penta_Debounce Penta_Deb (.X0(Bt_Up),.X1(Bt_Down),.X2(Bt_Left),.X3(Bt_Right),.X4(Bt_Centre),
.reset(reset),.X0_deb(Up_deb),.X1_deb(Down_deb),.X2_deb(Left_deb),.X3_deb(Right_deb),.X4_deb(Centre_deb),
.sysclk(sysclk));

PWM_Generator F_1 (.sysclk(sysclk),.SW(SW),.Pulse(Pulse_F1));

Main_F2 F_2 (.sysclk(sysclk),.Enable_SW(SW),.Bt_Plus(Right_deb),
.Bt_Minus(Left_deb),.Pulse(Pulse_F2),.reset(reset));

Main_F3 F_3 (.sysclk(sysclk),.Bt_Next(Right_deb),
.Bt_Pre(Left_deb),.Bt_Auto(Down_deb),.Pulse_X(Pulse_F3X),
.Pulse_Y(Pulse_F3Y),.reset(reset));

/*Main_F4 F_4 (.sysclk(sysclk),.Bt_Up(Bt_Up),.Bt_Down(Bt_Down),
					.Bt_Left(Bt_Left),.Bt_Right(Bt_Right),.Reset_SW(SW[3]),
						Storage_SW(SW[0]),.Pulse_X(Pulse_X),Pule_Y(Pule_Y));*/
						
always @(posedge sysclk) begin
	if (Centre_deb)
	State<= Snext;
end	

always @(*) begin
	case (State)
	Function_1: begin
				Snext = Function_2;
				Pulse_X = Pulse_F1;
				//Pulse_Y = 1'b0;
				LEDs = 4'b0001;
				end
	Function_2: begin
				Snext = Function_3;
				Pulse_X = Pulse_F2;
				//Pulse_Y = 1'b0;
				LEDs=4'b0010;
				end
	Function_3: begin
				Snext = Function_4;
				Pulse_X = Pulse_F3X;
				Pulse_Y = Pulse_F3Y;
				LEDs=4'b0100;
				end
	Function_4: begin
				Snext = Function_1;	
				LEDs=4'b1000;
				end
	endcase
end
endmodule