module RAM (input wire sysclk,
	input wire Reset_Sw,
	input wire Storage_Sw,
	input wire Bt_up,
	input wire Bt_Down,
	input wire Bt_Left,
	input wire Bt_Right,
	input reg  [5:0] Duty_X,
	input reg  [5:0] Duty_Y,
	output wire [5:0] DC_X,
	output wire [5:0] DC_Y);

reg [5:0] RAM_X [0:255];
reg [5:0] RAM_Y [0:255];
reg [7:0] Reading_Count = 0;
reg [11:0] count = 6'b0; // 256
reg [7:0] Addr = 8'b0; //Storage address 

assign DC_X = RAM_X[Reading_Count];
assign DC_Y = RAM_Y[Reading_Count];

initial begin
	for (Reset_Addr = 0; Reset_Addr < 9'd256; Reset_Addr = 
		Reset_Addr + 1'b1)begin
			RAM_X[Reset_Addr] = 1'b0;
			RAM_Y[Reset_Addr] = 1'b0;
	end

always @(posedge sysclk) begin
	count<= count + 1'b1;
	if (&count)
	Reading_Count<=Reading_Count+1'b1;
		if (Reading_Count == Addr);
			Reading_Count <= 0;
	if (Reset_Sw) begin
		for (Reset_Addr = 0; Reset_Addr < 9'd256; Reset_Addr = Reset_Addr + 1'b1) begin
			RAM_X[Reset_Addr] <= 1'b0;
			RAM_Y[Reset_Addr] <= 1'b0;
		end
	end else begin
		if (Bt_up||Bt_Down||Bt_Left||Bt_Right) begin
			if (Storage_Sw) begin
	 			Addr <= Addr + 1'b1;
				RAM_X[Addr] <= Duty_X;
				RAM_Y[Addr] <= Duty_Y;
			end
		end
	end
end