`ifndef AXIS_MONITOR_SV
`define AXIS_MONITOR_SV

class axis_monitor #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_monitor;
    
  `uvm_component_param_utils(axis_monitor#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  axis_agent_cfg_t cfg_h;
  
  uvm_analysis_port #(ITEM_T) analysis_port;
  
  function void build_phase(uvm_phase phase);
    analysis_port = new("analysis_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    // TODO
  endtask

endclass

`endif