module TR (
    input clk,
    input write,
    input [8:0] din,
    output reg[17:0] dout = 18'b0
);

always @(posedge clk)
	begin
		if (write) dout <= {9'b0,din};
	end
endmodule
