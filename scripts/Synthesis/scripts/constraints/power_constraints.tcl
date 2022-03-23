## set the leakage power minimization effort {low | medium | high}
set LEAKAGE_PWR_EFFORT medium

## set the dynamic power minimization effort {low | medium | high}
set DYNAMIC_PWR_EFFORT medium

## Code:
msg "Power constraints:" lines


#set_attribute max_leakage_power VALUE /designs/$DESIGN
set_attribute leakage_power_effort ${LEAKAGE_PWR_EFFORT} /

#set_attribute max_dynamic_power constraint /designs/design
set_attribute lp_power_analysis_effort ${DYNAMIC_PWR_EFFORT} /