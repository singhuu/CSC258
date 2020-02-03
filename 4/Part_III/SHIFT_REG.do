# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns SHIFT_REG.v

# Load simulation using adder as the top level simulation module.
vsim SHIFT_REG

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SWITCH[9]} 1 
force {SWITCH[7]} 1
force {SWITCH[6]} 1
force {SWITCH[5]} 0
force {SWITCH[4]} 1
force {SWITCH[3]} 1
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 1

force {KEY[1]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[0]} 0 0, 1 5 -repeat 10
run 20ns

force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
force {KEY[0]} 0 0, 1 5 -repeat 10
run 20ns


force {SWITCH[9]} 1
force {SWITCH[7]} 1
force {SWITCH[6]} 1
force {SWITCH[5]} 0
force {SWITCH[4]} 1
force {SWITCH[3]} 1
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 1
force {KEY[1]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[0]} 0 0, 1 5 -repeat 10
run 20ns

force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
force {KEY[0]} 0 0, 1 5 -repeat 10
run 20ns
