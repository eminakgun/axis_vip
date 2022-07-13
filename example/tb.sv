

module tb;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import test_params_pkg::*;

  axis_if#(`BUS_WIDTH_PARAMS) axis_if();
  axis_master_bfm#(`BUS_WIDTH_PARAMS) master_bfm(axis_if);
  axis_slave_bfm#(`BUS_WIDTH_PARAMS) slave_bfm(axis_if);
  axis_monitor_bfm#(`BUS_WIDTH_PARAMS) monitor_bfm(axis_if);


  initial begin
    uvm_config_db#(virtual axis_master_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "master_bfm", master_bfm);
    uvm_config_db#(virtual axis_slave_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "master_bfm", slave_bfm);
    uvm_config_db#(virtual axis_monitor_bfm#(`BUS_WIDTH_PARAMS))::set(null, "*", "monitor_bfm", monitor_bfm);
    run_test("example_test");
  end


endmodule