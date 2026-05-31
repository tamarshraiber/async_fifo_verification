class async_fifo_monitor extends uvm_monitor;
  `uvm_component_utils (async_fifo_monitor)
  
  virtual async_fifo_if vif;
//   bit enable_check = 1;
  
  uvm_analysis_port #(async_fifo_seq_item) mon_analysis_port_in;
  uvm_analysis_port #(async_fifo_seq_item) mon_analysis_port_out;
  
//   async_fifo_seq_item item_out;
//   async_fifo_seq_item item_in;
  
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    mon_analysis_port_in = new("mon_analysis_port_in", this);
    mon_analysis_port_out = new("mon_analysis_port_out", this);

    
    if(!uvm_config_db #(virtual async_fifo_if)::get(this, "", "vif", vif))begin
      `uvm_error(get_type_name(), "DUT interface not found")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    fork
      forever begin
        @(posedge vif.clk);
        if(vif.wr_en && !vif.full && vif.rst) begin
          async_fifo_seq_item tx;

          tx = async_fifo_seq_item::type_id::create("tx_wr");

          tx.wr_en   = vif.wr_en;
          tx.wr_data = vif.wr_data;

          mon_analysis_port_in.write(tx);
        end
      end
      
      forever begin
        @(posedge vif.clk);
        if(vif.rd_en && !vif.empty && vif.rst) begin
          async_fifo_seq_item tx;

          tx = async_fifo_seq_item::type_id::create("tx_rd");

          tx.rd_en   = vif.rd_en;
          tx.rd_data = vif.rd_data;

          mon_analysis_port_out.write(tx);
        end
      end
    join_none
  endtask
endclass
  
  




