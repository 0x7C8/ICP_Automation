## This file is use to perform the timming analysis. It has to be runs after the routing.

## Create the rings
msg "timming analysis script started ..."

## Set the simulation
setAnalysisMode -analysisType onChipVariation -cppr both

## Start the Post-route optimization: SETUP CAP, TRAN, FANOUT
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute

## Start the Post-route optimization: HOD CAP, TRAN, FANOUT
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute -hold

## 
#setOptMode -fixCap false -fixTran true -fixFanoutLoad false
#optDesign -postRoute -hold

## ## Start the Post-route optimization: SETUP CAP

msg "timming analysis script ended " lines