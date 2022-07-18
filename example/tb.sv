

module tb;

  `include "axis_macros.svh"
  import uvm_pkg::*;
  import test_pkg::*;
  // import axis_agent_pkg::*;

  axis_if#(`BUS_WIDTH_PARAMS) axis_if();

  axis_master_bfm#(`BUS_WIDTH_PARAMS) master_bfm(axis_if);
  axis_slave_bfm#(`BUS_WIDTH_PARAMS) slave_bfm(axis_if);
  axis_monitor_bfm#(`BUS_WIDTH_PARAMS) monitor_bfm(axis_if);

  bit clk;
  initial begin
    forever begin
      clk = 0;
      #5ns;
      clk = 1;
      #5ns;
    end
  end
  assign axis_if.ACLK = clk;

  initial begin
    $timeformat(-9, 3, "ns");
    axis_if.initialize();

    // assign virtual interfaces
    master_bfm.pin_if = axis_if;
    slave_bfm.pin_if = axis_if;
    monitor_bfm.pin_if = axis_if;

    uvm_config_db#(virtual axis_master_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "master_bfm", master_bfm);
    uvm_config_db#(virtual axis_slave_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "slave_bfm", slave_bfm);
    uvm_config_db#(virtual axis_monitor_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "monitor_bfm", monitor_bfm);
    uvm_config_db#(uvm_bitstream_t)::set(null, "", "recording_detail", 0);
    run_test();
  end


endmodule