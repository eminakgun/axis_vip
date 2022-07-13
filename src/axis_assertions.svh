
`include "dv_macros.svh"

initial begin
  assert(KEEP_STRB_W == $ceil(DATA_W/8));
end