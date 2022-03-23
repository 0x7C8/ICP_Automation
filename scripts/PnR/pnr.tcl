
## Set the design name
set DESIGN TIP_TOP
set ROOT "./"
set SYNTHETIS "../Synthetis/"
set DATE [clock format [clock seconds] -format "%b%d-%T"] 


## Set the power mode {LPHVT|LPSVT|GPLVT}
set POWER_MODE GPLVT
## Update the design name
set DESIGN_PWR "${DESIGN}_${POWER_MODE}"

## Path to different folders
set PATH_SCRIPT "${ROOT}scripts"


## Source the utility script
source "${PATH_SCRIPT}/utility.tcl"

## Source the Setup
msg "SETUP" star
source "${PATH_SCRIPT}/pnr_setup.tcl"

## Source the floor planning
msg "FLOOR PLANNING" star
source "${PATH_SCRIPT}/floor_planing.tcl"

## Source the power rings !!!
msg "POWER RINGS" star
source "${PATH_SCRIPT}/power_rings.tcl"

## Source the cell placement script
msg "PLACE CELLS" star
source "${PATH_SCRIPT}/place_cells.tcl"

## Run the clock generqtion tcl file
msg "GENERATE CLOCK" star
source "${PATH_SCRIPT}/clock_gen.tcl"

## Run the routing
msg "ROUTING" star
source "${PATH_SCRIPT}/route.tcl"

## Run the timming analysis
msg "CHECK TIMMING" star
source "${PATH_SCRIPT}/timing_check.tcl"

## Run the filler script
msg "ADD FILER" star
source "${PATH_SCRIPT}/filler.tcl"

## Run the post synthetis file generation
msg "GENERATE SIMULATION FILES" star
source "${PATH_SCRIPT}/generate_sim_files.tcl"

## Run the sdesign saving
msg "SAVE DESIGN" star
source "${PATH_SCRIPT}/save_design.tcl"

msg "" uline
msg "This is the end,"
msg "Beautiful friend..."
msg "This is the end,"
msg "My only friend, the end"
msg "" uline
