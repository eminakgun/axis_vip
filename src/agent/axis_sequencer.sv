`ifndef AXIS_SEQUENCER_SV
`define AXIS_SEQUENCER_SV

class axis_sequencer #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_sequencer #(ITEM_T);
    
  `uvm_component_param_utils(axis_sequencer #(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

endclass

`endif