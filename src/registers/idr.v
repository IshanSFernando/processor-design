module IDR (
    input clk,
    input write,
    input [8:0] din,
    output reg[17:0] dout1,
    output reg[8:0]  dout2
);

always @(posedge clk)
	begin
		if (write) begin
		  dout2 <= din;
		  dout1 <= {9'b0,din};
		end
	end
endmodule
