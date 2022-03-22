#
#   This is an example tcl script for power analysis with PrimeTime
#

remove_design - all

set reports_path "$::env(POWER_DIR)/reports"

#### Power analysis mode
set power_enable_analysis TRUE
set power_analysis_mode time_based

#### Link and setup design libraries
set search_path 	" $::env(CLK_LIB)  $::env(PAD_LIB) $::env(BUF_LIB) $search_path"

# TODO: This is not flexible, fix this
set library_additions "Pads_Oct2012.db CLOCK65LPHVT_nom_1.30V_125C.db CORE65LPHVT_nom_1.30V_125C.db SPHD110420_nom_1.20V_25C.db"

set link_library    "$library_additions $link_library"
set target_library    "$library_additions $target_library"

#### Design input
# TODO: link same file name to the PnR output
read_verilog $::env(NETLIST_DIR)/layout_netlist.v
# TODO: Top name is shared between sim and synth, make it global
current_design "TOP"

link_design

#### Timing information
# Read SDC and sets transition time (post-syn) or annotate parasitics (post-layout)
# TODO: link same file name to the synth output
read_sdc $::env(NETLIST_DIR)/timing.sdc

#### Read switching activity
# Reads VCD file obtained from post-layout simulation
# TODO: Add TB variable and link file to questasim VCD output
read_vcd -strip_path $::env(TB_TOP_MODULE) $::env(NO_BACKUP_DIR)/top.vcd

#### Power report
check_power
update_power
report_power -verbose -hierarchy > $reports_path/power.rpt