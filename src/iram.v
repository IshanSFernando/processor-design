module IRAM(addr, dout);
input [8:0] addr;
output[8:0] dout;

reg [8:0] iMem[511:0]; // 9 bit size, 512 locations

initial begin
	$readmemb("path-to-machine-code-file", iMem);
end

assign dout = iMem[addr];

endmodule
