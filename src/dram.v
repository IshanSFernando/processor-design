`timescale 1ns / 1ps

module DRAM(clk, write, off, din, addr, dout);
input clk, write, off;
input [8:0] din;
input [17:0] addr;
output [8:0] dout;

reg [8:0] dMem[262143:0]; // 9 bit size, 262143 locations

initial begin
	$readmemb("path-to-image-value-file", dMem);
end

always @(posedge clk)
	begin
		if (write) dMem[addr] <= din;
		if (off) begin  // only for simulation purpose
		  $writememb("path-to-output-file", dMem);
		  $finish;
		end
	end
	
assign dout = dMem[addr];
endmodule
 