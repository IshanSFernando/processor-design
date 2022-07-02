`timescale 1ns / 1ps

module Top(
    input clk
);

// PC
wire [8:0]  pc_to_iar;

// IAR
wire [8:0] iar_to_iram ;

// IDR
wire [8:0]  idr2_to_pc_tr_ir;

// IR
//wire write_ir;
wire [8:0] ir_to_ctrlunit;
    
// IRAM
wire [8:0] iram_to_idr;

// DRAM
wire [8:0] mdr_to_dram;
wire [17:0] mar_to_dram;
wire [8:0] dram_to_mdr;


// ALU_MUX_A
wire [17:0] idr_to_muxa, mdr_to_muxa, rcol_to_muxa, rrow_to_muxa, 
ri_to_muxa, rj_to_muxa, rtotal_to_muxa, address_to_muxa, rbnd_to_muxa, rcoltemp_to_muxa;
wire [17:0] muxa_to_alu;

// ALU_Mux_B
wire [17:0] tr_to_muxb, ac_to_muxb;
wire  [17:0] muxb_to_alu;

// ALU
wire [17:0] alu_c;
wire lsb,neg;

// decoder for special purpose registers
wire [7:0] decoder_to_sreg_signals;

// Control unil
wire [35:0] all_ctrl_signals;

PC PC(
    .clk(clk),
    .write(all_ctrl_signals[26]),
    .inc(all_ctrl_signals[11]),
    .din(idr2_to_pc_tr_ir),
    .dout(pc_to_iar)
);

IAR IAR(
    .clk(clk),
    .write(all_ctrl_signals[25]),
    .inc(all_ctrl_signals[12]),
    .din(pc_to_iar),
    .dout(iar_to_iram)
);

IDR IDR(
    .clk(clk),
    .write(all_ctrl_signals[18]),
    .din(iram_to_idr),
    .dout1(idr_to_muxa),
    .dout2(idr2_to_pc_tr_ir)
);

TR TR(
    .clk(clk),
    .write(all_ctrl_signals[24]),
    .din(idr2_to_pc_tr_ir),
    .dout(tr_to_muxb)
);

IR IR(
    .clk(clk),
    .write(all_ctrl_signals[23]),
    .din(idr2_to_pc_tr_ir),
    .dout(ir_to_ctrlunit)
);

IRAM IRAM(
    .addr(iar_to_iram),
    .dout(iram_to_idr)
);

DRAM DRAM(
    .clk(clk),
    .write(all_ctrl_signals[13]),
    .off(all_ctrl_signals[0]),
    .din(mdr_to_dram),
    .addr(mar_to_dram),
    .dout(dram_to_mdr) 
);

MAR MAR(
    .clk(clk),
    .write(all_ctrl_signals[22]),
    .din(alu_c),
    .dout(mar_to_dram)
);

MDR MDR(
    .clk(clk),
    .write1(all_ctrl_signals[21]),
    .write2(all_ctrl_signals[20]),
    .din1(dram_to_mdr),
    .din2(alu_c),
    .dout1(mdr_to_dram),
    .dout2(mdr_to_muxa)
);

AC AC(
    .clk(clk),
    .write(all_ctrl_signals[19]),
    .din(alu_c),
    .dout(ac_to_muxb)
);

RX Rcol(
    .clk(clk),
    .write(decoder_to_sreg_signals[7]),
    .din(alu_c),
    .dout(rcol_to_muxa)
);

RX Rrow(
    .clk(clk),
    .write(decoder_to_sreg_signals[6]),
    .din(alu_c),
    .dout(rrow_to_muxa)
);

RX Ri(
    .clk(clk),
    .write(decoder_to_sreg_signals[5]),
    .din(alu_c),
    .dout(ri_to_muxa)
);

RX Rj(
    .clk(clk),
    .write(decoder_to_sreg_signals[4]),
    .din(alu_c),
    .dout(rj_to_muxa)
);

RX Rtotal(
    .clk(clk),
    .write(decoder_to_sreg_signals[3]),
    .din(alu_c),
    .dout(rtotal_to_muxa)
);

RX Raddress(
    .clk(clk),
    .write(decoder_to_sreg_signals[2]),
    .din(alu_c),
    .dout(address_to_muxa)
);

RX Rbnd(
    .clk(clk),
    .write(decoder_to_sreg_signals[1]),
    .din(alu_c),
    .dout(rbnd_to_muxa)
);

RX Rcoltemp(
    .clk(clk),
    .write(decoder_to_sreg_signals[0]),
    .din(alu_c),
    .dout(rcoltemp_to_muxa)
);

ALU_Mux_A ALU_Mux_A(
    .select(all_ctrl_signals[6:3]),
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
    .select(all_ctrl_signals[2:1]),
    .dout_tr(tr_to_muxb), 
    .dout_ac(ac_to_muxb),
    .alu_b(muxb_to_alu)
);

ALU ALU(
    .clk(clk),
    .alu_sel(all_ctrl_signals[10:7]),
    .a(muxa_to_alu),
    .b(muxb_to_alu),
    .c(alu_c),
    .lsb(lsb),
    .neg(neg)
);

SRegister_Decoder  SRegister_Decoder(
    .sel(all_ctrl_signals[17:14]),
    .sreg_wr_ctrl_signals(decoder_to_sreg_signals)
);

control_unit control_unit(
    .clk(clk),
    .N_flag(neg),
    .lsb(lsb),
    .addr(all_ctrl_signals[35:27]),
    .IR(ir_to_ctrlunit),
    .MIR(all_ctrl_signals)
);

endmodule
