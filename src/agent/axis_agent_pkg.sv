`ifndef AXIS_AGENT_PKG_SV
`define AXIS_AGENT_PKG_SV

package axis_agent_pkg;

  typedef int unsigned uint;
  
  typedef enum bit {
    AXIS_MASTER,
    AXIS_SLAVE,
  } axi_agent_mode_e; 

  typedef enum bit [1:0] {  
    AXIS_DATA_BYTE,
    AXIS_POS_BYTE,
    AXIS_NULL_BYTE,
    AXIS_RESERVED_BYTE
  } axi_xfer_byte_type_e;

  typedef struct {
    uint DATA_W;
    uint ID_W;
    uint USER_W; 
    uint DEST_W;
  } bus_widths_t

  `include "dv_macros.svh"
  `include "axis_macros.svh"
  `include "axis_xfer_item.sv"
  `include "axis_seqs.sv"
  `include "axis_sequencer.sv"
  `include "axis_driver.sv"
  `include "axis_monitor.sv"
  `include "axis_.sv"
  `include "axis_agent_cov.sv"
  `include "axis_agent_cfg.sv"
  `include "axis_agent.sv"

endpackage


`endif