set CURRENT_TB "sim/:matrix_multiplier_tb"
set CURRENT_SIM "sim/:matrix_multiplier_tb:TOP_THING:MATRIX_THING"

vsim work.matrix_multiplier_tb

# TODO: create a loop that takes from the list
add wave -position insertpoint ${CURRENT_SIM}:clk_top
add wave -position insertpoint ${CURRENT_SIM}:rst
add wave -position insertpoint -radix unsigned ${CURRENT_SIM}:CONTROLLER:address_A

run 10 us
wave zoom full