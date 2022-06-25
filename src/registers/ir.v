module IR (
    input clk,
    input write,
    input read,
    input [8:0] din,
    output reg[8:0] dout = 9'b0
);

reg [8:0] store = 9'b0; // 9-bit register
always @(posedge clk)
	begin
		if (write) store <= din;
		if (read) dout   <= store;
	end
endmodule
