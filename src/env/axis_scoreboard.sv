
class axis_scoreboard#(`DEFAULT_CLS_PARAM_ARGS) extends uvm_scoreboard;

  `uvm_component_param_utils(axis_scoreboard#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  `DECL_ITEM_TYPE

  uvm_tlm_analysis_fifo#(axis_xfer_item_t) actual_fifo;
  uvm_tlm_analysis_fifo#(axis_xfer_item_t) expected_fifo;

  axis_xfer_item_t actual_item;
  axis_xfer_item_t expected_item;

  task run_phase(uvm_phase phase);
    forever begin
      actual_fifo.get(actual_item);
      expected_fifo.get(expected_item);

      if (!actual_item.compare(expected_item)) begin
        `uvm_error();
      end
    end  

  endtask 

endclass 
