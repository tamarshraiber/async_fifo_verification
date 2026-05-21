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
  logic [7:0] mem [0:15];
  logic [4:0] w_ptr;
  logic [4:0] r_ptr;
  
  always@(posedge clk or negedge rst) begin
    if(!rst) begin
      w_ptr <= 0;
      r_ptr <= 0;
    end
    
    else begin
      if(wr_en && !full) begin
        mem[w_ptr[3:0]] <= wr_data;
      	w_ptr <= w_ptr+1;
    end
    
      if(rd_en && !empty) begin
      	r_ptr <= r_ptr+1;    
    end
      
    end
    
  end
  
  assign rd_data = mem[r_ptr[3:0]];
  assign empty = (w_ptr == r_ptr);
  assign full  = (w_ptr[3:0] == r_ptr[3:0]) && (w_ptr[4] != r_ptr[4]);  
  
endmodule