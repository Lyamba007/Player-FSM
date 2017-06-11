SetActiveLib -work
comp -include "$dsn\src\player_beh.vhd" 
comp -include "$dsn\src\TestBench\player_TB.vhd" 
asim +access +r TESTBENCH_FOR_player 
wave 
wave -noreg CLK
wave -noreg RESET
wave -noreg x
wave -noreg y
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\player_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_player 
