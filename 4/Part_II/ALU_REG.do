vlib work
vlog -timescale 1ns/1ns ALU_REG.v
vsim ALU_REG

log {/*}
add wave {/*}
force {KEY[0]} 0 0, 1 10 -r 20
force {SWITCH[9]} 1
# A+1
force {SWITCH[7]} 0
force {SWITCH[6]} 0
force {SWITCH[5]} 0

#force {SWITCH[9]} 0

force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 1
run 10ns

#force {SWITCH[9]} 1
# data
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 1
run 10ns

# A+B
force {SWITCH[7]} 0
force {SWITCH[6]} 0
force {SWITCH[5]} 1
# reset_n
#force {SWITCH[9]} 0

force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns

# A+B using verilog
force {SWITCH[7]} 0
force {SWITCH[6]} 1
force {SWITCH[5]} 0
#force {SWITCH[9]} 0

force {SWITCH[3]} 1
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns
# reset_n
#force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns

# A XOR B in lower 4 bits, A OR B in higher 4

force {SWITCH[7]} 0
force {SWITCH[6]} 1
force {SWITCH[5]} 1
#force {SWITCH[9]} 0

force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns

#force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 0

# A and B reduction OR
# Function inputs
force {SWITCH[7]} 1
force {SWITCH[6]} 0
force {SWITCH[5]} 0

#force {SWITCH[9]} 0

force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns
#force {SWITCH[9]} 1
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns

# Left shift B by A bits
force {SWITCH[7]} 1
force {SWITCH[6]} 0
force {SWITCH[5]} 1

force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns

force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 0
force {SWITCH[1]} 1
force {SWITCH[0]} 1
run 10ns

# Right shift B by A bits

force {SWITCH[7]} 1
force {SWITCH[6]} 1
force {SWITCH[5]} 0

force {SWITCH[9]} 1
# data
force {SWITCH[3]} 1
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 1
run 10ns

force {SWITCH[9]} 1

force {SWITCH[3]} 1
force {SWITCH[2]} 1
force {SWITCH[1]} 1
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 1
run 10ns

# A X B using Verilog *
force {SWITCH[7]} 1
force {SWITCH[6]} 1
force {SWITCH[5]} 1

force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 1

force {SWITCH[9]} 1

force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 0
run 10ns
force {SWITCH[3]} 0
force {SWITCH[2]} 1
force {SWITCH[1]} 0
force {SWITCH[0]} 1
run 10ns