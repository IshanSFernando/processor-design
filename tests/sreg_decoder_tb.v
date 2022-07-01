`timescale 1ns / 1ps

module sreg_decoder_tb;
reg [3:0] sel;
wire [7:0] reg_signals;

SRegister_Decoder SRegister_Decoder_DUT(
    .sel(sel),
    .sreg_wr_ctrl_signals(reg_signals)
);

initial begin
    #3
    sel <= 2;
    #5
    sel <= 7;
    #5
    sel <= 1;
    #3
    sel <= 8;
    #5
    sel <= 3;
    #5
    sel <= 4;
    #3
    sel <= 6;
    #5
    sel <= 5;
    #3
    sel <= 0;
    #3
    sel <= 9;
end

initial begin
    #50
    $finish;
end
endmodule
