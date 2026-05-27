typedef class async_fifo_env;
  
  class async_fifo_data_sequence extends uvm_sequence#(async_fifo_seq_item);
    
    `uvm_object_utils(async_fifo_data_sequence);
    
    function new(string name="async_fifo_data_sequence");
      super.new(name);
    endfunction
    
    task body();
      req = async_fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    endtask
    
  endclass
  
    class async_fifo_virtual_sequence extends uvm_sequence;
      `uvm_object_utils(async_fifo_virtual_sequence);
      
      async_fifo_data_sequence data_seq;
      uvm_sequencer #(async_fifo_seq_item) seqr;
      
    function new(string name="async_fifo_virtual_sequence");
      super.new(name);
    endfunction

 
      task body();
        data_seq =
      async_fifo_data_sequence::type_id::create("data_seq");

    repeat (500) begin
      data_seq.start(seqr);
         end
      endtask

endclass        

     
      
      
      
  