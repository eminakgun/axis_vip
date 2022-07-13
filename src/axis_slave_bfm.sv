`include "axis_macros.svh"
interface axis_slave_bfm #(`DECL_BUS_WIDTH_PARAMS)(axis_if pin_if);
  `DECL_ITEM_TYPE

  task automatic recv_xfer(output axis_xfer_item_t axi_item);
    // TODO
  endtask  

endinterface