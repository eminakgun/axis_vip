`include "axis_macros.svh"
`include "uvm_macros.svh"

interface axis_slave_bfm #(`DECL_BUS_WIDTH_PARAMS)();
  `DECL_ITEM_TYPE
  virtual axis_if#(`BUS_WIDTH_PARAMS) pin_if;
  import uvm_pkg::*;
  `define BFM_NAME "axis_slave_bfm"

  task automatic recv_xfer(input axis_xfer_item_t axis_xfer_item);
    if (pin_if.pin_en.tready_en) begin
      if(axis_xfer_item.toggle_tready)
        toggle_tready(axis_xfer_item.toggle_delay);
      if (pin_if.slave_cb.TREADY != 1'b1) // TREADY might be asserted after toggling
        assert_tready(axis_xfer_item);
        `uvm_info(`BFM_NAME, "asserted TREADY", UVM_DEBUG);
    end
    `uvm_info(`BFM_NAME, "waiting TVALID to be asserted", UVM_DEBUG);
    wait(pin_if.slave_cb.TVALID == 1'b1);

    register_source_data(axis_xfer_item);

    // deassert
    drive_tready(!axis_xfer_item.deassert_tready);
    @pin_if.slave_cb;
  endtask  

  function automatic void drive_tready(logic value);
    `DRIVE(slave_cb, TREADY, value, pin_if.pin_en.tready_en)
  endfunction

  task register_source_data(input axis_xfer_item_t axis_xfer_item);
    axis_xfer_item.tdata = pin_if.slave_cb.TDATA;
    axis_xfer_item.tstrb = pin_if.slave_cb.TSTRB;
    axis_xfer_item.tkeep = pin_if.slave_cb.TKEEP;
    axis_xfer_item.tlast = pin_if.slave_cb.TLAST;
    axis_xfer_item.tid = pin_if.slave_cb.TID;
    axis_xfer_item.tdest = pin_if.slave_cb.TDEST;
    axis_xfer_item.tuser = pin_if.slave_cb.TUSER;
  endtask

  task assert_tready(input axis_xfer_item_t axis_xfer_item);
    if (axis_xfer_item.wait_tvalid_asserted)
      wait(pin_if.slave_cb.TVALID == 1'b1);
    repeat(axis_xfer_item.tvalid_delay) @pin_if.slave_cb;
    drive_tready(1'b1);
    @pin_if.slave_cb;
  endtask

  task toggle_tready(input int unsigned toggle_delay[]);
    fork 
      begin : ISO_FORK
        fork
          begin : TOGGLE_THREAD
            foreach(toggle_delay[i]) begin : TOGGLE_LOOP
              repeat(toggle_delay[i]) @pin_if.slave_cb;
              drive_tready(!pin_if.slave_cb.TREADY);
              @pin_if.slave_cb;
            end : TOGGLE_LOOP
          end : TOGGLE_THREAD
          begin : WAIT_TVALID_THREAD
            wait(pin_if.slave_cb.TVALID == 1'b1); // join whenever TVALID is asserted
          end : WAIT_TVALID_THREAD
        join_any
        disable fork;
      end : ISO_FORK
    join
  endtask

  `undef BFM_NAME
endinterface