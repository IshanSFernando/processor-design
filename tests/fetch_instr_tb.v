`timescale 1ns / 1ps

// test 3 micro instruction related to FETCH
module fetch_instr_tb;
reg clk;
wire [8:0] imem_to_idr;

reg write_idr;
wire[17:0] dout1_idr;
wire[8:0]  dout2_idr;

reg inc_iar, write_iar;
wire[8:0] iar_to_iram_addr;

reg inc_pc, write_pc;
reg [8:0] din_pc;
wire [8:0] pc_to_iar;

parameter clk_period = 4'b1010;

Poc_IRAM IRAM_DUT(
    .addr(iar_to_iram_addr),
    .dout(imem_to_idr)
);

Poc_IDR IDR_DUT(
    .clk(clk),
    .write(write_idr),
    .din(imem_to_idr),
    .dout1(dout1_idr),
    .dout2(dout2_idr)
);

PocIAR IAR_DUT(
    .clk(clk),
    .inc(inc_iar),
    .write(write_iar),
    .din(pc_to_iar),
    .dout(iar_to_iram_addr)
);

PocPC PC_DUT(
    .clk(clk),
    .inc(inc_pc),
    .write(write_pc),
    .din(din_pc),
    .dout(pc_to_iar)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
    #5
    din_pc = 6; write_pc = 1;
    
    #10
    write_pc <= 0; write_iar <= 1; inc_pc <= 1;
    
    #10
    write_idr <= 1; write_iar <= 0;inc_pc <= 0;
    
end

initial begin
    #40
    $finish;
end

endmodule
