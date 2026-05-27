import uvm_pkg::*;
`include "uvm_macros.svh"

class async_fifo_seq_item extends uvm_sequence_item;
  rand logic wr_en;
  rand logic [7:0] wr_data;
  rand logic rd_en;
  logic [7:0] rd_data;
  logic full;
  logic empty;
  
    `uvm_object_utils_begin(async_fifo_seq_item)
    `uvm_field_int(wr_en,UVM_DEFAULT)
  	`uvm_field_int(wr_data,UVM_DEFAULT)
  	`uvm_field_int(rd_en,UVM_DEFAULT)
  	`uvm_field_int(rd_data,UVM_DEFAULT)
  	`uvm_field_int(full,UVM_DEFAULT)
  	`uvm_field_int(empty,UVM_DEFAULT)
  `uvm_object_utils_end
  
  
  constraint no_wr_when_full_c {
    if(full) wr_en == 1'b0;
   }
  constraint no_rd_when_empty_c {
    if(empty) rd_en == 1'b0;
    }  
  
    function new(string name = "async_fifo_seq_item");
    super.new(name);
  endfunction:new
  
endclass