vlib work

vlog -timescale 1ns/1ns part2.v

vsim control

log {/*}
add wave {/*}

force {clock} 0 0, 1 20 -r 40
force {reset_n} 1 0, 0 20, 1 40

force {in} 0 0, 1 10 -r 20
force {d} 0 0, 1 80, 0 100

run 200ns