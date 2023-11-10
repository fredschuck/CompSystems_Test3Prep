.globl main
.data
buffer: .space 16
sum: .space 4
.text
main:
	la t0, buffer
# Load the contents of the array
	li t1, 1	
	sw t1, 0(t0) 	# A[0] = 1
	li t2, 5	
	sw t2, 4(t0)	# A[1] = 5
	li t3, 10
	sw t3, 8(t0)	# A[2] = 10
	li t4, 8
	sw t4, 12(t0)	# A[3] = 8
# Add the contents of the array
	lw t1, 0(t0)	# Fetch A[0]
	lw t2, 4(t0)	# Fetch A[1]
	add t3, t1, t2	# A[0] + A[1]
	lw t4, 8(t0)	# Fetch A[2]
	lw t5, 12(t0)	# Fetch A[3]
	add t6, t4, t5	# A[2] + A[3]
	add t1, t3, t6  # calculate final sum
# Store the result
	la t2, sum
	sw t1, 0(t2)
	
	
	
#	addi t1, t1, 0xFFFFFFFF	# sanity check of INT boundary
#	addi t1, t1, -46	# sanity check of INT boundary
