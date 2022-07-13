`ifndef AXIS_AGENT_SV
`define AXIS_AGENT_SV

class axis_agent #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_agent;
  
  `uvm_component_param_utils(axis_agent#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new
  
  `DECL_PARAM_CLS_TYPE(axis_agent_cfg)
  `DECL_PARAM_CLS_TYPE(axis_agent_cov)
  `DECL_PARAM_CLS_TYPE(axis_driver)
  `DECL_PARAM_CLS_TYPE(axis_sequencer)
  `DECL_PARAM_CLS_TYPE(axis_monitor)

  axis_agent_cfg_t  cfg_h;
  axis_agent_cov_t  cov_h;
  axis_driver_t     driver_h;
  axis_sequencer_t  sequencer_h;
  axis_monitor_t    monitor_h;

  function void build_phase(uvm_phase phase);
    // get agent_cfg object from uvm_config_db
    if (!uvm_config_db#(axis_agent_cfg_t)::get(this, "", "axis_agent_cfg", cfg_h)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get from uvm_config_db"))
    end
    `uvm_info(`gfn, $sformatf("\n%0s", cfg_h.sprint()), UVM_HIGH)

    if (cfg_h.mode == AXIS_MASTER)
      if(!uvm_config_db#(virtual axis_master_bfm#(`CLS_BUS_WIDTH_PARAMS))::get(this, "", "master_bfm", cfg_h.master_bfm)) begin
        `uvm_error(`gfn, "Unable to find virtual interface master_bfm in the uvm_config_db")
      end
    else
      if(!uvm_config_db#(virtual axis_slave_bfm#(`CLS_BUS_WIDTH_PARAMS))::get(this, "", "slave_bfm", cfg_h.slave_bfm)) begin
        `uvm_error(`gfn, "Unable to find virtual interface slave_bfm in the uvm_config_db")
      end

    // create components
    if (cfg_h.has_cov) begin
      cov_h = axis_agent_cov_t::type_id::create("cov", this);
      cov_h.cfg_h = cfg_h;
    end

    if (cfg_h.has_mon) begin
      if(!uvm_config_db#(virtual axis_monitor_bfm#(`CLS_BUS_WIDTH_PARAMS))::get(this, "", "monitor_bfm", cfg_h.monitor_bfm)) begin
        `uvm_error(`gfn, "Unable to find virtual interface master_bfm in the uvm_config_db")
      end

      monitor_h = axis_monitor_t::type_id::create("monitor", this);
      monitor_h.cfg_h = cfg_h;
    end

    if (cfg_h.is_active) begin
      sequencer_h = axis_sequencer_t::type_id::create("sequencer", this);
      driver_h = axis_driver_t::type_id::create("driver", this);
      driver_h.cfg_h = cfg_h;
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    if (cfg_h.is_active) begin
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
    end
    if (cfg_h.has_cov && cfg_h.has_mon) begin
      monitor_h.analysis_port.connect(cov_h.analysis_export);
    end
  endfunction

  function void compliance_checks();
    // check pin enable bits
    if (cfg_h.pin_en.tdata_en == 1'b0)
      `DV_CHECK_EQ(cfg_h.pin_en.tstrb_en, 1'b0)
  endfunction

endclass

`endif