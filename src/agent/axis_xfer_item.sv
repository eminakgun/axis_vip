`ifndef AXIS_XFER_ITEM_SVH
`define AXIS_XFER_ITEM_SVH

class axis_xfer_item #(uint `BUS_WIDTH_PARAMS) extends uvm_sequence_item;
  `uvm_object_param_utils(axis_xfer_item #(`BUS_WIDTH_PARAMS))
  `DECL_KEEP_STRB_W

  rand logic [DATA_W-1:0] tdata;
  rand logic [KEEP_STRB_W-1:0] tstrb;
  rand logic [KEEP_STRB_W-1:0] tkeep;
  rand logic [ID_W-1:0] tid;
  rand logic [DEST_W-1:0] tdest;
  rand logic [USER_W-1:0] tuser;
  rand logic tlast;

  rand axi_xfer_byte_type_e byte_type[KEEP_STRB_W-1:0];

  rand int tvalid_delay; 
  rand int tready_delay;

  `uvm_object_new

  constraint valid_ready_common_c {
    tvalid_delay inside {[1:10]};
    tready_delay inside {[1:10]};
  }

  constraint disable_illegal_byte_c {
    foreach(byte_type[i]) {
      byte_type[i] != AXIS_RESERVED_BYTE;
    }
  }

  constraint keep_stobe_common_c {
    foreach(byte_type[i]) {
      byte_type[i] == AXIS_DATA_BYTE     -> tkeep[i] == 1'b1 && tstrb[i] == 1'b1;
      byte_type[i] == AXIS_POS_BYTE      -> tkeep[i] == 1'b1 && tstrb[i] == 1'b0;
      byte_type[i] == AXIS_NULL_BYTE     -> tkeep[i] == 1'b0 && tstrb[i] == 1'b0;
      byte_type[i] == AXIS_RESERVED_BYTE -> tkeep[i] == 1'b0 && tstrb[i] == 1'b1;
    }  
  }

endclass


`endif