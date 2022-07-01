`timescale 1ns / 1ps

// Rcol, Rrow, Ri, Rj, Rtotal, Raddress, Rbnd, RcolTemp (order is important)
module SRegister_Decoder(
    input  [3:0] sel,
    output [7:0] sreg_wr_ctrl_signals  // only for special purpose registers
);

parameter
Rcol = 4'b0001,
Rrow = 4'b0010,
Ri   = 4'b0011, 
Rj   = 4'b0100, 
Rtotal = 4'b0101, 
Raddress = 4'b0110, 
Rbnd = 4'b0111, 
RcolTemp = 4'b1000;

// write signals
parameter
Rcol_write = 8'b10_00_00_00,
Rrow_write = 8'b01_00_00_00,
Ri_write   = 8'b00_10_00_00,
Rj_write   = 8'b00_01_00_00,
Rtotal_write     = 8'b00_00_10_00,
Raddress_write   = 8'b00_00_01_00,
Rbnd_write       = 8'b00_00_00_10,
RcolTemp_write   = 8'b00_00_00_01 ;

assign sreg_wr_ctrl_signals = (sel == Rcol)? Rcol_write:
                              (sel == Rrow)? Rrow_write: 
                              (sel == Ri)? Ri_write:
                              (sel == Rj)? Rj_write:
                              (sel == Rtotal)? Rtotal_write:
                              (sel == Raddress)? Raddress_write:
                              (sel == Rbnd)? Rbnd_write:
                              (sel == RcolTemp)? RcolTemp_write:
                              8'b0;
endmodule
