class async_fifo_sequence extends uvm_sequence#(async_fifo_seq_item);

  `uvm_object_utils(async_fifo_sequence)
  
  function new (string name = "async_fifo_sequence");
    super.new(name);
  endfunction
  
   task pre_body();
   if(starting_phase != null)
     starting_phase.raise_objection(this);
 endtask
  

 task body();
   repeat(500) begin
     `uvm_do(req);
    end
 endtask
  
 task post_body();  
   if(starting_phase != null)
     starting_phase.drop_objection(this);
 endtask

endclass
  