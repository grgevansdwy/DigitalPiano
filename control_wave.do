onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_tb/ALUSrc
add wave -noupdate /control_tb/Branch
add wave -noupdate /control_tb/MemRead
add wave -noupdate /control_tb/MemWrite
add wave -noupdate /control_tb/MemtoReg
add wave -noupdate /control_tb/Reg2Loc
add wave -noupdate /control_tb/RegWrite
add wave -noupdate /control_tb/Uncondbranch
add wave -noupdate /control_tb/instruction
add wave -noupdate /control_tb/immIn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {97 ps}
