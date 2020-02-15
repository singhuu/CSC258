vlib work
vlog -timescale 1ns/1ns poly_function.v
vsim poly_function
log {/*}
add wave {/*}
force {CLOCK_50} 0 0, 1 1 -r 2
force {KEY[0]} 0
force {KEY[1]} 1
run 10ns
force {KEY[0]} 1
run 10ns


# A = 10
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns

# B = 15
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns

# C = 5
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {KEY[1]} 0
run 10ns
force {KEY[1]} 1

# X = 3
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns
force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns