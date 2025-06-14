onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/dut/immIn
add wave -noupdate /cpu_tb/dut/instruction
add wave -noupdate /cpu_tb/dut/eq
add wave -noupdate /cpu_tb/dut/ge
add wave -noupdate /cpu_tb/dut/gt
add wave -noupdate /cpu_tb/dut/le
add wave -noupdate /cpu_tb/dut/link
add wave -noupdate /cpu_tb/dut/lt
add wave -noupdate /cpu_tb/dut/ne
add wave -noupdate /cpu_tb/dut/ALUOp
add wave -noupdate /cpu_tb/dut/ALUSrc
add wave -noupdate /cpu_tb/dut/BReg
add wave -noupdate /cpu_tb/dut/BrFlag
add wave -noupdate /cpu_tb/dut/BrTaken
add wave -noupdate /cpu_tb/dut/Branch
add wave -noupdate /cpu_tb/dut/MemRead
add wave -noupdate /cpu_tb/dut/MemWrite
add wave -noupdate /cpu_tb/dut/MemtoReg
add wave -noupdate /cpu_tb/dut/Reg2Loc
add wave -noupdate /cpu_tb/dut/RegWrite
add wave -noupdate /cpu_tb/dut/Uncondbranch
add wave -noupdate -radix unsigned /cpu_tb/dut/address
add wave -noupdate -radix decimal /cpu_tb/dut/result
add wave -noupdate /cpu_tb/dut/negative
add wave -noupdate /cpu_tb/dut/overflow
add wave -noupdate /cpu_tb/dut/carry_out
add wave -noupdate /cpu_tb/dut/zero
add wave -noupdate -radix decimal -childformat {{{/cpu_tb/dut/data/register/regout[31]} -radix decimal} {{/cpu_tb/dut/data/register/regout[30]} -radix decimal} {{/cpu_tb/dut/data/register/regout[29]} -radix decimal} {{/cpu_tb/dut/data/register/regout[28]} -radix decimal} {{/cpu_tb/dut/data/register/regout[27]} -radix decimal} {{/cpu_tb/dut/data/register/regout[26]} -radix decimal} {{/cpu_tb/dut/data/register/regout[25]} -radix decimal} {{/cpu_tb/dut/data/register/regout[24]} -radix decimal} {{/cpu_tb/dut/data/register/regout[23]} -radix decimal} {{/cpu_tb/dut/data/register/regout[22]} -radix decimal} {{/cpu_tb/dut/data/register/regout[21]} -radix decimal} {{/cpu_tb/dut/data/register/regout[20]} -radix decimal} {{/cpu_tb/dut/data/register/regout[19]} -radix decimal} {{/cpu_tb/dut/data/register/regout[18]} -radix decimal} {{/cpu_tb/dut/data/register/regout[17]} -radix decimal} {{/cpu_tb/dut/data/register/regout[16]} -radix decimal} {{/cpu_tb/dut/data/register/regout[15]} -radix decimal} {{/cpu_tb/dut/data/register/regout[14]} -radix decimal} {{/cpu_tb/dut/data/register/regout[13]} -radix decimal} {{/cpu_tb/dut/data/register/regout[12]} -radix decimal} {{/cpu_tb/dut/data/register/regout[11]} -radix decimal} {{/cpu_tb/dut/data/register/regout[10]} -radix decimal} {{/cpu_tb/dut/data/register/regout[9]} -radix decimal} {{/cpu_tb/dut/data/register/regout[8]} -radix decimal} {{/cpu_tb/dut/data/register/regout[7]} -radix decimal} {{/cpu_tb/dut/data/register/regout[6]} -radix decimal} {{/cpu_tb/dut/data/register/regout[5]} -radix decimal} {{/cpu_tb/dut/data/register/regout[4]} -radix decimal} {{/cpu_tb/dut/data/register/regout[3]} -radix decimal} {{/cpu_tb/dut/data/register/regout[2]} -radix decimal} {{/cpu_tb/dut/data/register/regout[1]} -radix decimal} {{/cpu_tb/dut/data/register/regout[0]} -radix decimal}} -subitemconfig {{/cpu_tb/dut/data/register/regout[31]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[30]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[29]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[28]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[27]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[26]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[25]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[24]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[23]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[22]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[21]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[20]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[19]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[18]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[17]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[16]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[15]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[14]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[13]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[12]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[11]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[10]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[9]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[8]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[7]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[6]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[5]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[4]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[3]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[2]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[1]} {-height 15 -radix decimal} {/cpu_tb/dut/data/register/regout[0]} {-height 15 -radix decimal}} /cpu_tb/dut/data/register/regout
add wave -noupdate /cpu_tb/dut/flagout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1044187693 ps} 0}
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
WaveRestoreZoom {0 ps} {2703750 ns}
