#
#   This file contains user's preferences for synthesis
#

set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

# Clock preferences (ps):
set PERIOD 10000
set ClkName $::env(CLK_NAME) 
set ClkLatency 500
set ClkRise_uncertainty 500
set ClkFall_uncertainty 500
set ClkSlew 500
set InputDelay 500
set OutputDelay 500

set LIB_SEL	$::env(SYNTH_LIB)
