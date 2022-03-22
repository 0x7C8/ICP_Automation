#
#   This is an example file for VCD file generation
#

vcd file $::env(VCD_FILE)
# TODO
# vcd add -r $::env(TOP_TB_MODULE)
run 5 us
exit -force