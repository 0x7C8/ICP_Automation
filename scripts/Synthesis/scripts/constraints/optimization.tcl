## Reduce the negative slack (TNS), instead of just WNS {true | false}
set TNS_OPT true
## Fix DRCs at the expense of timing {true | false}
set DRC_FIRSt false

msg "Optimization constraints:" lines

set_attribute tns_opto ${TNS_OPT} /
set_attribute drc_first ${DRC_FIRSt} /