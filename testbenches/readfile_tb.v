`timescale 1ns/1ps

module readmemh_demo;

reg [8:0] Mem [11:0];

initial $readmemb("path-to-file",Mem);

integer k;
initial begin
#10;
$display("Contents of Mem after reading data file:");
for (k=0; k<6; k=k+1) $display("%d:%h",k,Mem[k]);
#30;
end

endmodule

