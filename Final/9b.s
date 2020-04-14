	.data
	
len:	.word 5 
n: 		.word 5
err: 	.word -1
list: 	.word -4, 6, 7, -2, 1

	.text
	
	.globl main
	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# I will be using the following algorithm for my implementation
# int arr[];
# int start_add; // Basically arr[0]
# int main(int n) {
#	n -= 1;
#	if(n < 1 || n > len) {
#		return -1;
#		}
#	else
#		return get_n(n)
#	}
# int get_n(int n) {
#	int new_add = start_add + n; 
#	return arr[new_add];
#	}
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #	
main: 	la $t0, list	# Save the address to t0 temporary
	lw $t1, n  	# Similarly save the length of the array to t1
	lw $s0, err	# Similarly save the default return value to s0
	addiu	$t1, $t1, -1	# The first index is at position 1 but at index 0, so we
				# subtract 1 for calculation in the beginnning

less_than_1:
	bge $t1, 0, greater_than_len 	# If index is greater than equal to zero then it passes the first check
	j	end			# If condition above has failed, then jump to the end (& return -1)
 
greater_than_len:		
	ble $t1, 4, get_n	# If index is less than or equal to 4, then finally go to get_n
	j	end		# If the above has failed, then jump to the end (& return -1)
get_n:  
	sll $t1, $t1, 2		# Used this line from Q7.a of the assignment which basically multiplies the value by 4
	add $s1, $t0, $t1	# Store the s1 to be the sum of the length and Jump to the address
	lw $s0, 0($s1)		# Store the number in s0 for output
	j 	end		# Jump to the end
end:
	move $a0, $s0		# Move the contents of s0 to a0
	li $v0, 1		# Invoke the print integer statement
	syscall			# Issue a syscall and print the number n
