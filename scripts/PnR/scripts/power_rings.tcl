## This file is use to perform the power rings placement. It has to be runs after the florr planning.

## Create the rings
msg "Power script ..."

## Set the global net connections
msg "Set global net connection" uline
clearGlobalNets
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type tielo -inst *
globalNetConnect VDD -type pgpin -pin VDDC -inst *
globalNetConnect GND -type pgpin -pin GNDC -inst *

## Create the rings
msg "Power rings generation" uline
selectInst top_ac/RAM
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
#addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 0.4 -threshold 0.4 -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
#addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around each_block -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2

addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 0.4 -threshold 0.4 -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 10
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around each_block -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2

## Add the power strips
msg "Power strips generation" uline
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
#addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
#addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1

addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 150 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -set_to_set_distance 74 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1


msg "Power script ended" lines
