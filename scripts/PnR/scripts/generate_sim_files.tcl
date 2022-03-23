## This file is use to generate the post processing simulation files. It has to be runs after the filler operation.

msg "Generating simulation files started ..."

## Set variables

## Save the timming info
write_sdf ExportedFiles/${DESIGN_PWR}.sdf
write_sdc ExportedFiles/${DESIGN_PWR}.sdc

## Generate the netlist files
all_hold_analysis_views 
all_setup_analysis_views 
saveNetlist "ExportedFiles/${DESIGN_PWR}.v"

## Save the RC filles
rcOut -setload ExportedFiles/RC/${DESIGN_PWR}.setload -rc_corner SS
rcOut -setres ExportedFiles/RC/${DESIGN_PWR}.setres -rc_corner SS
rcOut -spf ExportedFiles/RC/${DESIGN_PWR}.spf -rc_corner SS
rcOut -spef ExportedFiles/RC/${DESIGN_PWR}.spef -rc_corner SS


msg "Generating simulation files ended" lines
