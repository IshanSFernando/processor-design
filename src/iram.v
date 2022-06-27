module IRAM(clk, read, din, addr, dout);
input clk, read;
input [8:0] din;
input [8:0] addr;
output reg [8:0] dout;

reg [8:0] iMem[511:0]; // 9 bit size, 512 locations

initial begin
	$readmemb("path-to-machine-code-file", iMem);
end

always @(posedge clk)
	begin
		if (read) dout <= iMem[addr];
	end

endmodule
