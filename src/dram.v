module DRAM(
input clk,
input write,
input read,
input [8:0] din,
input [17:0] addr,
output reg [8:0] dout
);

reg [8:0] store [262143:0]; // 9 bit size, 2^18 locations

always @(posedge clk)
	begin
		if (write) store[addr] <= din;
		if (read) dout <= store[addr];
	end

endmodule
