`timescale 1ns / 1ps

module DRAM_tb;
reg clk, write_dram;
wire [8:0] mdr_to_dram;
wire [8:0] dram_to_mdr;

reg write_mdr;

reg [17:0]din_mar;
reg write_mar;
wire [17:0] mar_to_dram;

parameter clk_period = 4'b1010;

DRAM DRAM_DUT(
    .clk(clk),
    .write(write_dram),
    .addr(mar_to_dram),
    .din(mdr_to_dram),
    .dout(dram_to_mdr)
);

MDR MDR_DUT(
    .clk(clk),
    .write1(write_mdr),
    .din1(dram_to_mdr),
    .dout1(mdr_to_dram)
);

MAR MAR_DUT(
    .clk(clk),
    .write(write_mar),
    .din(din_mar),
    .dout(mar_to_dram)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
    din_mar <= 3; write_mar <= 1;
    
    #5
    write_mdr <= 1;
    
    #5
    din_mar <= 9; write_mar <= 1; write_mdr <= 0;
    
    #10
    write_dram <= 1;
    
    
end

initial begin
    #80
    $finish;
end


endmodule
