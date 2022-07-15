
package test_pkg;

  `ifndef DATA_W
    parameter int unsigned DATA_W = 16;
  `else
    parameter int unsigned DATA_W = `DATA_W;
  `endif

  `ifndef ID_W
    parameter int unsigned ID_W = 8;
  `else
    parameter int unsigned ID_W = `ID_W;
  `endif

  `ifndef DEST_W
    parameter int unsigned DEST_W = 4;
  `else
    parameter int unsigned DEST_W = `DEST_W;
  `endif

  `ifndef USER_W
    parameter int unsigned USER_W = 2;
  `else
    parameter int unsigned USER_W = `USER_W;
  `endif

  parameter axis_agent_pkg::bus_widths_t bus_widths = '{DATA_W: DATA_W, ID_W: ID_W, DEST_W: DEST_W, USER_W: USER_W};

  import uvm_pkg::*;
  import axis_agent_pkg::*;
  `include "uvm_macros.svh"
  `include "axis_macros.svh"
  `include "dv_macros.svh"

  `include "test.sv"

endpackage