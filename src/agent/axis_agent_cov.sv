`ifndef AXIS_AGENT_COV_SV
`define AXIS_AGENT_COV_SV

class axis_agent_cov #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_subscriber#(ITEM_T);
  
  `uvm_component_param_utils(axis_agent_cov#(`DEFAULT_CLS_PARAMS))

  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  axis_agent_cfg_t cfg_h;


  covergroup axis_xfer_item_cg(string name, pin_en_t pin_en) with function sample(ITEM_T axis_xfer_item);
    option.name = name;

    cp_tdata: coverpoint axis_xfer_item.tdata {
      option.weight = pin_en.tdata_en;
    }
    cp_tstrb: coverpoint axis_xfer_item.tstrb {
      option.weight = pin_en.tstrb_en;
    }
    cp_tkeep: coverpoint axis_xfer_item.tkeep {
      option.weight = pin_en.tkeep_en;
    }
    cp_tid: coverpoint axis_xfer_item.tid {
      option.weight = pin_en.tid_en;
    }
    cp_tdest: coverpoint axis_xfer_item.tdest {
      option.weight = pin_en.tdest_en;
    }
    cp_tuser: coverpoint axis_xfer_item.tuser {
      option.weight = pin_en.tuser_en;
    }

    cross_all: cross cp_tdata, cp_tstrb, cp_tkeep, cp_tid, cp_tdest, cp_tuser;
  endgroup : axis_xfer_item_cg

  function new(string name, uvm_component parent);
    super.new(name, parent);
    
    if (!uvm_config_db#(axis_agent_cfg_t)::get(this, "", "axis_agent_cfg", cfg_h)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get axis_agent_cfg from uvm_config_db"))
    end

    axis_xfer_item_cg = new("axis_xfer_item_cg_inst", cfg_h.pin_en);
  endfunction : new

  function void write(ITEM_T t);
    axis_xfer_item_cg.sample(t);
  endfunction

endclass

`endif