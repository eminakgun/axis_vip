`ifndef AXIS_MONITOR_SV
`define AXIS_MONITOR_SV

class axis_agent_cov #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_subscriber#(ITEM_T);
  
  `uvm_component_param_utils(axis_agent_cov#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  function void run_phase(uvm_phase phase);
  // TODO
  endfunction

endclass

`endif