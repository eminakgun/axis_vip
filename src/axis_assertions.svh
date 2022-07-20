`define ASSERT_ERROR(name) \
  $error("%0t: (%0s:%0d) [%m] [ASSERT FAILED] %0s", $time, `__FILE__, `__LINE__, `"name`");
  
/* Stable during handshake process assertions */
property sig_stable_during_handshake(sig, en = 1);
  @(posedge ACLK) disable iff(!ARESETn)
  $rose(TVALID) && !TREADY && en |-> ##1 $stable(sig) throughout (TVALID && TREADY)[->1]; 
endproperty;

`define ASSERT_SIG_STABLE_DURING_HANDSHAKE(sig_name, en)                   \
  `define __name sig_name``_STABLE_DURING_HANDSHAKE_A                      \
  `__name``: assert property(sig_stable_during_handshake(sig_name, en))    \
              else `ASSERT_ERROR(`__name)                                  \
  `undef __name

TDATA_STABLE_DURING_HANDSHAKE_A: assert property(sig_stable_during_handshake(TDATA, pin_en.tdata_en)) 
  else `ASSERT_ERROR(TDATA_STABLE_DURING_HANDSHAKE_A)

`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TVALID,               1)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TSTRB , pin_en.tstrb_en)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TKEEP , pin_en.tkeep_en)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TLAST , pin_en.tlast_en)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TID   ,   pin_en.tid_en)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TDEST , pin_en.tdest_en)
`ASSERT_SIG_STABLE_DURING_HANDSHAKE(TUSER , pin_en.tuser_en)

/* Known assertions */
property sig_is_known(sig, en = 1);
  @(posedge ACLK) disable iff(!ARESETn)
  TVALID && en |-> !$isunknown(sig); 
endproperty;

`define ASSERT_SIG_IS_KNOWN(sig_name, en)                   \
  `define __name sig_name``_ASSERT_SIG_IS_KNOWN_A           \
  `__name``: assert property(sig_is_known(sig_name, en))    \
              else `ASSERT_ERROR(`__name)                   \
  `undef __name

`ASSERT_SIG_IS_KNOWN(TSTRB, pin_en.tstrb_en)
`ASSERT_SIG_IS_KNOWN(TKEEP, pin_en.tkeep_en)
`ASSERT_SIG_IS_KNOWN(TLAST, pin_en.tlast_en)
`ASSERT_SIG_IS_KNOWN(TID  ,   pin_en.tid_en)
`ASSERT_SIG_IS_KNOWN(TDEST, pin_en.tdest_en)
`ASSERT_SIG_IS_KNOWN(TUSER, pin_en.tuser_en)

// TVALID is LOW when reset until the first cycle after ARESETn goes HIGH
property tvalid_is_low_during_reset;
  @(posedge ACLK)
  $fell(ARESETn) |-> !TVALID throughout ARESETn[->1];
endproperty

TVALID_DURING_RESET_A: assert property(tvalid_is_low_during_reset)
  else `ASSERT_ERROR(TVALID_DURING_RESET_A)