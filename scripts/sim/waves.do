#
#   This is an example file for wave simulation
#

add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):clk
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):rst
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):input
add wave -noupdate -expand -group ctrl $::env(TOP_TB_MODULE):read_RAM

add wave -noupdate -expand -group data $::env(TOP_TB_MODULE):data_in
add wave -noupdate -expand -group data $::env(TOP_TB_MODULE):data_out

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {340612284 ps} 0}
update
run 5 us
wave zoom full
