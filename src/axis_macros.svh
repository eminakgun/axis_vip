
`define DECL_KEEP_STRB_W localparam int unsigned KEEP_STRB_W = DATA_W / 8;
`define DECL_BUS_WIDTH_PARAMS parameter int unsigned DATA_W = 32, ID_W = 18, USER_W = 4, DEST_W = 4
`define BUS_WIDTH_PARAMS DATA_W, ID_W, USER_W, DEST_W
`define DEFAULT_CLS_PARAM_ARGS bus_widths_t bus_widths, type ITEM_T = axis_xfer_item#(`CLS_BUS_WIDTH_PARAMS)
`define DEFAULT_CLS_PARAMS bus_widths, ITEM_T
`define CLS_BUS_WIDTH_PARAMS .DATA_W(bus_widths.DATAW),  \
                             .ID_W(bus_widths.ID_W),     \
                             .USER_W(bus_widths.USER_W), \ 
                             .DEST_W(bus_widths.DEST_W)
`define DECL_ITEM_TYPE typedef axi_agent_pkg::axis_xfer_item #(`BUS_WIDTH_PARAMS) axis_xfer_item_t;