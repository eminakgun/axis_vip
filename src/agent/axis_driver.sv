`ifndef AXIS_DRIVER_SV
`define AXIS_DRIVER_SV

class axis_driver #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_driver#(ITEM_T);
  `uvm_component_param_utils(axis_driver#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new
  
  axi_agent_mode_e mode;
  virtual master_bfm #(`CLS_BUS_WIDTH_PARAMS) m_bfm;
  virtual slave_bfm #(`CLS_BUS_WIDTH_PARAMS) s_bfm;
  
  task run_phase(uvm_phase phase);
    // TODO
  endtask

endclass 

`endif