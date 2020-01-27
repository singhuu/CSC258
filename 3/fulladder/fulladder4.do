vlib work
vlog -timescale 1ns/1ns fulladder4.v
vsim fulladder4
log {/*}
add wave {/*}

# Here we take the edge cases first
# Add 0 and 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

force {SW[9]} 0
run 10 ns
# Add 15 and 15
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

force {SW[9]} 0
run 10 ns


# Few Other Examples
# Add 8 and 5
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1

force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {SW[9]} 0
run 10 ns

# Add 3 and 9
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

force {SW[9]} 0
run 10 ns