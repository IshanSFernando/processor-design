module IDR (
    input clk,
    input write,
    input read1,
    input read2,
    input [8:0] din,
    output reg[17:0] dout1 = 18'b0,
    output reg[8:0]  dout2 = 9'b0
);

reg [8:0] store = 9'b0; // 9-bit register
always @(posedge clk)
	begin
		if (write) store <= din;
		if (read2) dout2 <= store;
        if (read1) dout1 <= {9'b0,store}
	end
endmodule
