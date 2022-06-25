// general purpose registers

module RX (
    input clk;
    input write;
    input read;
    input [17:0] din;
    output reg[17:0] dout=18'b0;
);

reg [17:0] store=18'b0; // 18-bit register
always @(posedge clk)
	begin
        if (write) store <= din;
        if (read)  dout  <= store;
	end
endmodule
