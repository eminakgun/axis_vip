`ifndef AXIS_MONITOR_SV
`define AXIS_MONITOR_SV

class axis_monitor #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_monitor;
    
  `uvm_component_param_utils(axis_monitor#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  axis_agent_cfg_t cfg_h;
  
  typedef ITEM_T ITEM_Q[$];
  uvm_analysis_port #(ITEM_T) xfer_analysis_port;
  uvm_analysis_port #(ITEM_Q) pckt_analysis_port;
  
  function void build_phase(uvm_phase phase);
    xfer_analysis_port = new("xfer_analysis_port", this);
    pckt_analysis_port = new("pckt_analysis_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    ITEM_T item; 
    forever begin
      item = ITEM_T::type_id::create("axis_xfer_item");
      cfg_h.monitor_bfm.collect_xfer(item);
      `uvm_info(`gfn, $sformatf("Captured xfer:\n %s", item.sprint()), UVM_DEBUG);
      xfer_analysis_port.write(item);
    end
  endtask

endclass

`endif