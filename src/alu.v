`timescale 1ns / 1ps

module Poc_ALU(
    input clk,
    input [3:0] alu_sel,
    input [17:0] a,b,
    output reg[17:0] c,
    output lsb,neg
);

always @(posedge clk) begin
    case(alu_sel)
    4'b0001: c <= a;
    4'b0010: c <= b;
    4'b0011: c <= b+1;
    4'b0100: c <= b+2;
    4'b0101: c <= b+3;
    4'b0110: c <= b-1;
    4'b0111: c <= b-2;
    4'b1000: c <= b-3;
    4'b1001: c <= b+a;
    4'b1010: c <= b-a;
    4'b1011: c <= b*a;
    4'b1100: c <= b/a;
    4'b1101: c <= {a[8:0],b[8:0]};
    default: c <= c;
    endcase
end

assign lsb = c[0];
assign neg = c[17];

endmodule
