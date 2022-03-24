#
#   This file contains user's preferences for synthesis
#

set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

# Clock preferences (ps):
set PERIOD 10000
set ClkName myCLK
set ClkLatency 500
set ClkRise_uncertainty 500
set ClkFall_uncertainty 500
set ClkSlew 500
set InputDelay 500
set OutputDelay 500

set LIB_PATHS  "\
	$::env(STM065_DIR)/CLOCK65$::env(LIB_TYPE)_3.1/libs \
	$::env(STM065_DIR)/CORE65$::env(LIB_TYPE)_5.1/libs \
	$::env(RAM_LIB)/libs \
	$::env(PADS_LIB)"

set LIB_SEL	"\
	CLOCK65$::env(LIB_TYPE)_$::env(LIB_CASE)_$::env(LIB_VOLTAGE)V_$::env(LIB_TEMP)C.lib \
	CORE65$::env(LIB_TYPE)_$::env(LIB_CASE)_$::env(LIB_VOLTAGE)V_$::env(LIB_TEMP)C.lib \
	SPHD110420_nom_1.20V_25C.lib \
	Pads_Oct2012.lib"
