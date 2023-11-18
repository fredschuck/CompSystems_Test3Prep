.data
arr: .space 400
sum: .space 4
avg: .space 4
.text
main:
    	la s0, arr		# s0 = &arr[0] - load arr
    	la s1, sum		# s1 = &sum    - load sum
    	la s2, avg 		# s2 = &avg    - load avg
	li s3, 0 			# s3 = sum
    	li s4, 0 		# s4 = avg
	add s5, s0, x0		# s5 = array pointer
    	li t0, 0 		# t0 = loop variable (i)
	li t2, 100			# t2 = loop upper limit (a)
    	li t3, 100		# t3 = size of array (b)
load: # --------------- load inserts random numbers into array
	bge t0, t2, reset	# if i >= a, go to exit
	li a0, 0			
	li a1, 100			
	li a7, 42			# RandomIntRange system call
	ecall				
	sw a0, 0(s5)		# store random number in array
	addi s5, s5, 4		# shift pointer to next array element	
	addi t0, t0, 1 		# i++
	beq x0, x0, load	# go to load
reset: # ---------------- reset array pointer and loop variable
	add s5, s0, x0		# reset pointer to arr[0]
	add t0, x0, x0		# reset i
add: # ------------------ sum all elements in array
	bge t0, t2, average	# if i >= a, go to exit
	lw t1, 0(s5)		# t1 = arr[i]
	add s3, s3, t1		# sum += arr[i]
	sw s3, 0(s1)		# store sum
	addi s5, s5, 4		# shift pointer to next array element
	addi t0, t0, 1		# i++
	beq x0, x0, add	    # go to add
average: # -------------- calculate average
	div s4, s3, t3		# avg = sum / 100
	sw s4, 0(s2)		# store avg
exit: # ----------------- print avg and exit
	lw a0, 0(s2)
	li a7,1
	ecall