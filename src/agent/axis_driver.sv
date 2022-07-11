

class axis_driver #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_driver#(ITEM_T);
  `uvm_component_param_utils(axis_driver#(bus_widths, ITEM_T))
  `uvm_component_new
  
  axi_agent_mode_e mode;
  master_bfm #(`CLS_BUS_WIDTH_PARAMS) m_bfm;
  slave_bfm #(`CLS_BUS_WIDTH_PARAMS) s_bfm;
  
  function void run_phase(uvm_phase phase);
    // TODO
  endfunction

endclass 