.globl main
.data
sum: .space 4
.text
main:
	la t0, sum			# load sum
	li t1, 0			# t1 += 0
	sw t1, 0(t0)		# store sum
	li t2, 0			# i = 0
	li t3, 101			# a = 101
loop:	
	bge t2, t3, exit	# i >= a go to exit
	add t1, t1, t2		# sum += i
	sw t1, 0(t0)		# store sum
	addi t2, t2, 1		# i++ 
	beq x0, x0, loop	# go to loop
exit:
	lw a0, 0(t0)
	li a7, 1 
	ecall