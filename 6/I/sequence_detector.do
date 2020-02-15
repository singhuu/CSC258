vlib work

vlog -timescale 1ns/1ns sequence_detector.v

vsim sequence_detector

log {/*}
add wave {/*}

force {SW[0]} 0 0, 1 15

force {SW[1]} 0 0, 1 10, 0 120, 1 150, 0 180, 1 220, 0 270

force {KEY[0]} 0 0, 1 10 -r 40

run 400ns