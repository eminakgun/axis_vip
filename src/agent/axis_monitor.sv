`ifndef AXIS_MONITOR_SV
`define AXIS_MONITOR_SV

class axis_monitor #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_monitor;
    
  `uvm_component_param_utils(axis_monitor#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  protected uvm_analysis_port #(ITEM_T) analysis_port;
  monitor_bfm #(`CLS_BUS_WIDTH_PARAMS) bfm;
  
  function void build_phase(uvm_phase phase);
    analysis_port = new("analysis_port", this);
  endfunction

  function void run_phase(uvm_phase phase);
    // TODO
  endfunction

endclass

`endif