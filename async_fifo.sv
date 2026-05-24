//------------------------------------------------------------
// Async FIFO (WIP)
// - Next step: write/read logic
// - CDC sync + gray pointers not implemented yet
//------------------------------------------------------------
//async_fifo_verification




module regular_fifo(
  input logic clk,
  input logic rst,
  input logic wr_en, 
  input logic [7:0] wr_data,
  input logic rd_en,
  output logic [7:0] rd_data,
  output logic full,
  output logic empty
);
  localparam DEPTH   = 16;
  localparam PTR_W   = 5;
  
  logic [7:0] mem [0:DEPTH-1];
  logic [PTR_W-1:0] w_ptr;
  logic [PTR_W-1:0] r_ptr;
  
  always_ff @(posedge clk or negedge rst) begin
     if (!rst) begin
      w_ptr   <= '0;
      r_ptr   <= '0;
      rd_data <= '0;

    end else begin
      
      
    case ({wr_en, rd_en})
  		2'b10: begin
    		if (!full) begin
      			mem[w_ptr[3:0]] <= wr_data;
     			w_ptr <= w_ptr + 1;
    		end
  		end

  		2'b01: begin
    		if (!empty) begin
      			rd_data <= mem[r_ptr[3:0]];
      			r_ptr   <= r_ptr + 1;
    		end
  		end

  		2'b11: begin
    		if (!empty && !full) begin
      			mem[w_ptr[3:0]] <= wr_data;
      			w_ptr <= w_ptr + 1;

      			rd_data <= mem[r_ptr[3:0]];
      			r_ptr   <= r_ptr + 1;
    		end
  		end
      default: ;
endcase

    end
    
  end
  
  assign empty = (w_ptr == r_ptr);
  assign full  = (w_ptr[PTR_W-2:0] == r_ptr[PTR_W-2:0]) && (w_ptr[PTR_W-1] != r_ptr[PTR_W-1]);  
  
endmodule
  