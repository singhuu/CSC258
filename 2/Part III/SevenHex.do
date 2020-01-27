# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in SevenHex.v to working dir;
vlog -timescale 1ns/1ns SevenHex.v

# Load simulation using mux as the top level simulation module.
vsim SevenHex

log {/*}
add wave {/*}
# My lab room is BA3155
#B
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns
#A
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns
#3
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns
#1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns
#5
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns
#5
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns
