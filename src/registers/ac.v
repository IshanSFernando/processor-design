module AC (
    input clk,
    input write,
    input [17:0] din,
    output reg[17:0] dout=18'b0
);

always @(posedge clk)
	begin
        if (write) dout <= din;
	end
endmodule
