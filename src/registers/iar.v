module IAR (
    input clk,
    input inc,
    input write,
    input [8:0] din,
    output reg[8:0] dout
);

always @(posedge clk)
	begin
        if (inc) dout <= dout + 9'b000000001;
		if (write) dout <= din;
	end

endmodule
