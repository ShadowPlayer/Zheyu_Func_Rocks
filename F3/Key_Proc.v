module Key_Proc(input wire sysclk,
input wire Bt_Next,
input wire Bt_Pre,
input wire Bt_Auto,
output reg [3:0] Enable_SW);

reg [1:0] Address = 0;
reg [27:0] count=0; // defining the time gap between two plot switching
reg Is_Auto = 1'b0;// The Boolean that shows the state of Auto play. 
assign Time_Gap = &count;

always @(posedge sysclk) begin
	count<=count+1'b1;
	if (Bt_Next)
		Address <= Address + 1'b1;
	if (Bt_Pre)
		Address <= Address - 1'b1;
	if (Bt_Auto)
		Is_Auto <= Is_Auto + 1'b1;// The Auto play button ON/OFF logic
end
always @ (posedge Time_Gap) begin // the auto play wont be triggered immediately.
	if (Is_Auto)
		Address <= Address + 1'b1;
end

always @ (*)  begin 
	case (Address)
	2'b00: Enable_SW = 4'b0001; // show the 1st plot
	2'b00: Enable_SW = 4'b0010; //2nd
	2'b00: Enable_SW = 4'b0100; //3rd
	2'b00: Enable_SW = 4'b1000; //4th
	endcase
end

endmodule