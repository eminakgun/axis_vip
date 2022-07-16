`ifndef AXIS_XFER_ITEM_SVH
`define AXIS_XFER_ITEM_SVH

class axis_xfer_item #(uint `BUS_WIDTH_PARAMS) extends uvm_sequence_item;
  // `uvm_object_param_utils(axis_xfer_item #(`BUS_WIDTH_PARAMS))
  `DECL_KEEP_STRB_W

  rand logic [DATA_W-1:0] tdata;
  rand logic [KEEP_STRB_W-1:0] tstrb;
  rand logic [KEEP_STRB_W-1:0] tkeep;
  rand logic [ID_W-1:0] tid;
  rand logic [DEST_W-1:0] tdest;
  rand logic [USER_W-1:0] tuser;
  rand logic tlast;

  // control
  rand axi_xfer_byte_type_e byte_type[KEEP_STRB_W-1:0];
  bit xfer_result;

  // master bfm
  rand uint source_data_delay;
  rand uint tvalid_delay;
  rand bit deassert_tvalid;

  // slave bfm
  rand uint tready_delay;
  rand bit deassert_tready;
  rand bit wait_tvalid_asserted;
  // TREADY can deassert until tvalid is asserted, see Handshake process in Spec 2.2.1 
  rand bit toggle_tready;
  rand uint toggle_delay[3];

  constraint always_deassert_c {
    deassert_tvalid == 1'b1;
    deassert_tready == 1'b1;
  }

  constraint disable_tready_toggle_c {
    toggle_tready == 1'b0;
  }

  constraint valid_ready_common_c {
    tvalid_delay inside {[1:10]};
    source_data_delay <= tvalid_delay; 
    tready_delay inside {[1:10]};
    foreach(toggle_delay[i])
      toggle_delay[i] inside {[0:10]};
  }

  constraint disable_illegal_byte_c {
    foreach(byte_type[i]) {
      byte_type[i] != AXIS_RESERVED_BYTE;
    }
  }

  constraint keep_strobe_common_c {
    foreach(byte_type[i]) {
      byte_type[i] == AXIS_DATA_BYTE     -> tkeep[i] == 1'b1 && tstrb[i] == 1'b1;
      byte_type[i] == AXIS_POS_BYTE      -> tkeep[i] == 1'b1 && tstrb[i] == 1'b0;
      byte_type[i] == AXIS_NULL_BYTE     -> tkeep[i] == 1'b0 && tstrb[i] == 1'b0;
      byte_type[i] == AXIS_RESERVED_BYTE -> tkeep[i] == 1'b0 && tstrb[i] == 1'b1;
    }  
  }

  `uvm_object_new

  `uvm_object_param_utils_begin(axis_xfer_item #(`BUS_WIDTH_PARAMS))
    `uvm_field_int(tdata,                 UVM_DEFAULT)
    `uvm_field_int(tstrb,                 UVM_DEFAULT)
    `uvm_field_int(tkeep,                 UVM_DEFAULT)
    `uvm_field_int(tid,                   UVM_DEFAULT)
    `uvm_field_int(tdest,                 UVM_DEFAULT)
    `uvm_field_int(tuser,                 UVM_DEFAULT)
    `uvm_field_int(tlast,                 UVM_DEFAULT)
    `uvm_field_int(xfer_result,           UVM_DEFAULT)
    `uvm_field_int(source_data_delay,     UVM_DEFAULT)
    `uvm_field_int(tvalid_delay,          UVM_DEFAULT)
    `uvm_field_int(deassert_tvalid,       UVM_DEFAULT)
    `uvm_field_int(tready_delay,          UVM_DEFAULT)
    `uvm_field_int(deassert_tready,       UVM_DEFAULT)
    `uvm_field_int(wait_tvalid_asserted,  UVM_DEFAULT)
    `uvm_field_int(toggle_tready,         UVM_DEFAULT)
  `uvm_object_utils_end

endclass


`endif