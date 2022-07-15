
class example_test extends uvm_test;
  `uvm_component_utils(example_test)
  
  `DECL_ITEM_TYPE
  // typedef axis_xfer_item#(`BUS_WIDTH_PARAMS) axis_xfer_item_t;

  axis_agent#(bus_widths, axis_xfer_item_t) axis_agent_m_h; // master agent
  axis_agent#(bus_widths, axis_xfer_item_t) axis_agent_s_h; // slave agent
  axis_agent_cfg#(bus_widths, axis_xfer_item_t) agent_cfg_m_h;
  axis_agent_cfg#(bus_widths, axis_xfer_item_t) agent_cfg_s_h;

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

  endfunction
  

endclass