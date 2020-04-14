.data
len: .word 256789
.text
blez 	$s0, -10000000
move 	$a0, $t7
li 	$v0, 1
syscall
