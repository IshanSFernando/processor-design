`timescale 1ns / 1ps

module Top_tb;
reg clk;

parameter clk_period = 2'd2;

Top Top(
    .clk(clk)
);

initial begin
   clk = 1;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

endmodule
