```s
 .globl main
.text
main:
	# Tests simple looping behaviour
	li t0, 60
	li t1, 0
loop:
	addi t1, t1, 5
	addi t0, t0, -1
	bne t1, t0, loop  
	bne t1, zero, success
failure:
	li a0, 0
	li a7, 93 
	ecall
success:
	li a0, 42 
	li a7, 93
	ecall
```

## PART 1  
Convert and execute the loop.s file from the RARS repo in the test folder.
1. Download or copy-paste the [source file](https://raw.githubusercontent.com/TheThirdOne/rars/master/test/loop.s) and open it with RARS.
2. Convert the loop.s program to a C program that does the same as loop.s.
	- You can execute the C program at [Repl.it](https://repl.it/languages/c) or use the VM you configured earlier.
	- Check [Environment Calls](https://github.com/TheThirdOne/rars/wiki/Environment-Calls) to understand the `ecall` instruction used in the loop.s file. For this program, `ecall` is just a `return <code>` call in C.
3. Assemble and run the loop.s program in RARS. See the screenshot below.
	- Check the address, binary code, instructions and source of the assembled code, and also check the register values and memory values (data segment part) of the program execution.
	- After you run the program multiple times, you should run step-by-step, i.e., instruction by instruction and observe the change of values in registers and other locations.
	- During the step-by-step simulation in RARS, do the simulation in your mind of the corresponding C program to understand how high-level language programs are actually executed by a computer.
	- To see the Labels window, go to the Settings menu and select “Show Labels Window (symbols table).”

	<div style="text-align:center;"><br><br><br><img src="../resources/lab-screenshot_1.png" width="1000"><br><br></div>

```c
int main(void){
    int a = 60;
    int i = 0;
    while (i != a) {
        i += 5;
        a -= 1;
    }
    if (i == 0) return 0;
	else return 42;
}
```


## PART 2
Implement a program to accumulate the integer numbers from 1 to 100 using RISC-V assembly, and simulate the assembly program execution using RARS. You should have already implemented a C program for this task in a previous lab.
1. Using the loop.s program as a starting point, program 1-100 integer accumulation using RISC-V assembly. While the instructions we learned during the class should be sufficient to do the work, you can check RARS [supported instructions](https://github.com/TheThirdOne/rars/wiki/Supported-Instructions) and use them.
2. To print the result and return the result, your program should make an environment call `PrintInt`, check [Environment Calls](https://github.com/TheThirdOne/rars/wiki/Environment-Calls).

```s
.globl main
.data
sum: .space 4
.text
main:
	la t0, sum		# load sum
	li t1, 0 		# t1 += 0
	sw t1, 0(t0)	# store sum
	li t2, 0		# i = 0
	li t3, 101		# a = 101
loop:
	bge t2, t3, exit		# if i >= a, go to exit
	add t1, t1, t2			# sum += i
	sw t1, 0(t0)			# store sum
	addi t2, t2, 1			# i++ 
	beq x0, x0, loop		# if i == a, go to loop
exit:
	lw a0, 0(t0)	# load sum
	li a7, 1 
	ecall
```

## PART 3
Implement a program to find the average of 100 integers that are randomly generated using RISC-V assembly, and simulate the assembly program execution using RARS. You should have already implemented a C program for this task in the previous lab.
1. The program must follow the same steps as the C program you implemented before:
	- Declare an int array of 100 elements, and use a for loop to generate 100 integers and store them in the array;
	- Use another for loop to accumulate those numbers by reading them from the array and adding up to a variable.
	- Calculate the average by dividing the accumulated sum with 100.
	- Print the average and return the average. Your program should NOT do the number generation and accumulation in one loop. You must use two separate loops.
2. You can convert the C program to RISC-V assembly or write directly the RISC-V assembly. After that, simulate its execution using RARS.
	- To use arrays in assembly code, your code needs to reserve space in the data section.
	- Check the memory.s file in the RARS repo (https://github.com/TheThirdOne/rars/blob/master/test/memory.s) and the previous lab for using `.space` to reserve memory for an array identified by a symbol, and how to use the `la` instruction to load the base memory address (first element of the array) to a register

```s
.data
arr: .space 400
sum: .space 4
avg: .space 4
.text
main:
    la s0, arr			# s0 = &arr[0] - load arr
    la s1, sum			# s1 = &sum    - load sum
    la s2, avg 			# s2 = &avg    - load avg
	li s3, 0 			# s3 = sum
    li s4, 0 			# s4 = avg
	add s5, s0, x0		# s5 = array pointer
    li t0, 0 			# t0 = loop variable (i)
	li t2, 100			# t2 = loop upper limit (a)
    li t3, 100			# t3 = size of array (b)
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
	beq x0, x0, add	    # go to sum
average: # -------------- calculate average
	div s4, s3, t3		# avg = sum / 100
	sw s4, 0(s2)		# store avg
exit: # ----------------- print avg and exit
	lw a0, 0(s2)
	li a7,1
	ecall
```


## PART 4
Implement a program to find the maximum number in an array of 100 integers that are randomly generated, using both C and RISC-V assembly, and simulate the assembly program execution using RARS. The program should follow these steps:
1. Declare an array that has 100 elements.
2. Use a for loop to randomly generate 100 integers and store them in the array.
	- You should use the RandIntRange system call.
	- See https://github.com/TheThirdOne/rars/wiki/Environment-Calls
3. Use another for loop to find the max value in the array and return it.
4. Write a main program in C from https://repl.it/languages/c and make sure it executes correctly. You should use an algorithm similar to the one discussed in the lecture slides to find the minimum of an array.
5. Converting the C program to RISC-V assembly and simulating the program execution using RARS.

```s
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
update: # --------------- max = temp
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
```