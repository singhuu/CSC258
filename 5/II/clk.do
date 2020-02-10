vlib work

vlog -timescale 1ns/1ns clk.v

vsim clk

log {/*}
add wave {/*}

force {CLOCK_50} 0 0, 1 5 -repeat 10
force {SW[0]} 0 
force {SW[1]} 0 
force {SW[2]} 0 0, 1 8
run 1000000ns
force {CLOCK_50} 0 0, 1 5 -repeat 10
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0 0, 1 8
run 2000000ns
force {CLOCK_50} 0 0, 1 5 -repeat 10
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0 0, 1 8
run 4000000ns
force {CLOCK_50} 0 0, 1 5 -repeat 10
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0 0, 1 8
run 8000000ns
