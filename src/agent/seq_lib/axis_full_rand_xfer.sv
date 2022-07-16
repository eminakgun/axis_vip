
class axis_full_rand_xfer_seq #(`DEFAULT_CLS_PARAM_ARGS) extends axis_base_seq#(`DEFAULT_CLS_PARAMS);
  
  `uvm_object_param_utils(axis_full_rand_xfer_seq#(`DEFAULT_CLS_PARAMS))
  `uvm_object_new

  task body();
    ITEM_T item;
    for (uint i = 0; i <= num_of_xfers; i++) begin
      `uvm_info(`gfn, $sformatf("Starting seq: %0d", i), UVM_HIGH)
      item = ITEM_T::type_id::create("axis_xfer_item");
      start_item(item);
      `DV_CHECK_RANDOMIZE_FATAL(item)
      finish_item(item);
    end
  endtask

endclass