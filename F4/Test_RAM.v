module Test_RAM (input wire sysclk,
output wire [5:0] DC_X);

reg [5:0] RAM_X [0:255];
wire [8:0] Reset_Addr = 0;
initial begin
for (Reset_Addr = 0; Reset_Addr < 9'd256; Reset_Addr = 
		Reset_Addr + 1'b1)begin
			RAM_X[Reset_Addr] = 1'b0;
end
end

always @( posedge sysclk) begin
RAM_X[6'd32] <= 6'd23;
end
assign DC_X = RAM_X[6'd31];
endmodule