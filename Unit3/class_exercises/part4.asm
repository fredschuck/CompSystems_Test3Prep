.data
arr: .space 400
max: .space 4
temp: .space 4
.text
main:
    la s0, arr			# s0 = &arr[0] - load arr
    la s1, max			# s1 = &max    - load max
    la s2, temp 		# s2 = &temp   - load temp
	li s3, 0 			# s3 = sum
    li s4, 0 			# s4 = temp
	li s6, 0			# s6 = max
	add s5, s0, x0		# s5 = array pointer
    li t0, 0 			# t0 = loop variable (i)
	li t1, 100			# t1 = loop upper limit (a)
load: # --------------- load inserts random numbers into array
	bge t0, t1, reset	# if i >= a, go to exit
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
loop: # ----------------- find max element in array
	bge t0, t1, exit	# if i >= a, go to exit
	lw t2, 0(s5)		# t2 = arr[i]
	add s4, t2, x0		# temp = arr[i]
	sw s4, 0(s2)		# store temp
	bgt s4, s6, update	# if temp > max, go to update
	addi s5, s5, 4		# shift pointer to next array element
	addi t0, t0, 1		# i++
	beq x0, x0, loop	# go to loop
update: # --------------- update max
	lw s6, 0(s2)		# max = temp
	sw s6, 0(s1)		# store max
	bge t0, t1, exit	# if i >= a, go to exit
	addi s5, s5, 4		# shift pointer to next array element
	addi t0, t0, 1		# i++
	beq x0, x0, loop	# go to loop
exit: # ----------------- print max and exit
	lw a0, 0(s1)
	li a7,1
	ecall