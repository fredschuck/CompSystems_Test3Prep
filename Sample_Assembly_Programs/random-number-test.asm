#
# NOTE: The environment calls (ecall) reference is at:
# https://github.com/TheThirdOne/rars/wiki/Environment-Calls
#
# This program generates 5 random numbers between 1 and 10
#
.data	# Tell the assembler we are defining data not code
.text # Tell the assembler that we are writing code (text) now 
main: # Make a label to say where our program should start from
	li t1, 0	# Loop variable
	li t2, 5	# Loop upper limit
loop:
	bge t1, t2, exit
# Call RandIntRange to generate 
# a random integer between 0 and 100
	li a0, 0	# seed the generator
	li a1, 10     	# set the upper bound to 10
	li a7, 42	# set the call to RandIntRange
	ecall 	# the random number will be in a0
# show result ---> call PrintInt
	li a7, 1    # a7 is what determines which system call we are calling, the input is expected to be ib a0
	ecall
# print a carriage return
	li a0, 10	# 10 is the ASCII code for a new line character
	li a7, 11
	ecall
# increment the loop variable
	addi t1, t1, 1
	beq x0, x0,loop
exit: