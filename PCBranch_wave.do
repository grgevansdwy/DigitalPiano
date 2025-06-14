onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PCBranch_tb/BrAddr26
add wave -noupdate /PCBranch_tb/BrTaken
add wave -noupdate /PCBranch_tb/UncondBranch
add wave -noupdate -radix unsigned /PCBranch_tb/address
add wave -noupdate /PCBranch_tb/clk
add wave -noupdate /PCBranch_tb/condAddr19
add wave -noupdate -radix unsigned /PCBranch_tb/dut/PC/register/q
add wave -noupdate -radix unsigned /PCBranch_tb/dut/PC/register/d
add wave -noupdate -radix unsigned /PCBranch_tb/dut/PC/in
add wave -noupdate -radix unsigned /PCBranch_tb/dut/PC/out
add wave -noupdate /PCBranch_tb/reset
add wave -noupdate /PCBranch_tb/dut/branchOut
add wave -noupdate -radix unsigned /PCBranch_tb/dut/brAddr64
add wave -noupdate -radix unsigned /PCBranch_tb/dut/condAddr64
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48090 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
configure wave -valuecolwidth 122
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {78750 ps}
