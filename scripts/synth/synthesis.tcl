#
#   This is synthesis tcl script
#

source $::env(SCRIPT_DIR)/synth/synth_prefs.tcl

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 6

set_attribute library $LIB_SEL

puts "\n\n\n ANALYZE HDL DESIGN \n\n\n"
# read_hdl -v2001
read_hdl -vhdl $::env(COMPILE_PKGS) $::env(COMPILE_FILES) $::env(TOP_FILE_B)

puts "\n\n\n ELABORATE \n\n\n"
elaborate


define_clock -name $ClkName -period $PERIOD [find / -port $::env(CLK_NAME)]
set_attribute clock_network_late_latency $ClkLatency $ClkName
set_attribute clock_source_late_latency  $ClkLatency $ClkName 
set_attribute clock_setup_uncertainty $ClkLatency $ClkName
set_attribute clock_hold_uncertainty $ClkLatency $ClkName 
set_attribute slew_rise $ClkRise_uncertainty $ClkName 
set_attribute slew_fall $ClkFall_uncertainty $ClkName

external_delay -input $InputDelay  -clock [find / -clock $ClkName] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName] -name out_con [find /des* -port ports_out/*]

# Check design
check_design
report timing -lint

puts "\n\n\n SYN_GENERIC \n\n\n"
syn_generic

puts "\n\n\n SYN_MAP \n\n\n"
syn_map

puts "\n\n\n SYN_OPT \n\n\n"
syn_opt

puts "\n\n\n EXPORT DESIGN \n\n\n"
write_hdl    > $::env(TOP_FILE_S)
write_sdc    > $::env(SDC_FILE_S)
write_sdf    > $::env(SDF_FILE_S)

puts "\n\n\n REPORTING \n\n\n"
report qor      > $::env(SYNTH_REPORTS)/qor.rpt
report area     > $::env(SYNTH_REPORTS)/area.rpt
report datapath > $::env(SYNTH_REPORTS)/datapath.rpt
report messages > $::env(SYNTH_REPORTS)/messages.rpt
report gates    > $::env(SYNTH_REPORTS)/gates.rpt
report timing   > $::env(SYNTH_REPORTS)/timing.rpt


