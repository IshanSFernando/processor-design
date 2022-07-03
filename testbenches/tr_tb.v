`timescale 1ns/1ps

module TR_tb;

reg clk, write=0, read=0;
reg [8:0] din=9'b0;
wire[17:0] dout;

parameter clk_period = 4'b1010;

TR DUT_TR(.clk(clk),  
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
   din<=9'b000001011;
   write <= 1;

   #8
   write<=1; read<=1;
   din<=9'b000001111; 
 
end

initial begin
    #(40);
    $finish;
end
    
endmodule
