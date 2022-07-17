`ifndef AXIS_AGENT_SV
`define AXIS_AGENT_SV

class axis_scoreboard#(`DEFAULT_CLS_PARAM_ARGS) extends uvm_scoreboard;

  `uvm_component_param_utils(axis_scoreboard#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  `DECL_ITEM_TYPE

  uvm_tlm_analysis_fifo#(axis_xfer_item_t) actual_fifo;
  uvm_tlm_analysis_fifo#(axis_xfer_item_t) expected_fifo;

  axis_xfer_item_t actual_item;
  axis_xfer_item_t expected_item;

  function void build_phase(uvm_phase phase);
    actual_fifo = new("actual_fifo", this);
    expected_fifo = new("expected_fifo", this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      actual_fifo.get(actual_item);
      expected_fifo.get(expected_item);

      if (!actual_item.compare(expected_item)) begin
        `uvm_error(`gfn, $sformatf("actual_item:\n%s\n does not match\n expected_item:\n%s", 
                                    actual_item.sprint(), expected_item.sprint()));
      end
      else
        `uvm_info(`gfn, "Actual item matches expected!", UVM_DEBUG);
    end  

  endtask 

endclass

`endif