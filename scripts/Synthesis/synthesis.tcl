## Main tcl file for MyProject

## Set the design name
set DESIGN TIP_TOP
set ROOT "/h/d2/e/al5516gu-s/DIGITAL_ICP_1/IPC_accelerator/Synthetis/"
set DATE [clock format [clock seconds] -format "%b%d-%T"]

## Set the power mode {LPHVT|LPSVT|GPLVT}
set POWER_MODE GPLVT

## Update the design name
set DESIGN_PWR "${DESIGN}_${POWER_MODE}"

## Path to different folders
set PATH_SCRIPT       "${ROOT}scripts"
set PATH_OUT          "${ROOT}result"
set PATH_REPORT       "${ROOT}reports"
set PATH_RTL          "${ROOT}rtl"

set PATH_CONSTRAINTS    "${PATH_SCRIPT}/constraints"
set PATH_HARDWARE_SPEC  "${PATH_SCRIPT}/hardware"

## Source the utility script
source "${PATH_SCRIPT}/utility.tcl"

## Write welcoming messages
msg "${DATE} Welcome to project ${DESIGN}, using ${POWER_MODE} power mode." star
msg "The curent working directory is: ${ROOT}" uline

## Get host data
if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}
puts "Hostname : [info hostname]"
msg " " uline

## Perform the setup
source "${PATH_HARDWARE_SPEC}/design_setup.tcl"
msg " " uline

## Set the constraints
msg "Set the constraints" lines
source "${PATH_CONSTRAINTS}/power_constraints.tcl"
source "${PATH_CONSTRAINTS}/optimization.tcl"

## Analyse the HDL design
msg "Analyse the HDL design" lines
read_hdl -vhdl ${Design_vhd_Files}

## Elaborate the design
msg "Analyse the HDL design" lines
elaborate ${DESIGN};

## Set the clock constraints
source "${PATH_SCRIPT}/clock_generation.tcl"
msg " " uline

## Check the design
msg "Check design: unresolved" star
check_design -unresolved
msg "Check design: unload" star
check_design -unloaded

msg "Timing" star
time_info Elaboration
msg " " uline

## Perform the generic synthetis
msg "Perform the generic synthesis" star
syn_generic
msg " " uline

## Perform the synthetis global mapping
msg "Perform the synthesis global mapping" star
syn_map
msg " " uline

## Perfomr the synthetis optimization,
msg "Perform the synthesis optimization" star
syn_opt
msg "End of the synthesis optimization" uline

##  Set the report directory
generate_reports -outdir $PATH_REPORT -tag test
report_summary -outdir $PATH_REPORT

## Export the design
msg "Export design" lines
write_hdl    > ${PATH_OUT}/${DESIGN_PWR}.v
write_sdc    > ${PATH_OUT}/${DESIGN_PWR}.sdc
write_sdf   -version 2.1  > ${PATH_OUT}/${DESIGN_PWR}.sdf
msg " " uline

## Perform the reporting
msg "Export design" lines
report qor      > $PATH_REPORT/qor_${DESIGN_PWR}.rpt
report area     > $PATH_REPORT/area_${DESIGN_PWR}.rpt
report datapath > $PATH_REPORT/datapath_${DESIGN_PWR}.rpt
report messages > $PATH_REPORT/messages_${DESIGN_PWR}.rpt
report gates    > $PATH_REPORT/gates_${DESIGN_PWR}.rpt
report timing   > $PATH_REPORT/timing_${DESIGN_PWR}.rpt
msg " " uline

msg "Timing" star
report timing -lint
