#
# This is an example file for wave simulation
#

add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):clk
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):rst
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):IN_read
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):IN_load

add wave -noupdate -expand -group data $::env(TOP_TB_MODULE):IN_data
add wave -noupdate -expand -group data $::env(TOP_TB_MODULE):Out_data

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {340612284 ps} 0}
update
run 5 us
wave zoom full
