module TR (
    input clk,
    input inc,
    input write,
    input read,
    input [8:0] din,
    output reg[17:0] dout = 18'b0
);

reg [8:0] store = 9'b0; // 9-bit register
always @(posedge clk)
	begin
        if (inc) store <= store + 9'b000000001;
		if (write) store <= din;
		if (read) dout <= {9'b0,store};
	end
endmodule
