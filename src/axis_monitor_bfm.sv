`include "axis_macros.svh"
interface axis_monitor_bfm #(`DECL_BUS_WIDTH_PARAMS)();
  `DECL_ITEM_TYPE
  virtual axis_if#(`BUS_WIDTH_PARAMS) pin_if;
  task automatic collect_xfer(input axis_xfer_item_t axis_xfer_item);
    /* Boolean function,
      TREADY tready_en out
         0       0      1
         0       1      0
         1       0      1
         1       1      1
    */
    let tready_asserted = pin_if.monitor_cb.TREADY == 1'b1 || pin_if.pin_en.tready_en == 1'b0;
    wait(tready_asserted == 1'b1 && pin_if.monitor_cb.TVALID == 1'b1);
    register_lines(axis_xfer_item);
  endtask

  task automatic cycles(int unsigned n=1);
    repeat(n) @(pin_if.monitor_cb);
  endtask

  task register_lines(input axis_xfer_item_t axis_xfer_item);
    axis_xfer_item.tdata = pin_if.monitor_cb.TDATA;
    axis_xfer_item.tstrb = pin_if.monitor_cb.TSTRB;
    axis_xfer_item.tkeep = pin_if.monitor_cb.TKEEP;
    axis_xfer_item.tlast = pin_if.monitor_cb.TLAST;
    axis_xfer_item.tid   = pin_if.monitor_cb.TID;
    axis_xfer_item.tdest = pin_if.monitor_cb.TDEST;
    axis_xfer_item.tuser = pin_if.monitor_cb.TUSER;
  endtask

endinterface