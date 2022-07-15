`include "axis_macros.svh"
interface axis_monitor_bfm #(`DECL_BUS_WIDTH_PARAMS)(axis_if pin_if);
  `DECL_ITEM_TYPE
  virtual axis_if#(`BUS_WIDTH_PARAMS) pin_if;
  task automatic collect_xfer(output axis_xfer_item_t axi_item);
    /* Boolean function,
      TREADY tready_en out
         0       0      1
         0       1      0
         1       0      1
         1       1      1
    */
    let tready_asserted = pin_if.monitor_cb.TREADY == 1'b1 || pin_if.pin_en.tready_en == 1'b0;
    wait(tready_asserted == 1'b1 && pin_if.monitor_cb.TVALID == 1'b1);
    register_lines(axi_item);
  endtask

  task register_lines(output axis_xfer_item_t axi_item);
    axi_item.tdata = pin_if.monitor_cb.TDATA;
    axi_item.tstrb = pin_if.monitor_cb.TSTRB;
    axi_item.tkeep = pin_if.monitor_cb.TKEEP;
    axi_item.tlast = pin_if.monitor_cb.TLAST;
    axi_item.tid   = pin_if.monitor_cb.TID;
    axi_item.tdest = pin_if.monitor_cb.TDEST;
    axi_item.tuser = pin_if.monitor_cb.TUSER;
  endtask


endinterface