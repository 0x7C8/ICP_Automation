#
#   This is an example tcl script for power analysis with PrimeTime
#

# remove_design -all

# Power analysis mode
set power_enable_analysis TRUE
set power_analysis_mode time_based

# Link and setup design libraries
# TODO: Make the list where lib dirs are exported? Synth and layout share some of thoese
set search_path "$::env(STM065_DIR)/$::env(CLK_LIB)/libs $::env(STM065_DIR)/$::env(BUF_LIB)/libs $::env(STM065_DIR)/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs $::env(STM065_DIR)/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs $::env(PADS_LIB) $::env(RAM_LIB)/libs $search_path"

# TODO: This is not flexible, fix this, same names are used in synthesis
set link_path "* \
SPHD110420_wc_1.10V_125C.db \
CLOCK65LPHVT_nom_1.30V_125C.db \
CORE65LPHVT_nom_1.30V_125C.db \
Pads_Oct2012.db \
	IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_0.90V_1.65V_125C.db \
	IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_wc_0.90V_125C.db"

# set link_library    "$library_additions $link_library"
# set target_library    "$library_additions $target_library"

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
