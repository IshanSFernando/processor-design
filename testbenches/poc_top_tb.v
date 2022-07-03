`timescale 1ns / 1ps

module Top_tb;
reg clk;

// for testing
reg inc_pc, write_pc, write_iar,inc_iar, write_idr, write_ir, write_tr, write_mar, write_dram, write1_mdr, write2_mdr, off_dram;
reg write_ac, write_rcol, write_rrow, write_ri, write_rj, write_rtotal, write_raddress, 
    write_rbnd, write_rcoltemp;
reg [17:0] din_mar, din2_mdr;

wire [8:0] dout_top_ir;;
reg  [3:0] select_mux_a;
reg [1:0] select_mux_b;

reg [3:0] alu_sel;
wire lsb, neg;
parameter clk_period = 4'd10;

Top Top(
    .clk(clk),
    
    .inc_pc(inc_pc), 
    .write_pc(write_pc), 
    
    .write_iar(write_iar),
    .inc_iar(inc_iar),
     
    .write_idr(write_idr),
     
    .write_tr(write_tr),
    
    .write_ir(write_ir),
    
    .write_mar(write_mar),
    
    .write_dram(write_dram),
    .off_dram(off_dram),
    
    .write1_mdr(write1_mdr), 
    .write2_mdr(write2_mdr),
    
    .select_mux_a(select_mux_a),
    .select_mux_b(select_mux_b),
    
    .alu_sel(alu_sel),
    .lsb(lsb),
    .neg(neg),
    
    .write_ac(write_ac),
    .write_rcol(write_rcol), 
    .write_rrow(write_rrow), 
    .write_ri(write_ri), 
    .write_rj(write_rj), 
    .write_rtotal(write_rtotal), 
    .write_raddress(write_raddress), 
    .write_rbnd(write_rbnd), 
    .write_rcoltemp(write_rcoltemp),
    
    .dout_ir(dout_top_ir)

);

initial begin
   clk = 1;
   forever begin
       #(clk_period/2)
       clk <= ~clk;
   end
end

initial begin
    #5;
    inc_pc <= 0; write_pc <= 0; write_iar <= 1;
    inc_iar <= 0;write_idr <= 0; write_ir <= 0; write_tr <= 0;
   
   #10
   inc_pc <= 1; write_pc <= 0; write_iar <= 0;
   inc_iar <= 0;write_idr <= 1; write_ir <= 0; write_tr <= 0;
   
   #10
   inc_pc <= 0; write_pc <= 0; write_iar <= 1;
   inc_iar <= 0;write_idr <= 0; write_ir <= 1; write_tr <= 1;
   
   #10
   select_mux_a <= 1; select_mux_b <= 2'b01; alu_sel <= 4'b1001;
   
   #10
   write2_mdr <= 1; write_ac <= 1;
   
end

initial begin
    #80
    $finish;
end
endmodule
