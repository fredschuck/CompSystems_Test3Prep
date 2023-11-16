.data	# Tell the assembler we are defining data not code
	f: .word 0
.text # Tell the assembler that we are writing code (text) now
Main:
	addi x20, x0, 15	# g = 15
	addi x21, x0, 8		# h = 8
	addi x22, x0, 5		# i = 5
	addi x23, x0, 5	# j = 10
	bne x22, x23, Else 	# branch if not equal       
	add x19, x20, x21   # Then path       
	beq x0, x0, Exit    # unconditional branch
Else: 
	sub x19, x20, x21	# Else path 
Exit:
	la x28, f
	sw x19, 0(x28)
	# done 
