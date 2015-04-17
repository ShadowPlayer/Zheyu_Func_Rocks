module Move(input wire Bt_Up,
input wire Bt_Down,
input wire Bt_Left,
input wire Bt_Right,
output reg [5:0] Duty_X,
output reg [5:0] Duty_Y);

reg [5:0] DC_X = 1'b0;
reg [5:0] DC_Y = 1'b0;

assign	 Duty_X = DC_X;
assign 	 Duty_Y = DC_Y; 

always @(Bt_Down,Bt_Left,Bt_Right,Bt_Up)begin
	if (Bt_Down)
		DC_Y <= DC_Y - 6'd4;
	if (Bt_Up)
		DC_Y <= DC_Y + 6'd4;
	if (Bt_Left)
		DC_X <= DC_X - 6'd4;	
	if (Bt_Right)
		DC_X <= DC_X + 6'd4;
	end
end	

endmodule 
