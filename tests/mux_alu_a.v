`timescale 1ns / 1ps

// alu a bus selection with a mux
module Poc_mux_alu_a_tb;
reg clk;

reg write_idr;
reg [8:0] din_idr;
wire[17:0] dout1_idr;
wire[8:0]  dout2_idr;

reg write_mdr;
reg [17:0] din_mdr;
wire[17:0] dout_mdr;

reg write_rcol;
reg [17:0] din_rcol;
wire [17:0] dout_rcol;

reg write_rrow;
reg [17:0] din_rrow;
wire [17:0] dout_rrow;

parameter clk_period = 4'b1010;

reg [2:0]select;
wire [17:0] alu_a_bus;

Poc_IDR IDR_DUT2(
    .clk(clk),
    .write(write_idr),
    .din(din_idr),
    .dout1(dout1_idr),
    .dout2(dout2_idr)
);

Poc_MDR MDR_DUT(
    .clk(clk),
    .write(write_mdr),
    .din(din_mdr),
    .dout(dout_mdr)
);

Poc_RX Rcol_DUT(
    .clk(clk),
    .write(write_rcol),
    .din(din_rcol),
    .dout(dout_rcol)
);

Poc_RX Rrow_DUT(
    .clk(clk),
    .write(write_rrow),
    .din(din_rrow),
    .dout(dout_rrow)
);

Poc_ALU_Mux_A ALU_MUX_A_DUT(
    .select(select),
    .dout1_idr(dout1_idr),
    .dout_mdr(dout_mdr),
    .dout_rcol(dout_rcol),
    .dout_rrow(dout_rrow),
    . alu_a(alu_a_bus)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
    #3
    select <= 1; din_idr <= 23; write_idr <= 1;
    din_mdr <= 19; write_mdr <= 1;
    din_rcol <= 65; write_rcol <= 1;
    din_rrow <= 54; write_rrow <= 1;
    
    #9
    select=2;
    
    #7
    select=4;
    
    #8
    select=0;
    
    #9
    select=3;
    
end

initial begin
    #50
    $finish;
end

endmodule
