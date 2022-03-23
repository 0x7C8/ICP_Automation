## This file is use to perform the filler generation. It has to be runs after the Clock genertin.
## Set the filler cells
set CELL_FILLER \
"HS65_LS_FILLERPFOP64 HS65_LS_FILLERPFOP32 HS65_LS_FILLERPFOP16 \
HS65_LS_FILLERPFOP12 HS65_LS_FILLERPFOP9 HS65_LS_FILLERPFOP8 \
HS65_LS_FILLERCELL1 HS65_LS_FILLERCELL4 HS65_LS_FILLERCELL3 HS65_LS_FILLERCELL2 \
HS65_LL_FILLERPFP4 HS65_LL_FILLERPFP3 HS65_LL_FILLERPFP2 HS65_LL_FILLERPFP1 \
HS65_LH_FILLERPFP4 HS65_LH_FILLERPFP3 HS65_LH_FILLERPFP2 HS65_LH_FILLERPFP1"


## Create the rings
msg "Filler script started ..."

addFiller -cell ${CELL_FILLER} -prefix FILLER -markFixed

## Check timing
report_timing -early > report/timing_early_${DESIGN_PWR}.rpt
report_timing -late > report/timing_late_${DESIGN_PWR}.rpt

## Check power
report_power -outfile report/power_${DESIGN_PWR}.rpt

## Report theviolation
report_constraint -all_violators > report/constraint_${DESIGN_PWR}.rpt


msg "Filler script ended" lines