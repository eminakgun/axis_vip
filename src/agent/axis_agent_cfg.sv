

class axis_agent_cfg#(`DEFAULT_CLS_PARAM_ARGS) extends uvm_object;

  bit is_active = 1'b1;   // active driver/sequencer or passive monitor
  bit has_cov   = 1'b1;   // enable coverage
  bit has_mon   = 1'b1;   // enable monitor
  axi_agent_mode_e mode;
  pin_en_t pin_en;

  virtual axis_master_bfm #(`CLS_BUS_WIDTH_PARAMS) master_bfm;
  virtual axis_slave_bfm #(`CLS_BUS_WIDTH_PARAMS) slave_bfm;
  virtual axis_monitor_bfm #(`CLS_BUS_WIDTH_PARAMS) monitor_bfm;

  `uvm_object_utils_begin(axis_agent_cfg#(`DEFAULT_CLS_PARAMS))
    `uvm_field_int (is_active,              UVM_DEFAULT)
    `uvm_field_int (has_cov,                UVM_DEFAULT)
    `uvm_field_enum(axi_agent_mode_e, mode, UVM_DEFAULT)
    //`uvm_field_int(pin_en,    UVM_DEFAULT)
  `uvm_object_utils_end

  `uvm_object_new

endclass