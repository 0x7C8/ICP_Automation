#
#   This is synthesis tcl script
#

# TODO: move this in to separate file
set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

# ALL values are in ps
# TODO: move this in to separate file
set PERIOD 10000
set ClkName myCLK
set ClkLatency 500
set ClkRise_uncertainty 500
set ClkFall_uncertainty 500
set ClkSlew 500
set InputDelay 500
set OutputDelay 500
 
set_attribute hdl_language vhdl     # Is this needed?
set_attribute init_hdl_search_path $::env(RTL_DIR)   # Is this needed?

# TODO: This is inflexible, make a chose for CLK_LIB={choice}
set_attribute init_lib_search_path {\
    $::env(CLK_LIB_LPHVT)\
    $::env(BUF_LIB_LPHVT)\
    $::env(RAM_LIB)\
    $::env(PADS_LIB)\
} /

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 6

# TODO: move this to other file
set_attribute library { \
CLOCK65LPHVT_nom_1.30V_125C.lib \
CORE65LPHVT_nom_1.30V_125C.lib \
SPHD110420_nom_1.20V_25C.lib \
Pads_Oct2012.lib}

puts "\n\n\n ANALYZE HDL DESIGN \n\n\n"
read_hdl $::env(COMPILE_FILES)

puts "\n\n\n ELABORATE \n\n\n"
elaborate


define_clock -name $ClkName -period $PERIOD [find / -port clk_top]
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
write_sdc    > $::env(SDC_FILE)
write_sdf    > $::env(SDF_FILE_S)

puts "\n\n\n REPORTING \n\n\n"
report qor      > $::env(SYNTH_REPORTS)/qor.rpt
report area     > $::env(SYNTH_REPORTS)/area.rpt
report datapath > $::env(SYNTH_REPORTS)/datapath.rpt
report messages > $::env(SYNTH_REPORTS)/messages.rpt
report gates    > $::env(SYNTH_REPORTS)/gates.rpt
report timing   > $::env(SYNTH_REPORTS)/timing.rpt


