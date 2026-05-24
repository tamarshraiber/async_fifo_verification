
import uvm_pkg::*;
`include "async_fifo_pkg.sv"

module async_fifo_tb;
  bit clk=0;
  always #5 clk = ~clk;
  
  bit rst;
  initial begin
    rst = 0;
    #20;
    rst = 1;
  end
  
  async_fifo_if async_fifo_if_i();
  assign async_fifo_if_i.clk = clk;
  assign async_fifo_if_i.rst = rst;
  
  async_fifo async_fifo_dut(
    .clk(async_fifo_if_i.clk),
    .rst(async_fifo_if_i.rst),
    .wr_en(async_fifo_if_i.wr_en),
    .wr_data(async_fifo_if_i.wr_data),
    .rd_en(async_fifo_if_i.rd_en),
    .rd_data(async_fifo_if_i.rd_data),
    .full(async_fifo_if_i.full),
    .empty(async_fifo_if_i.empty)
  );
  
  
  initial begin
  uvm_config_db#(virtual async_fifo_if)::set(
    null,"*","async_fifo_if_i",async_fifo_if_i
  );
    
  $dumpfile("dump.vcd");
  $dumpvars(0, async_fifo_tb);
  end
  
initial begin
  async_fifo_if_i.wr_en   = 0;
  async_fifo_if_i.rd_en   = 0;
  async_fifo_if_i.wr_data = 0;

end
  
  initial begin 
  run_test("async_fifo_test");
    #1000;
end
  
endmodule