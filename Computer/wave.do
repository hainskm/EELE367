onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /computer_tb/clock_TB
add wave -noupdate /computer_tb/reset_TB
add wave -noupdate /computer_tb/DUT1/CPU1/address
add wave -noupdate -expand -group {Control Unit} /computer_tb/DUT1/CPU1/CONTROL/current_state
add wave -noupdate -expand -group {Instruction Register} /computer_tb/DUT1/CPU1/DATA/IR_Load
add wave -noupdate -expand -group {Instruction Register} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/IR
add wave -noupdate -expand -group {Memory Address Register} /computer_tb/DUT1/CPU1/DATA/MAR_Load
add wave -noupdate -expand -group {Memory Address Register} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/MAR
add wave -noupdate -expand -group {Program Counter} /computer_tb/DUT1/CPU1/DATA/PC_Load
add wave -noupdate -expand -group {Program Counter} /computer_tb/DUT1/CPU1/DATA/PC_Inc
add wave -noupdate -expand -group {Program Counter} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/PC
add wave -noupdate -expand -group {General Purpose Registers} /computer_tb/DUT1/CPU1/DATA/A_Load
add wave -noupdate -expand -group {General Purpose Registers} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/A
add wave -noupdate -expand -group {General Purpose Registers} /computer_tb/DUT1/CPU1/DATA/B_Load
add wave -noupdate -expand -group {General Purpose Registers} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/B
add wave -noupdate -expand -group {Bus System} -radix hexadecimal /computer_tb/DUT1/CPU1/from_memory
add wave -noupdate -expand -group {Bus System} -radix hexadecimal /computer_tb/DUT1/CPU1/to_memory
add wave -noupdate -expand -group {Bus System} /computer_tb/DUT1/CPU1/DATA/Bus1_Sel
add wave -noupdate -expand -group {Bus System} /computer_tb/DUT1/CPU1/DATA/Bus2_Sel
add wave -noupdate -expand -group {Bus System} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/Bus1
add wave -noupdate -expand -group {Bus System} -radix hexadecimal /computer_tb/DUT1/CPU1/DATA/Bus2
add wave -noupdate -expand -group {Bus System} /computer_tb/DUT1/CPU1/write_bit
add wave -noupdate -expand -group Ports -radix hexadecimal /computer_tb/port_in_00_TB
add wave -noupdate -expand -group Ports -radix hexadecimal /computer_tb/port_out_00_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_01_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_02_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_03_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_04_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_05_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_06_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_07_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_08_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_09_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_10_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_11_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_12_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_13_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_14_TB
add wave -noupdate -expand -group Ports /computer_tb/port_out_15_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_01_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_02_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_03_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_04_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_05_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_06_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_07_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_08_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_09_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_10_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_11_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_12_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_13_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_14_TB
add wave -noupdate -expand -group Ports /computer_tb/port_in_15_TB
add wave -noupdate -expand -group Ports /computer_tb/t_clk_per
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {130717 ps} 0}
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
WaveRestoreZoom {0 ps} {178830 ps}
