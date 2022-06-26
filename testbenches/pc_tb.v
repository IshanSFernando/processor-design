`timescale 1ns/1ps

module PC_tb;

reg clk, inc=0, write=0, read=0;
reg [8:0] din=9'b0;
wire[8:0] dout;

parameter clk_period = 4'b1010;

PC DUT_PC( .clk(clk), 
       .inc(inc), 
       .read(read), 
       .write(write),
       .din(din),
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
   #2
   inc<=1;
   din<=9'b000001011;

   #10
   read <=1; inc<=0;

   #13
   write<=1; read<=0;
   
   #8
   inc=0;
   write<=0; read<=1; 
end

initial begin
    #(40);
    $finish;
end
    
endmodule
