vlib work
vlog -timescale 1ns/1ns ALU.v 
vsim ALU
log {/*}
add wave {/*}

# 0 case always first
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SWITCH[0]} 0
force {SWITCH[1]} 0
force {SWITCH[2]} 0
force {SWITCH[3]} 0
force {SWITCH[4]} 0
force {SWITCH[5]} 0
force {SWITCH[6]} 0
force {SWITCH[7]} 0
run 30ns

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {SWITCH[0]} 1
force {SWITCH[1]} 1
force {SWITCH[2]} 1
force {SWITCH[3]} 0
force {SWITCH[4]} 1
force {SWITCH[5]} 0
force {SWITCH[6]} 0
force {SWITCH[7]} 0
run 30ns

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {SWITCH[0]} 1
force {SWITCH[1]} 0
force {SWITCH[2]} 0
force {SWITCH[3]} 1
force {SWITCH[4]} 0
force {SWITCH[5]} 1
force {SWITCH[6]} 0
force {SWITCH[7]} 0
run 30ns

force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {SWITCH[0]} 0
force {SWITCH[1]} 0
force {SWITCH[2]} 0
force {SWITCH[3]} 0
force {SWITCH[4]} 1
force {SWITCH[5]} 0
force {SWITCH[6]} 1
force {SWITCH[7]} 1
run 30ns

force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {SWITCH[0]} 0
force {SWITCH[1]} 0
force {SWITCH[2]} 1
force {SWITCH[3]} 0
force {SWITCH[4]} 0
force {SWITCH[5]} 0
force {SWITCH[6]} 1
force {SWITCH[7]} 0
run 30ns

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
force {SWITCH[0]} 1
force {SWITCH[1]} 0
force {SWITCH[2]} 0
force {SWITCH[3]} 1
force {SWITCH[4]} 1
force {SWITCH[5]} 0
force {SWITCH[6]} 0
force {SWITCH[7]} 1
run 30ns