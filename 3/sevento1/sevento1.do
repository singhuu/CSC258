vlib work

vlog -timescale 1ns/1ns sevento1.v

vsim sevento1

log {/*}

add wave {/*}
# Testing on some random values
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
run 100 ns
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0
run 100 ns
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
run 100 ns

# Different times used in the timescale to cover all the cases.
force {SW[9]} 0 0, 1 40 -repeat 10
force {SW[8]} 0 0, 1 20 -repeat 10
force {SW[7]} 0 0, 1 10 -repeat 10