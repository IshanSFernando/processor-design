`timescale 1ns / 1ps

module ALU_tb;
reg [17:0]alu_a, alu_b;
reg clk;
reg [3:0] alu_sel;
wire lsb, neg;
wire [17:0] alu_c;

parameter clk_period = 4'b0110;

ALU ALU_DUT(
    .clk(clk),
    .alu_sel(alu_sel),
    .a(alu_a),
    .b(alu_b),
    .lsb(lsb),
    .neg(neg),
    .c(alu_c)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
    alu_a <= 6; alu_b <= 4; alu_sel <= 1;
    
    #6
    alu_a <= 66822; alu_b <= 0; alu_sel <= 10;
    
    #6
    alu_a <= 0; alu_b <= 66822;
end

initial begin
    #40
    $finish;
end

endmodule