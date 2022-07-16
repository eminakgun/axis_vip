

class axis_base_seq #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_sequence #(ITEM_T);
  `uvm_object_param_utils(axis_base_seq#(`DEFAULT_CLS_PARAMS))
  `uvm_object_new

  axis_xfer_item#(`CLS_BUS_WIDTH_PARAMS) xfers[];

  rand uint num_of_xfers; 

  constraint n_xfer_c {
    num_of_xfers inside {[10:50]};
  }

  task body();
    `uvm_fatal(`gtn, "Need to override this when you extend from this class!")
  endtask

endclass