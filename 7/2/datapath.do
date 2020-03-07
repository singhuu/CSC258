vlib work

vlog -timescale 1ns/1ns part2.v

vsim datapath

log {/*}
add wave {/*}
force {clock} 0 0, 1 10 -r 20
force {reset_n} 0 0, 1 40
force {rgb} 101

force {pos} 1010101

force {x_a} 1 0, 0 50
force {y_a} 0 0, 1 50, 0 100
force {c} 0 0, 1 40, 0 60

run 400ns