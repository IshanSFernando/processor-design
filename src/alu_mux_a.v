`timescale 1ns / 1ps

module ALU_Mux_A(
    input [3:0] select,
    input [17:0] dout1_idr, dout_mdr, 
    dout_rcol, dout_rrow, dout_ri, dout_rj, dout_rtotal, dout_address, dout_rbnd, dout_rcoltemp,
    output [17:0] alu_a
);

parameter 
default_sel = 4'b0000,
idr1_sel = 4'b0001,
mdr_sel  = 4'b0010,
rcol_sel = 4'b0011,
rrow_sel = 4'b0100,
ri_sel   = 4'b0101,
rj_sel   = 4'b0110,
rtotal_sel   = 4'b0111,
raddress_sel = 4'b1000,
rbnd_sel     = 4'b1001,
rcoltemp_sel = 4'b1010;

assign alu_a = (select == idr1_sel)? dout1_idr:
               (select == mdr_sel)? dout_mdr:
               (select == rcol_sel)? dout_rcol:
               (select == rrow_sel)? dout_rrow:
               (select == ri_sel)? dout_ri:
               (select == rj_sel)? dout_rj:
               (select == rtotal_sel)? dout_rtotal:
               (select == raddress_sel)? dout_address:
               (select == rbnd_sel)? dout_rbnd:
               (select == rcoltemp_sel)? dout_rcoltemp:
               default_sel;
endmodule 
