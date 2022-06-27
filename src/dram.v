module DRAM(clk, read, din, addr, dout);
input clk, read;
input [8:0] din;
input [17:0] addr;
output reg [8:0] dout;

reg [8:0] dMem[262143:0]; // 9 bit size, 262143 locations

initial begin
	$readmemb("path-to-Image-file", dMem);
end

always @(posedge clk)
	begin
		if (read) dout <= dMem[addr];
	end

endmodule