interface async_fifo_if();
  bit clk;
  bit rst;
  bit wr_en;
  bit [7:0] wr_data;
  bit rd_en;
  bit [7:0] rd_data;
  bit full;
  bit empty;
  
endinterface: async_fifo_if