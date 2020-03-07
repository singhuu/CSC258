vlib work

vlog -timescale 1ns/1ns part2.v

vsim joined

log {/*}
add wave {/*}

force {go} 0 0, 1 50, 0 100
force {resetN} 0 0, 1 20
force {clock} 0 0, 1 10 -r 20
force {draw} 0 0, 1 100, 0 0 150
force {location_in} 2#0101001 0, 2#1111111 40, 2#0100001 80
force {colour_in} 2#101

run 200ns