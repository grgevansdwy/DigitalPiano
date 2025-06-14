onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/clk
add wave -noupdate /datapath_tb/Reg2Loc
add wave -noupdate /datapath_tb/RegWrite
add wave -noupdate /datapath_tb/instruction
add wave -noupdate -radix decimal /datapath_tb/WriteData
add wave -noupdate -radix unsigned /datapath_tb/WriteRegister
add wave -noupdate -radix decimal /datapath_tb/immIn
add wave -noupdate /datapath_tb/carry_out
add wave -noupdate /datapath_tb/negative
add wave -noupdate /datapath_tb/overflow
add wave -noupdate /datapath_tb/zero
add wave -noupdate -radix decimal /datapath_tb/result
add wave -noupdate -radix decimal /datapath_tb/dut/register/ReadData1
add wave -noupdate -radix decimal /datapath_tb/dut/register/ReadData2
add wave -noupdate -radix unsigned /datapath_tb/dut/register/ReadRegister1
add wave -noupdate -radix unsigned /datapath_tb/dut/register/ReadRegister2
add wave -noupdate -radix decimal /datapath_tb/dut/register/regout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42500000 ps} 0}
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
WaveRestoreZoom {0 ps} {343875 ns}
