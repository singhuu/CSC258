vlib work

vlog -timescale 1ns/1ns morse.v

vsim morse

log {/*}
add wave {/*}
force {KEY[0]} 1
force {KEY[1]} 0 0, 1 20 -repeat 80000

force {CLOCK_50} 0 0, 1 10 -repeat 20
force {SW[0]} 0 0, 1 10000 -repeat 20000
force {SW[1]} 0 0, 1 20000 -repeat 40000
force {SW[2]} 0 0, 1 20000 -repeat 80000
run 160000ns