	.data
	
len: 	.word 5
list: 	.word -4,6,7,-2,1

	.text
	
main:	la $t0, list # Save the address to t0 temporary
	lw $t1, len  # Similarly save the length of the array to t1
	lw $s0, ($t0) # Temporarily assume the first index of list is the max

Max: 	lw $t2, ($t0)	# Set $t2 to the index n (ie. t2 = list[n])
	ble $t2, $s0, Max_help # Checks if it is the max (by comparing it to the stored max)
	move $s0, $t2 # If it is not then sets a new max
	
Max_help:sub $t1, $t1, 1 # Super General decrementer (by 1) enables us to traverse through the array
	addu $t0, $t0, 4 # Incrementing the address by 4 bytes (by 1 word)
	bnez $t1, Max
	
	# Displaying the message in the output
	# It made my job easier while debugging
	move $a0, $s0
	li $v0, 1
	syscall
