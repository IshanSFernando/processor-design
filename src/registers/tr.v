module TR (
    input clk,
    input inc,
    input write,
    input [8:0] din,
    output reg[17:0] dout = 18'b0
);

always @(posedge clk)
	begin
        if (inc)   dout <= dout + 9'b000000001;
		if (write) dout <= {9'b0,din};
	end
endmodule
