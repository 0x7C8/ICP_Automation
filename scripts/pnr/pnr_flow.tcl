#######################################################
##                                                     
##  Matrix Multiplier PnR Command Script                    
##  Created on Tue Mar  1 16:27:36 2022                
##                                                     
########################################################
#
#
########################################################
## Import Design
########################################################
## Set the computer usage
setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 4 -remoteHost 0 -keepLicense true
setDistributeHost -local

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set ::CTE::timing_save_source_latency_per_view 1
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set _timing_library_enable_mt_flow 0
set conf_ioOri R0
set conf_row_height 2.600000
set dcgHonorSignalNetNDR 1
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set distributed_client_message_echo 1
set fpIsMaxIoHeight 0
set fp_core_height 159.000000
set fp_core_to_bottom 49.000000
set fp_core_to_left 44.400000
set fp_core_to_right 44.400000
set fp_core_to_top 49.000000
set fp_core_width 321.200000
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set gpsPrivate::oigCGFixOutOfCoreChannels 1
set gpsPrivate::oigPBAwareTopoMode 23
set gpsPrivate::oigTopoBCMode 0
set gpsPrivate::oigTopoUseBABInTopLvlNodesInOCP 1
set gpsPrivate::oigUseNewMaxBufDistAPI 1
set init_pwr_net VDD
set init_gnd_net GND
set init_io_file $::env(SCRIPT_DIR)/pnr/pads.io

set init_lef_file $::env(INIT_LEF)

set init_mmmc_file $::env(SCRIPT_DIR)/pnr/mmmc.view
set init_oa_search_lib {}
set init_top_cell $::env(TOP_CELL)
set init_verilog $::env(TOP_FILE_S)
set lsgOCPGainMult 1.000000
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set spgDecolorGeom 1
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}

init_design

#######################################################
## Global Net Connections
########################################################

clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDDC -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin GNDC -inst *
globalNetConnect GND -type tielo -inst *

#######################################################
## Floorplan Core and IO Size specification
########################################################

floorPlan -site CORE -s 321.2 159.0 44.4 49.0 44.4 49.0
fit

#######################################################
## Modify RAM Position 
########################################################

setDrawView fplan
selectInst MATRIX_THING/RAM_mem
setObjFPlanBox Instance MATRIX_THING/RAM_mem 127.224 240.824 432.024 281.824

selectObject Module MATRIX_THING
setObjFPlanBox Module MATRIX_THING 122.700 127.100 438.900 234.897
deselectAll

#######################################################
## Add Halo Around Memories
########################################################

selectInst MATRIX_THING/RAM_mem
addHaloToBlock {10 10 10 10} -allBlock
deselectAll


#######################################################
## Cut Rows Under Memories
########################################################

selectInst MATRIX_THING/RAM_mem
cutRow -selected
deselectAll

#######################################################
## Add Power Rings
########################################################

set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 0.4 -threshold 0.4 -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset {bottom 2 left 4 right 2 top 10}

#######################################################
## Add Block Ring Aroud memory block
########################################################

selectInst MATRIX_THING/RAM_mem
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
deselectAll

#######################################################
## Add Strips
########################################################

set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0

#Vertical Strips

addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -number_of_sets 3 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -xleft_offset 30 -xright_offset 30 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1

#Horizontal Strips

addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -number_of_sets 1 -ybottom_offset 70 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -ytop_offset 30 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1

#######################################################
## Add Well Taps
########################################################

addWellTap -cell HS65_LH_FILLERNPWPFP4 -cellInterval 25 -prefix WELLTAP


#######################################################
## Placement Blockage
########################################################

setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}

########################################################
## Placement- Standard cells with Memories
########################################################
setPlaceMode -ignoreScan false
setPlaceMode -fp false
placeDesign

placeDesign -incremental

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS

#######################################################
## Clock Synthesis
########################################################
setDrawView place
createClockTreeSpec -bufferList {HS65_LH_CNBFX10 HS65_LH_CNBFX103 HS65_LH_CNBFX124 HS65_LH_CNBFX14 HS65_LH_CNBFX17 HS65_LH_CNBFX21 HS65_LH_CNBFX24 HS65_LH_CNBFX27 HS65_LH_CNBFX31 HS65_LH_CNBFX34 HS65_LH_CNBFX38 HS65_LH_CNBFX38_0 HS65_LH_CNBFX38_1 HS65_LH_CNBFX38_10 HS65_LH_CNBFX38_11 HS65_LH_CNBFX38_12 HS65_LH_CNBFX38_13 HS65_LH_CNBFX38_14 HS65_LH_CNBFX38_15 HS65_LH_CNBFX38_16 HS65_LH_CNBFX38_17 HS65_LH_CNBFX38_18 HS65_LH_CNBFX38_19 HS65_LH_CNBFX38_2 HS65_LH_CNBFX38_20 HS65_LH_CNBFX38_21 HS65_LH_CNBFX38_22 HS65_LH_CNBFX38_23 HS65_LH_CNBFX38_3 HS65_LH_CNBFX38_4 HS65_LH_CNBFX38_5 HS65_LH_CNBFX38_6 HS65_LH_CNBFX38_7 HS65_LH_CNBFX38_8 HS65_LH_CNBFX38_9 HS65_LH_CNBFX41 HS65_LH_CNBFX45 HS65_LH_CNBFX48 HS65_LH_CNBFX52 HS65_LH_CNBFX55 HS65_LH_CNBFX58 HS65_LH_CNBFX62 HS65_LH_CNBFX82 HS65_LH_CNIVX10 HS65_LH_CNIVX103 HS65_LH_CNIVX124 HS65_LH_CNIVX14 HS65_LH_CNIVX17 HS65_LH_CNIVX21 HS65_LH_CNIVX24 HS65_LH_CNIVX27 HS65_LH_CNIVX3 HS65_LH_CNIVX31 HS65_LH_CNIVX34 HS65_LH_CNIVX38 HS65_LH_CNIVX41 HS65_LH_CNIVX45 HS65_LH_CNIVX48 HS65_LH_CNIVX52 HS65_LH_CNIVX55 HS65_LH_CNIVX58 HS65_LH_CNIVX62 HS65_LH_CNIVX7 HS65_LH_CNIVX82} -file Clock.ctstch

create_ccopt_clock_tree -name clock -source $::env(CLK_NAME)
clockDesign -specFile Clock.ctstch -outDir clock_report

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS
optDesign -postCTS -hold

report_timing -late
report_timing -early

#######################################################
## ADD IO FILLERS
########################################################

addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side n
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side s
addIoFiller -cell PADSPACE_74x4u -prefix IO_FILLER -side w
addIoFiller -cell PADSPACE_74x4u -prefix IO_FILLER -side e
fit

#######################################################
## Routing
########################################################
saveDesign ICP_1_Matrix_multiplier
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1 AP } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 AP } -nets { GND VDD } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 AP }


## Nano-Route
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

setAnalysisMode -analysisType onChipVariation

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute

#######################################################
## Add Fillers
########################################################

addFiller -cell HS65_GL_FILLERPFP4 HS65_GL_FILLERPFP3 HS65_GL_FILLERPFP2 HS65_GL_FILLERPFP1 -prefix FILLER -markFixed

#######################################################
# Save Files
#######################################################
saveDesign $::env(LAYOUT_DESIGN)
write_sdf $::env(SDF_FILE_L)
write_sdc $::env(SDC_FILE_L)
saveNetlist $::env(TOP_FILE_L)

#######################################################
# Extract RC SPEF File
#######################################################
rcOut -spef $::env(RC_SETUP) -rc_corner SS
rcOut -spef $::env(RC_HOLD) -rc_corner FF






