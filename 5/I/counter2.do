vlib work

vlog -timescale 1ns/1ns counter.v

vsim counter

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[0]} 0
run 5 ns
force {SW[0]} 1

force {SW[1]} 1

force {KEY[0]} 0 0, 1 10 -repeat 10
run 1000 ns