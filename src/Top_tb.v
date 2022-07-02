`timescale 1ns / 1ps

module Top_tb;
reg clk;

// for testing
reg inc_pc, write_pc, write_iar,inc_iar, write_idr, write_ir, write_tr, write_mar, write_dram, write1_mdr, write2_mdr, off_dram;
reg write_ac;

wire [8:0] dout_top_ir;
wire [17:0] dout_top_ac;
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
    #5  //fetch1
    inc_pc <= 0; write_pc <= 0; write_iar <= 1; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
    
   
   #10   // fetch2
    inc_pc <= 1; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 1; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
   
   #10  // fetch3
    inc_pc <= 0; write_pc <= 0; write_iar <= 1; inc_iar <= 0; write_idr <= 0; write_ir <= 1; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
   
   #10  // fetch4
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
   
   #10  //LDAC1
    inc_pc <= 1; write_pc <= 0; write_iar <= 0; inc_iar <= 1; write_idr <= 1; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
   
   #10    //LDAC2
    inc_pc <= 1; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 1; write_ir <= 0; write_tr <= 1;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
    
    #10 //LDAC3
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 4'b0001; select_mux_b <= 2'b01; alu_sel <= 4'b1101;
    
    #10 // LDAC4
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 1; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
    
    #10 // LDAC5
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 1; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 0; select_mux_b <= 0; alu_sel <= 4'b0000;
    
    #10 // LDAC6
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 0;
    select_mux_a <= 4'b0010; select_mux_b <= 2'b00; alu_sel <= 4'b0001;
    
    #10 //LDAC7
    inc_pc <= 0; write_pc <= 0; write_iar <= 0; inc_iar <= 0; write_idr <= 0; write_ir <= 0; write_tr <= 0;
    write_mar <= 0; write_dram <= 0; write1_mdr <= 0; write2_mdr <= 0; off_dram <= 0;
    write_ac <= 1;
    select_mux_a <= 4'b0000; select_mux_b <= 2'b00; alu_sel <= 4'b0000;
   
end

initial begin
    #140
    $finish;
end
endmodule
