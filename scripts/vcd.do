#
#   This is an example file for VCD file generation
#

vcd file $::env(VCD_FILE)
vcd add -r */$::env(TOP_CELL_INSTANCE)
#add wave $::env(TOP_TB_MODULE):all
run 10 us
# exit -force
