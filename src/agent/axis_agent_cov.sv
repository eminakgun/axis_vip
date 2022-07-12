`ifndef AXIS_AGENT_COV_SV
`define AXIS_AGENT_COV_SV

class axis_agent_cov #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_subscriber#(ITEM_T);
  
  `uvm_component_param_utils(axis_agent_cov#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  function void write(ITEM_T t);

  endfunction

endclass

`endif