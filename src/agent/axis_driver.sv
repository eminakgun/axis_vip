`ifndef AXIS_DRIVER_SV
`define AXIS_DRIVER_SV

class axis_driver #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_driver#(ITEM_T);
  `uvm_component_param_utils(axis_driver#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new
  
  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  axis_agent_cfg_t cfg_h;
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(`gfn, $sformatf("Next xfer item:\n %s", req.sprint()), UVM_DEBUG);
      if (cfg_h.mode == AXIS_MASTER)
        cfg_h.master_bfm.send_xfer(req);
      else
        cfg_h.slave_bfm.recv_xfer(req);
      seq_item_port.item_done();
    end
  endtask

endclass 

`endif