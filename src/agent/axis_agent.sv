`ifndef AXIS_AGENT_SV
`define AXIS_AGENT_SV

class axis_agent #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_agent;
  
  `uvm_component_param_utils(axis_agent#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new
  
  `DECL_PARAM_CLS_TYPE(axis_agent_cov)
  `DECL_PARAM_CLS_TYPE(axis_driver)
  `DECL_PARAM_CLS_TYPE(axis_sequencer)
  `DECL_PARAM_CLS_TYPE(axis_monitor)

  axis_agent_cfg    cfg_h;
  axis_agent_cov_t  cov_h;
  axis_driver_t     driver_h;
  axis_sequencer_t  sequencer_h;
  axis_monitor_t    monitor_h;

  function void build_phase(uvm_phase phase);
    // get agent_cfg object from uvm_config_db
    if (!uvm_config_db#(axis_agent_cfg)::get(this, "", "axis_agent_cfg", cfg_h)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get %s from uvm_config_db", cfg_h.get_type_name()))
    end
    `uvm_info(`gfn, $sformatf("\n%0s", cfg_h.sprint()), UVM_HIGH)

    // create components
    if (cfg_h.has_cov) begin
      cov_h = axis_agent_cov_t::type_id::create("cov", this);
    end

    monitor_h = axis_monitor_t::type_id::create("monitor", this);

    if (cfg_h.is_active) begin
      sequencer_h = axis_sequencer_t::type_id::create("sequencer", this);
      driver_h = axis_driver_t::type_id::create("driver", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    if (cfg_h.is_active) begin
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
    end
    if (cfg_h.has_cov) begin
      monitor_h.analysis_port.connect(cov_h.analysis_export);
    end
  endfunction

endclass

`endif