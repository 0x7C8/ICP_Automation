## This file is use to perform the routing. It has to be runs after the filler.

## Create the rings
msg "Route script started ..."

## Post CTS optimization
## Optimization SETUP cap, Tran, Fanout
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS


## Optimization HOLD cap, Tran, Fannout
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -hold

## Special root
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1 AP } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 AP } -nets { GND VDD } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 AP }

## Nano routes
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

msg "Route script ended" lines
