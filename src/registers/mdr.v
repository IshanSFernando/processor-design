`timescale 1ns / 1ps

module MDR(
    input clk,
    input write1,
    input write2,
    input [8:0] din1,
    input [17:0] din2,
    output reg[8:0] dout1 =9'b0,
    output reg[17:0] dout2=18'b0
);

always @(posedge clk)
	begin
        if (write1) begin
            dout1 <= din1;
            dout2 <= {9'b0,din1};
        end
        if (write2) begin
            dout1 <= din2[8:0];
            dout2 <= din2;
        end
	end
endmodule
