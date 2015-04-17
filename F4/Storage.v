module Storage (input wire sysclk,
input wire Storage_SW;
input wire [5:0] Duty_X,
input wire [5:0] Duty_Y,
input wire reset,
output reg [5:0] DC_X,
output reg [5:0] DC_Y);

reg [7:0] Addr = 8'b0; //Storage address 
reg [7:0] count = 8'b0;//Reading counter 
reg [5:0] RAM_X [0:255];
reg [5:0] RAM_Y [0:255];
wire [8:0] Reset_Addr = 0;

initial begin
	for (Reset_Addr = 0; Reset_Addr < 9'd256; Reset_Addr = 
		Reset_Addr + 1'b1)begin
			RAM_X[Reset_Addr] = 1'b0;
			RAM_Y[Reset_Addr] = 1'b0;
	end
end

always @(posedge sysclk) begin 
	 count<= count + 1'b1;
	 if(reset)begin
		for (Reset_Addr = 0; Reset_Addr < 9'd256; Reset_Addr = 
			Reset_Addr + 1'b1) begin
			RAM_X[Reset_Addr] = 1'b0;
			RAM_Y[Reset_Addr] = 1'b0;
		end
	end
end 

always @(Duty_X, Duty_Y)begin
	if (Storage_SW) begin
		Addr <= Addr + 1'b1;
		RAM_X[Addr] <= Duty_X;
		RAM_Y[Addr] <= Duty_Y;
	end else begin
		RAM_X[Addr]<=Duty_X;
		RAM_Y[Addr]<=Duty_Y;
	end
end	

assign DC_X = RAM_X[count];
assign DC_Y = RAM_Y [count];


endmodule 