module IRAM(
input clk,
input write,
input read,
input [8:0] instIn,
input [8:0] addr,
output reg [8:0] instOut
);

reg [8:0] store [511:0]; // 9 bit size, 512 locations

always @(posedge clk)
	begin
		if (write) store[addr] <= instIn;
		if (read) instOut <= store[addr];
	end

endmodule
