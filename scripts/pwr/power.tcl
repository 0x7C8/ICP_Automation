#
#   This is an example tcl script for power analysis with PrimeTime
#

# remove_design -all

# Power analysis mode
set power_enable_analysis TRUE
set power_analysis_mode time_based

# Link and setup design libraries
set link_path $::env(LINK_PATH)

# Design input
read_verilog $::env(TOP_FILE_L)
current_design $::env(TOP_CELL)
link_design

# Timing information
# Read SDC and sets transition time (post-syn) or annotate parasitics (post-layout)
#read_sdc
source $::env(SDC_FILE_L)
read_parasitics $::env(RC_SETUP)
read_sdf -type sdf_max $::env(SDF_FILE_L)

#### Read switching activity
# Reads VCD file obtained from post-layout simulation
# TODO: Add TB variable and link file to questasim VCD output
read_vcd -strip_path $::env(TOP_TB_MODULE)/$::env(TOP_CELL_INSTANCE) $::env(VCD_FILE)

#### Power report
check_power
update_power
report_power -verbose > $::env(POWER_REPORTS)/power.rpt
