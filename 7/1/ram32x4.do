vlib work

vlog -timescale 1ns/1ns ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}
add wave {/*}
force {clock} 0 0,1 10 -r 20
force {address} 00010 0, 00011 10, 00100 20, 00101 30 -r 40
force {data} 0111 0, 1000 10, 1001 20, 1010 30 -r 40
force {wren} 1 0,0 50 -r 100
run 100 ns