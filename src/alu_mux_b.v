`timescale 1ns / 1ps

module ALU_Mux_B(
    input [1:0] select,
    input [18:0] dout_tr, dout_ac,
    output [18:0] alu_b
);

parameter 
default_sel = 2'b00,
tr_sel = 2'b01;
ac_sel = 2'b10;

assign alu_a = (select == tr_sel)? dout_tr:
               (select == ac_sel)? dout_ac:
               default_sel;
endmodule 
