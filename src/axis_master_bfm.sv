`include "axis_macros.svh"
interface axis_master_bfm #(`DECL_BUS_WIDTH_PARAMS)(axis_if pin_if);
  `DECL_ITEM_TYPE

  task automatic send_xfer(input axis_xfer_item_t axi_item);
    // TODO
  endtask

endinterface