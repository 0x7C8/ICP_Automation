## Script used to set up the 'encounter' softaware in order to load the differet .lef files used

## Set the computer usage
setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 4 -remoteHost 0 -keepLicense true
setDistributeHost -local

### Set file paths
## Set the LEF files
if {$POWER_MODE == "GPLVT"} {
    set LEF_FILES {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/CORE65GPLVT_5.1/CADENCE/LEF/CORE65GPLVT_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65GPLVT_3.1/CADENCE/LEF/CLOCK65GPLVT_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef \
        /usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/LEF/SPHD110420.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V2_50A_7M4X0Y2Z@7.1.a.UD5357/CADENCE/LEF/IO65LPHVT_SF_1V2_50A_7M4X0Y2Z_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef \
        /usr/local-eit/cad2/cmpstm/dicp18/LU_PADS_65nm/PADS_Jun2013.lef\
    }
} else {
    set LEF_FILES {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/CADENCE/LEF/CORE65LPHVT_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/CADENCE/LEF/CLOCK65LPHVT_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef \
        /usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/LEF/SPHD110420.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V2_50A_7M4X0Y2Z@7.1.a.UD5357/CADENCE/LEF/IO65LPHVT_SF_1V2_50A_7M4X0Y2Z_soc.lef \
        /usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef \
        /usr/local-eit/cad2/cmpstm/dicp18/LU_PADS_65nm/PADS_Jun2013.lef\
    }
}


## Set the IO palcement file
set IO_FILE ./pads/IO_placement.io
## Set the HDL file
#set HDL_FILE ../Synthetis/result/TIP_TOP.v
set HDL_FILE ../Synthetis/result/${DESIGN_PWR}.v

##  Set the mmmc file
#set MMMC_FILE generated_conf/TIP_TOP.view
set MMMC_FILE generated_conf/${DESIGN_PWR}.view

## Tool initialization
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set _timing_library_enable_mt_flow 0
set dcgHonorSignalNetNDR 1
set defHierChar {/}
set delaycal_input_transition_delay {0.1ps}
set distributed_client_message_echo {1}
set fpIsMaxIoHeight 0
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_design_settop 0


## Initiaialize the power
msg "Set power nets" uline
set init_gnd_net {GND}

## Set up the IO planning
msg "Set IO file" uline
set init_io_file ${IO_FILE}

## Initialize the LEF files
msg "Set LEF fils" uline
set init_lef_file ${LEF_FILES}

##  Set the MMMC file
msg "Set MMMC file" uline
set init_mmmc_file ${MMMC_FILE}
set init_oa_search_lib {}
set init_pwr_net {VDD}

## Initialize the HDL files
msg "Set design net files" uline
set init_verilog ${HDL_FILE}

msg "Set Tool initialization" uline
set lsgOCPGainMult 1.000000
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}

set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}


## Initialize the design
msg "Initialize design" uline
init_design

## Fit the view for the user
fit
setDrawView fplan

## Set up the optimizations
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -timingEngine CTE
setOptMode -effort high -leakagePowerEffort none -dynamicPowerEffort none -reclaimArea true -simplifyNetlist true -allEndPoints false -setupTargetSlack 0.01 -holdTargetSlack 0.01 -maxDensity 0.95 -drcMargin 0 -usefulSkew false
setCTSMode -traceDPinAsLeaf false -traceIoPinAsLeaf false -routeClkNet true -routeGuide true -routeTopPreferredLayer M4 -routeBottomPreferredLayer M3 -routeNonDefaultRule {} -routeLeafTopPreferredLayer M4 -routeLeafBottomPreferredLayer M3 -routeLeafNonDefaultRule {} -useLefACLimit false -routePreferredExtraSpace 1 -routeLeafPreferredExtraSpace 1 -opt true -optAddBuffer true -moveGate true -useHVRC true -fixLeafInst true -fixNonLeafInst true -verbose false -reportHTML false -addClockRootProp false -nameSingleDelim false -honorFence false -useLibMaxFanout false -useLibMaxCap false

msg "Setup ended" lines
