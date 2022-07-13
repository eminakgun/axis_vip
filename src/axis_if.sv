
interface axis_if #(`DECL_BUS_WIDTH_PARAMS);

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

  clocking m_drv_cb @(posedge ACLK);
    default input #1step output #1;
    input ARESETn, TREADY;
    output TVALID, TLAST, TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
  endclocking

  clocking s_drv_cb @(posedge ACLK);
    default input #1step output #1;
    input ARESETn, TVALID, TLAST, TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
    output TREADY;
  endclocking

  clocking mon_cb @(posedge ACLK);
    default input #1step;
    input ARESETn, TVALID, TREADY, TLAST,
    TDATA, TSTRB, TKEEP, TID, TDEST, TUSER;
  endclocking

  task automatic cycles(int unsigned n);
    repeat(n) @(posedge ACLK);
  endtask

  `include "axis_assertions.svh"

endinterface

