`include "axis_macros.svh"

interface axis_if #(`DECL_BUS_WIDTH_PARAMS)();

  `DECL_KEEP_STRB_W

  logic ACLK;
  logic ARESETn;
  logic TVALID;
  logic TREADY;
  logic [DATA_W-1:0] TDATA;
  logic [KEEP_STRB_W-1:0] TSTRB;
  logic [KEEP_STRB_W-1:0] TKEEP;
  logic TLAST;
  logic [ID_W-1:0] TID;
  logic [DEST_W-1:0] TDEST;
  logic [USER_W-1:0] TUSER;

  clocking master_cb @(posedge ACLK);
    default input #1step output #1ns;
    input ARESETn, TREADY;
    output TLAST, TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
    input output TVALID;
  endclocking

  clocking slave_cb @(posedge ACLK);
    default input #1step output #1ns;
    input ARESETn, TVALID, TLAST, TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
    input output TREADY;
  endclocking

  clocking monitor_cb @(posedge ACLK);
    default input #1step;
    input ARESETn, TVALID, TREADY, TLAST,
    TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
  endclocking

  task automatic cycles(int unsigned n);
    repeat(n) @(posedge ACLK);
  endtask

  axis_agent_pkg::pin_en_t pin_en;

  function void set_pin_en(axis_agent_pkg::pin_en_t new_pin_en);
    pin_en = new_pin_en;
  endfunction

  // task automatic drive(ref logic sig, input bit en, logic value);
  //   if (en) sig = value;
  // endtask

  // Default value assignment
  initial begin
    forever begin
      if (pin_en.tready_en == 1'b0) TREADY = 1'b1;
      @(pin_en.tready_en || pin_en.tkeep_en || pin_en.tstrb_en || pin_en.tlast_en || 
        pin_en.tid_en    || pin_en.tdest_en || pin_en.tuser_en || pin_en.tdata_en);
    end
  end

  task initialize();
    ARESETn <= 1'b1;
    TVALID <= 1'b0;
    TREADY <= 1'b0;
  endtask

  `include "axis_assertions.svh"

endinterface

