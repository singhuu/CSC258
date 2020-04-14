	.data
	
len: 	.word 10
list:   .word 13,21,4,15,-2,18,20,50,6,7
min: 	.word 0

    	.text
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# I will use the following algorithm (that uses recursion) and 
# "translate" it to Assembly
# class 9c.s
# {
#    int main(){
#        int n = 10;
#        int arr[] = {1,2,3,4,0,5,6,7,8,9};
#        return find_min(arr,n);
#    }
#    int get_min(int arr[], int n){
#        if(n == 1)  {
#            return arr[0];
#        }
#        else    {
#            return Math.min(arr[n-1], get_min(arr, n-1));
#        }
#    }
# }
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

main:	la     	$t0, list	# Store the address of the list in the t0 temporary
    	la      $t1, min 	# Store the address of the min in the t1 temporary          
    	addi    $s1,$t0,40      # Store the end of the address (which in this case is 4 x 10 = 40 bytes    
    	lw      $t4,0($t0)      # Load the first index into t4 (t4 will act as the temp variable throughout the code)     
    	sw      $t4,0($t1)      # Assume the first index is the min (just like 9a)        
    	j	get_min		# Jump to get_min
    
get_min:beq     $t0,$s1,end	# Checks if ( n == 1 ) condition, if yes then return arr[0]
    	lw      $s0,0($t0)      # Else, store the value of t0 into s0      
    	addi    $t0,$t0,4       # Iterate t0 to go to the next address        
   	lw      $t4,0($t1)      # Load min temporarily into t4        
   	slt     $t2,$t4,$s0   	# (t4 < s0) ? 1 : 0    
   	bne     $t2,$zero,get_min # If it's not less than recurse      
   	sw      $s0,0($t1)      # If it's less than the original min then make it the new min   
    	j       get_min		# Recurse back to min

end: 	li      $v0,1		# Invoke the print integer call
    	lw      $a0,0($t1)      # Load a0 to the address of t1
    	syscall			# Print

