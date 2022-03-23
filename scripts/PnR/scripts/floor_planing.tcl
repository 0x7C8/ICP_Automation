## This file is se to perform the floor planing. It has to be runs after the set up

## Resize and set up the margin
## Length: 
##  - RAM length = 306.5
##  - PAD length = 51.635 (*9 = 464.715)
##  - margin = (PAD - RAM)/2 = 79
## Height:
##  - RAM height = 41 ( * 3 ~ 120)
##  - PAD height = 51.635 (*3 = 154.9)
##  - marging = (PAD - RAM)/2 = 17.45

msg "Floor planing started ..."


if {$POWER_MODE == "GPLVT"} {
	## Perform the resize
	floorPlan -site CORE -s 326.6 164.0 67.3 21.0 67.3 21.0
	uiSetTool select
	## Set the GUI
	deselectAll

	## Place the RAM
	selectInst top_ac/RAM
	setObjFPlanBox Instance top_ac/RAM 160.874 218.556 465.674 259.556
	deselectAll
} else {
	## Perform the resize
	floorPlan -site CORE -s 306.6 136.0 77.3 35.0 77.3 35.0
	uiSetTool select
	## Set the GUI
	deselectAll

	## Place the RAM
	selectInst top_ac/RAM
	setObjFPlanBox Instance top_ac/RAM 153.657 204.495 458.457 245.495
	deselectAll
}

# ## Place the MAC
selectObject Module top_ac/mac_inst
setObjFPlanBox Module top_ac/mac_inst 168.893 155.18 283.093 175.98
deselectAll

# ## Place the input buffers
selectObject Module top_ac/input_matrix_inst
setObjFPlanBox Module top_ac/input_matrix_inst 198.463 115.064 397.663 135.864
deselectAll

# ## Place the controller
selectObject Module top_ac/contr
setObjFPlanBox Module top_ac/contr 381.822 155.222 425.822 176.022
deselectAll

## Add the Halo
selectInst top_ac/RAM
addHaloToBlock {10 10 10 10} -allBlock
deselectAll

## Cut rows under RAM
selectInst top_ac/RAM
cutRow -selected
deselectAll

## Add IO filler
## IO fillers
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side n
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side s
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side w
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side e

## Draw result
setDrawView fplan
ungroup top_ac
deselectAll

msg "Floor planing ended" lines
