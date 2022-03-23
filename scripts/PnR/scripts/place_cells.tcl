## This file is use to perform the cells placement. It has to be runs after the Power planing.

## Create the rings
msg "Cell placement script ..."

## Place wells
msg "Wells placement" uline
addWellTap -cell HS65_LS_FILLERSNPWPFP4 -cellInterval 25 -prefix WELLTAP

## Place standard cells
msg "Place standard cells" uline
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign

## Change display mode
setDrawView place

msg "Cell placement script ended" lines