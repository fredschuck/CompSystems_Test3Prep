

- [Environment Calls](https://github.com/TheThirdOne/rars/wiki/Environment-Calls)
- [Assembler Directives](https://github.com/TheThirdOne/rars/wiki/Assembler-Directives)
- [Supported Instructions](https://github.com/TheThirdOne/rars/wiki/Supported-Instructions)
- [Creating 'Hello World'](https://github.com/TheThirdOne/rars/wiki/Creating-Hello-World)

Example: 
- f = g - j + f * 16
- f = (g - j) + (f * 16)
- r1 = f * 16 (if it were 15, use (16 - 1))
    - mult --> shift to the left
    - 16 = 2^4
- r2 = g - j
- r3 = r2 + r1

# Assembly Cheatsheet
> ⭐️ **REVIEW FOLLOWING EXERCISES:**
**[Exercise A](Unit2/class_exercises/exercise2.md) | [Exercise B](Unit3/class_exercises/exercise2.md)**

## Starting an Assembly Program
```s
.globl <function name>  #global label - this function is globally accessible
.data 
    A:      .space 32   #allocate 32 bytes of memory for A
    sum:    .space 4    #allocate 4 bytes of memory for sum
.text

<function name>:         #function label (i.e. "main")
    #code goes here
```
## Example Assembly Program
```s
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
```

## Addition

**c = a + b**
```s
    lw x1, 0(x11)       #load a from memory to a's temp register (x1)
    lw x2, 0(x12)       #load b from memory to b's temp register (x2)
    add x3, x1, x2      #x20 = x1 - x2
    sw x3, 0(x13)       #save to memory by storing to memory location
```
**a = i++**
```s
lw x5, 0(x15)       #load i from memory to register x5 
add x1, x5, 0       #a = i
addi x5, x5, 1      #i++
sw x1, 0(x11)       #store x1 to memory location of a (x11)
sw x5, 0(x15)       #store x5 to memory location of i (x15)
```
> NOTE: Use `addi` when `+=`, `++` or `--` is used.

## Subtracting
When doing a regular subtraction, we simply use the `sub` instruction.

**a = a - b**
```s
    lw x1, 0(x11)       #load a from memory to a's temp register (x1)
    lw x2, 0(x12)       #load b from memory to b's temp register (x2)
    sub x1, x1, x2      #x1 = x1 - x2
    sw x1, 0(x11)       #save to memory by storing to memory location
```
The following equation is to be done immediately, for which no immediate instruction exists for subtracting, so we use `addi` to effectively do the same thing.

**a--**
```s
    lw x1, 0(x11)       #load to temp register from memory location
    addi x1, x1, -1     #use 'add immediate' instruction to add -1
```
<!-- ```
a -= b
    lw x1, 0(x11)       #load a from memory to a's temp register (x1)
    lw x2, 0(x12)       #load b from memory to b's temp register (x2)
    neg x2, x2          #negate b's value, so b is now -b
    addi x1, x1, x2     #x1 = x1 + -x2
    sw x1, 0(x11)       #save to memory by storing to memory location
``` -->
## Multiplication 
**a = b * 3 + i * 4**
```s

    lw x2, 0(x12)       #load b from memory to b's temp register (x2)
    slli x20, x2, 1     #x20 now has b*2^1 (use a new, temp register to hold partial value)
    add x20, x20, x2    #x20 now has b*2 + b (add b to that temp register)
    lw x5, 0(x15)       #load i from memory to register x5
    slli x21, x5, 2     #x21 now has i*4 
    add x1, x20, x21    #x1 now has b*3 + i*4
    sw x1, 0(x11)       #store x1 to memory location of a (x11)
```
**a = b * 32 + i * 65**
```s
    lw x2, 0(x12)       #load b from memory to b's temp register (x2)
    slli x20, x2, 5     #x20 now has b*2^5 (32)
    lw x5, 0(x15)       #load i from memory to register x5
    slli x21, x5, 5     #x21 now has i*2^6 (64)
    add x21, x21, x5    #add i to the result to make it i*65
    add x1, x20, x21    #x1 now has b*32 + i*65
    sw x1, 0(x11)       #store x1 to memory location of a (x11)
```
## Division

## Arrays
### Steps to obtain A[i]
- What is the base address of A[]?         `(&A[] = x16)`
- What the size of each entry in A[]?      `(int = 4 bytes)`

| Steps                                      | Assembly          |
|--------------------------------------------|-------------------|
| 1. Multiply i by the size of each entry    |`slli x20, x5, 2`  | 
| 2. Add that to base address to move to the target address    |`add x21, x20, x16`|
| 3. Now that `x21` holds the _address_, load the value from that address        |`lw x22, 0(x21)  ` |

If we need to access `A[i+2]` or `A[i-1]`, for example, we can do the following:
- Since we already know that `x21` holds the _address_ of `A[i]`, we can simply add 8 to it to get the address of `A[i+2]` or subtract 4 to get the address of `A[i-1]`.
```s
addi x21, x21, 8     #A[i+2]
addi x21, x21, -4    #A[i-1]
```

**A[i] = A[i] + a**
```s
slli x20, x5, 2     #x20 now holds i * 4 for the offset
add x21, x20, x16   #Add i to base address (&) of A[] to get &A[i]
lw x22, 0(x21)      #Load word from A[i] to x22 
add x22, x22, x1    #A[i] + a 
sw x22, 0(x21)      #Store back to memory for A[i]
```
## Loops

## Conditionals


# Unit 1

## Memory Layout of a Program
<!-- Discuss where memory is stored. For example, the memory for an array's elements is stored in stack. Dynamically allocated memory using malloc is in heap. -->
- There is a stack size limit, so `A[10,000]` won't work.

## Levels of Program Code
- High-Level Language:
    - Level of abstraction closer to problem domain
    - Provides for productivity and portability
- Machine-Level Code:
    - Textual representation of binary instructions
    - Interface between hardware and software
    - Assembly
- Harware-Level Code:
    - Binary digits (bits)
    - Encoded instructions and data

## The RISC-V Instruction Set Architecture (ISA)
## Registers vs Memory
- Registers are faster than memory

## Register Operands
- Three kinds of operands:
    1) Register Operands (x0 - x31)
    2) Immediate Operands (0, 10, -8)
    3) Memory Operands (0(x1), 16(x2), -8(x3))

- Three classes of instructions:
    1) Arithmetic-logic instructions (add, sub, addi, slli)
    2) Memory load/store instructions (lw/sw, ld/sd)
    3) Control transfer instructions (beq, jal, jr)

- Register file is 32 x 64 bits
    - x0 is hardwired to 0
    - x1-x31 are general purpose registers
    - x1: return address of a function
    - x2: stack pointer of a function
    - x3: global pointer
    - x4: thread pointer
    - x5-x7, x28-x31: temporary registers
    - x8: frame pointer
    - x9, x18-x27: saved registers
    - x10-x11: function arguments and results
    - x12-x17: function arguments



# Unit 2

## Load-Store Architecture
[Load-Store Architecture](https://en.wikipedia.org/wiki/Load–store_architecture)
- Divides instructions into two categories:
    - Memory Access: Load and store bethween memory and registers
    - ALU Operations: Operate on data between registers only
- Examples of Load-Store Architecture:
    - MIPS
    - PowerPC
    - ARM
    - SPARC
    - RISC-V
- Both operands and destination for an ADD operation must be in registers.
- Many GPU's also use this architecture

## Register-Memory Architecture
[Register-Memory Architecture](https://en.wikipedia.org/wiki/Register–memory_architecture)
- Instruction set architecture that allows operations to be performed on/from memory, as well as registers (a.k.a. "Register-Plus-Memory" architecture)
- In a register–memory approach one of the operands for operations such as the ADD operation may be in memory, while the other is in a register. 
- Examples of Register-Memory Architecture:
    - x86
    - VAX
    - Motorola 68000
    - IBM System/360

## Memory-Wall Problem
[Memory-Wall Problem](https://developer20.com/memory-wall-problem/)
- The memory wall is a problem that occurs when the processor’s speed outpaces the rate at which data can be transferred to and from the memory system.
- To mitigate this problem, L-Cache was introduced. They are SRAMs that are placed between the CPU and the main memory. They are faster than the main memory and smaller in size.

## Dynamic RAM (DRAM) vs Static RAM (SRAM)
[What is DRAM Frequency : A Complete Guide](https://www.electronicshub.org/what-is-dram-frequency/)

| DRAM Generation | Frequency Range     |
|-----------------|---------------------|
| DDR1            | 200 MHz to 400 MHz |
| DDR2            | 400 MHz to 1600 MHz|
| DDR3            | 800 MHz to 2133 MHz|
| DDR4            | 1600 MHz to 5333 MHz|
| DDR5            | 3200 MHz to 6400 MHz|

- SRAM is faster than DRAM
- The DRAM frequency is measured in megahertz (MHz) and indicates how many cycles the DRAM can perform in one second.
- Actual data transfer speed within the DRAM is about **half** of the stated **frequency**.

