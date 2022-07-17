
class example_test extends uvm_test;
  `uvm_component_utils(example_test)
  
  `DECL_ITEM_TYPE
  // typedef axis_xfer_item#(`BUS_WIDTH_PARAMS) axis_xfer_item_t;

  axis_agent#(bus_widths, axis_xfer_item_t) axis_agent_m_h; // master agent
  axis_agent#(bus_widths, axis_xfer_item_t) axis_agent_s_h; // slave agent
  axis_agent_cfg#(bus_widths, axis_xfer_item_t) agent_cfg_m_h;
  axis_agent_cfg#(bus_widths, axis_xfer_item_t) agent_cfg_s_h;

  axis_scoreboard#(bus_widths, axis_xfer_item_t) axis_scoreboard_h;
  axis_metric_analyzer#(bus_widths, axis_xfer_item_t) axis_metric_analyzer_h;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    // configuration
    agent_cfg_m_h = new("agent_cfg_m_h");
    agent_cfg_m_h.mode = AXIS_MASTER;

    agent_cfg_s_h = new("agent_cfg_s_h");
    agent_cfg_s_h.mode = AXIS_SLAVE;
    agent_cfg_s_h.has_mon = 1'b0; // 1 monitor is enough

    uvm_config_db#(axis_agent_cfg#(bus_widths, axis_xfer_item_t))::set(this, "axis_agent_m_h*", "axis_agent_cfg", agent_cfg_m_h);
    uvm_config_db#(axis_agent_cfg#(bus_widths, axis_xfer_item_t))::set(this, "axis_agent_s_h*", "axis_agent_cfg", agent_cfg_s_h);

    // create agents
    axis_agent_m_h = axis_agent#(bus_widths, axis_xfer_item_t)::type_id::create("axis_agent_m_h", this);
    axis_agent_s_h = axis_agent#(bus_widths, axis_xfer_item_t)::type_id::create("axis_agent_s_h", this);

    axis_scoreboard_h = axis_scoreboard#(bus_widths, axis_xfer_item_t)::type_id::create("axis_scoreboard_h", this);
    axis_metric_analyzer_h = axis_metric_analyzer#(bus_widths, axis_xfer_item_t)::type_id::create("axis_metric_analyzer_h", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    axis_agent_m_h.monitor_h.xfer_analysis_port.connect(axis_scoreboard_h.actual_fifo.analysis_export);
    axis_agent_m_h.driver_h.driver2sb_ap.connect(axis_scoreboard_h.expected_fifo.analysis_export);
    axis_agent_m_h.monitor_h.xfer_analysis_port.connect(axis_metric_analyzer_h.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    // `DECL_PARAM_CLS_TYPE(axis_full_rand_xfer_seq)
    typedef axis_full_rand_xfer_seq#(bus_widths, axis_xfer_item_t) axis_full_rand_xfer_seq_t;
    axis_full_rand_xfer_seq_t m_seq;
    axis_full_rand_xfer_seq_t s_seq;

    phase.raise_objection(this, $sformatf("%s objection raised", `gn));

    m_seq = axis_full_rand_xfer_seq_t::type_id::create("m_axi_full_rand_xfer_seq", this);
    s_seq = axis_full_rand_xfer_seq_t::type_id::create("s_axi_full_rand_xfer_seq", this);

    void'(std::randomize(m_seq.num_of_xfers) with { m_seq.num_of_xfers inside {[10:50]}; });
    s_seq.num_of_xfers = m_seq.num_of_xfers;
    `uvm_info(`gfn, $sformatf("Number of xfers to execute: %0d", m_seq.num_of_xfers), UVM_INFO);
    
    agent_cfg_m_h.master_bfm.pin_if.cycles(10); // let signals settle

    fork
      begin
        m_seq.start(axis_agent_m_h.sequencer_h);
        `uvm_info(`gfn, "End master sequence", UVM_INFO);
      end
      begin
        s_seq.start(axis_agent_s_h.sequencer_h);
        `uvm_info(`gfn, "End slave sequence", UVM_INFO);
      end
    join
    phase.drop_objection(this, $sformatf("%s objection dropped", `gn));
  endtask
  

endclass