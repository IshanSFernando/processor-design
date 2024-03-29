`timescale 1ns / 1ps

module ALU_Mux_B(
    input [1:0] select,
    input [17:0] dout_tr, dout_ac,
    output [17:0] alu_b
);

parameter 
tr_sel = 2'b01,
ac_sel = 2'b10;

assign alu_b = (select == tr_sel)? dout_tr:
               (select == ac_sel)? dout_ac:
               18'b0;
endmodule 
