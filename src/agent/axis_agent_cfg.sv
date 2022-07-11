

class axis_agent_cfg extends uvm_objcet;

  bit is_active = 1'b1;   // active driver/sequencer or passive monitor
  bit has_cov   = 1'b1;   // enable coverage

  `uvm_object_utils_begin(axis_agent_cfg)
    `uvm_field_int (is_active, UVM_DEFAULT)
    `uvm_field_int (has_cov,   UVM_DEFAULT)
  `uvm_object_utils_end

  `uvm_object_new

endclass