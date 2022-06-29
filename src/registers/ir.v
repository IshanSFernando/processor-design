module IR (
    input clk,
    input write,
    input [8:0] din,
    output reg[8:0] dout = 9'b0
);

always @(posedge clk)
	begin
		if (write) dout <= din;
	end
endmodule
