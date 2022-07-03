`timescale 1ns / 1ps

module Poc_Top(
    input clk,
    input inc_pc, write_pc, write_iar, inc_iar, write_idr, write_ir, write_tr,
    write_dram, off_dram, write_mar, write1_mdr, write2_mdr, write_ac,
    write_rcol, write_rrow, write_ri, write_rj, write_rtotal, write_raddress, 
    write_rbnd, write_rcoltemp,
    
    input [3:0] select_mux_a,
    input [1:0] select_mux_b,   
    input [3:0] alu_sel,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    output lsb,neg,
    output [8:0] dout_ir,
    output [17:0] dout_ac
);

// PC
//wire inc_pc,write_pc;
wire [8:0]  pc_to_iar;

// IAR
//wire write_iar,inc_iar;
wire [8:0] iar_to_iram ;

// IDR
//wire write_idr;
//wire [17:0] dout1_idr;
wire [8:0]  idr2_to_pc_tr_ir;

// TR
//wire inc_tr, write_tr;
//wire [17:0] dout_tr;

// IR
//wire write_ir;
//wire [8:0] dout_ir;
    
// IRAM
wire [8:0] iram_to_idr;

// DRAM
wire [8:0] mdr_to_dram;
wire [17:0] mar_to_dram;
wire [8:0] dram_to_mdr;

// MAR

// MDR


// ALU_MUX_A
// reg [3:0] select_mux_a;
wire [17:0] idr_to_muxa, mdr_to_muxa, 
 rcol_to_muxa, rrow_to_muxa, ri_to_muxa, rj_to_muxa, rtotal_to_muxa, address_to_muxa, rbnd_to_muxa, rcoltemp_to_muxa;
wire [17:0] muxa_to_alu;

// ALU_Mux_B
wire [17:0] tr_to_muxb, ac_to_muxb;
wire  [17:0] muxb_to_alu;

// ALU
wire [17:0] alu_c;


Poc_PC PC(
    .clk(clk),
    .write(write_pc),
    .inc(inc_pc),
    .din(idr2_to_pc_tr_ir),
    .dout(pc_to_iar)
);

Poc_IAR IAR(
    .clk(clk),
    .write(write_iar),
    .inc(inc_iar),
    .din(pc_to_iar),
    .dout(iar_to_iram)
);

Poc_IDR IDR(
    .clk(clk),
    .write(write_idr),
    .din(iram_to_idr),
    .dout1(idr_to_muxa),
    .dout2(idr2_to_pc_tr_ir)
);

Poc_TR TR(
    .clk(clk),
    .write(write_tr),
    .din(idr2_to_pc_tr_ir),
    .dout(tr_to_muxb)
);

Poc_IR IR(
    .clk(clk),
    .write(write_ir),
    .din(idr2_to_pc_tr_ir),
    .dout(dout_ir)
);

Poc_IRAM IRAM(
    .addr(iar_to_iram),
    .dout(iram_to_idr)
);

Poc_DRAM DRAM(
    .clk(clk),
    .write(write_dram),
    .off(off_dram),
    .din(mdr_to_dram),
    .addr(mar_to_dram),
    .dout(dram_to_mdr)
);

Poc_MAR MAR(
    .clk(clk),
    .write(write_mar),
    .din(alu_c),
    .dout(mar_to_dram)
);

Poc_MDR MDR(
    .clk(clk),
    .write1(write1_mdr),
    .write2(write2_mdr),
    .din1(dram_to_mdr),
    .din2(alu_c),
    .dout1(mdr_to_dram),
    .dout2(mdr_to_muxa)
);

AC AC(
    .clk(clk),
    .write(write_ac),
    .din(alu_c),
    .dout(ac_to_muxb)
);

Poc_RX Rcol(
    .clk(clk),
    .write(write_rcol),
    .din(alu_c),
    .dout(rcol_to_muxa)
);

Poc_RX Rrow(
    .clk(clk),
    .write(write_rrow),
    .din(alu_c),
    .dout(rrow_to_muxa)
);

Poc_RX Ri(
    .clk(clk),
    .write(write_ri),
    .din(alu_c),
    .dout(ri_to_muxa)
);

Poc_RX Rj(
    .clk(clk),
    .write(write_rj),
    .din(alu_c),
    .dout(rj_to_muxa)
);

Poc_RX Rtotal(
    .clk(clk),
    .write(write_rtotal),
    .din(alu_c),
    .dout(rtotal_to_muxa)
);

Poc_RX Raddress(
    .clk(clk),
    .write(write_raddress),
    .din(alu_c),
    .dout(address_to_muxa)
);

Poc_RX Rbnd(
    .clk(clk),
    .write(write_rbnd),
    .din(alu_c),
    .dout(rbnd_to_muxa)
);

Poc_RX Rcoltemp(
    .clk(clk),
    .write(write_rcoltemp),
    .din(alu_c),
    .dout(rcoltemp_to_muxa)
);

Poc_ALU_Mux_A ALU_Mux_A(
    .select(select_mux_a),
    .dout1_idr(idr_to_muxa), 
    .dout_mdr(mdr_to_muxa), 
    .dout_rcol(rcol_to_muxa), 
    .dout_rrow(rrow_to_muxa), 
    .dout_ri(ri_to_muxa), 
    .dout_rj(rj_to_muxa), 
    .dout_rtotal(rtotal_to_muxa), 
    .dout_address(address_to_muxa), 
    .dout_rbnd(rbnd_to_muxa),
    .dout_rcoltemp(rcoltemp_to_muxa),
    .alu_a(muxa_to_alu)
);

ALU_Mux_B ALU_Mux_B(
    .select(select_mux_b),
    .dout_tr(tr_to_muxb), 
    .dout_ac(ac_to_muxb),
    .alu_b(muxb_to_alu)
);

Poc_ALU ALU(
    .clk(clk),
    .alu_sel(alu_sel),
    .a(muxa_to_alu),
    .b(muxb_to_alu),
    .c(alu_c),
    .lsb(lsb),
    .neg(neg)
);

endmodule
