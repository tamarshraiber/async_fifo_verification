class async_fifo_driver extends uvm_driver #(async_fifo_seq_item); 
  `uvm_component_utils (async_fifo_driver) 
  
  virtual async_fifo_if vif;
  
    function new (string name, uvm_component parent); 
      super.new (name, parent);
   endfunction
  
  virtual function void build_phase (uvm_phase phase); 
      super.build_phase (phase);
 	  if (!uvm_config_db#(virtual async_fifo_if)::get(this, "", "vif", vif)) begin
    `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface vif")
  end
    end
  endfunction 
  
 task run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    @(posedge vif.clk);
    if (vif.rst) begin
      vif.wr_en   <= 0;
      vif.rd_en   <= 0;
      vif.wr_data <= 0;
    end
    else begin
      drive_item(req);
    end
    seq_item_port.item_done();
  end
endtask
  
  
  
virtual task drive_item (async_fifo_seq_item req);
    vif.wr_en <= req.wr_en;
    vif.wr_data <= req.wr_data;
    vif.rd_en <= req.rd_en;

  
`uvm_info(get_type_name(),
  $sformatf("DRIVE >>> wr_en=%0b rd_en=%0b wr_data=0x%0h",
  req.wr_en, req.rd_en, req.wr_data),
  UVM_MEDIUM)

endtask
endclass
