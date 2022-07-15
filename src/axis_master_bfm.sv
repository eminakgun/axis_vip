`include "axis_macros.svh"
interface axis_master_bfm #(`DECL_BUS_WIDTH_PARAMS)();
  `DECL_ITEM_TYPE
  virtual axis_if#(`BUS_WIDTH_PARAMS) pin_if;
  task automatic send_xfer(input axis_xfer_item_t axi_item);
    if (pin_if.master_cb.TVALID == 1'b1) begin
      axi_item.xfer_succeed = 1'b0;
      wait_tready();
    end
    else begin
      if (pin_if.master_cb.TVALID != 1'b1) begin
        drive_source_data(axi_item);
        repeat(axi_item.tvalid_delay) @pin_if.master_cb;
        drive_tvalid(1'b1); // assert tvalid
        @pin_if.master_cb;
      end
    
      wait_tready();
      axi_item.xfer_succeed = 1'b1;
    end

    // deassert
    drive_tvalid(!axi_item.deassert_tvalid);
  endtask

  task drive_tvalid(logic value);
    `DRIVE(master_cb, TVALID, value, 1'b1)
  endtask

  task automatic wait_tready();
    if (pin_if.pin_en.tready_en)
      wait(pin_if.master_cb.TREADY == 1'b1);
  endtask

  task drive_source_data(input axis_xfer_item_t axi_item);
    `DRIVE(master_cb, TDATA, axi_item.tdata, pin_if.pin_en.tdata_en);
    `DRIVE(master_cb, TSTRB, axi_item.tstrb, pin_if.pin_en.tstrb_en);
    `DRIVE(master_cb, TKEEP, axi_item.tkeep, pin_if.pin_en.tkeep_en);
    `DRIVE(master_cb, TLAST, axi_item.tlast, pin_if.pin_en.tlast_en);
    `DRIVE(master_cb, TID, axi_item.tid, pin_if.pin_en.tid_en);
    `DRIVE(master_cb, TDEST, axi_item.tdest, pin_if.pin_en.tdest_en);
    `DRIVE(master_cb, TUSER, axi_item.tuser, pin_if.pin_en.tuser_en);
  endtask


endinterface