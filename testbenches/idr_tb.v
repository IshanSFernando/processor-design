`timescale 1ns/1ps

module IDR_tb;

reg clk, write=0, read1=0, read2=0;
reg [8:0] din=9'b0;
wire[17:0] dout1;
wire[8:0] dout2;

parameter clk_period = 4'b1010;

IDR DUT_IDR(.clk(clk),  
       .read1(read1), 
       .read2(read2),
       .write(write),
       .din(din),
       .dout1(dout1),
       .dout2(dout2)
);

initial begin
   clk = 1'b0;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
   #2
   din<=9'b000011010;
   write <=1;read1 <= 1;

   #8
   write<=1; read1<=1; read2<=1;
   din<=9'b100000001; 
   
   #7 
   din<=9'b000011011;
   write <=1;read2 <= 1; read2 <= 0;
   
   
   
 
end

initial begin
    #(60);
    $finish;
end
    
endmodule
