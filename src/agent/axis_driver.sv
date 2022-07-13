`ifndef AXIS_DRIVER_SV
`define AXIS_DRIVER_SV

class axis_driver #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_driver#(ITEM_T);
  `uvm_component_param_utils(axis_driver#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new
  
  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  axis_agent_cfg_t cfg_h;
  
  task run_phase(uvm_phase phase);
    // TODO
  endtask

endclass 

`endif