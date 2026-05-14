//------------------------------------------------------------
// Async FIFO (WIP)
// - Next step: write/read logic
// - CDC sync + gray pointers not implemented yet
//------------------------------------------------------------
//async_fifo_verification


module async_fifo #(
  parameter DATA_WIDTH = 8,
  parameter FIFO_DEPTH  = 16)(
  input logic wr_clk,
  input logic wr_rst_n,
  input logic wr_en,
  input  logic [DATA_WIDTH-1:0] data_in,
  input logic rd_clk,
  input logic rd_rst_n,
  input logic rd_en,
  output logic [DATA_WIDTH-1:0] data_out,
  output logic empty,
  output logic full
);
  localparam PTR_WIDTH = $clog2(FIFO_DEPTH);
  logic [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
  logic [PTR_WIDTH:0] wr_ptr_bin;
  logic [PTR_WIDTH:0] rd_ptr_bin;
  logic [PTR_WIDTH:0] wr_ptr_gray;
  logic [PTR_WIDTH:0] rd_ptr_gray;

endmodule