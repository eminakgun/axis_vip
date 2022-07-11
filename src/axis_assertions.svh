
`include "dv_macros.svh"

initial begin
  assert(STRB_KEEP_W == $ceil(DATA_W/8));
end