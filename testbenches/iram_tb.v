`timescale 1ns/1ps

module IRAM_tb;

reg clk, read=0;
reg [8:0] din=9'b0;
reg [8:0] addr=0;
wire[8:0] dout;

parameter clk_period = 4'b1010;

IRAM DUT_IRAM(
       .clk(clk),  
       .read(read), 
       .din(din),
       .addr(addr),
       .dout(dout)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end 
end

initial begin
   #3
   read <= 1; addr <= 1;
    
   #7
   addr <= 225;
    
   #10
   addr <= 224;
   
   #10
   addr <= 223;
   
   #10
   addr <= 222;
   
   #10
   addr <= 221;
   
   #10
   addr <= 0;
   
   #10
   addr <= 100;
   
end

initial begin
    #(100);
    $finish;
end
    
endmodule
