`timescale 1ns / 1ps

module DRAM(clk, write, din, addr, dout);
input clk, write;
input [8:0] din;
input [17:0] addr;
output [8:0] dout;

reg [8:0] dMem[262143:0]; // 9 bit size, 262143 locations

initial begin
	$readmemb("E:/SEM 5 - new/1 - EN3030 - Circuits and Systems Design/1 - EN3030 - Circuits and Systems Design/2021/project_processor_design_2022/processor-design/testbenches/dummy_inst.txt", dMem);
end

always @(posedge clk)
	begin
		if (write) dMem[addr] <= din;
	end
	
assign dout = dMem[addr];
endmodule
