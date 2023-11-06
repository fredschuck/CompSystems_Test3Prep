

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
# Unit 1

## Memory Layout of a Program
## Levels of Program Code
## Registers vs Memory
## Register Operands



# Unit 2

## Load-Store Architecture
- [Load-Store Architecture](https://en.wikipedia.org/wiki/Load–store_architecture)
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
- [Register-Memory Architecture](https://en.wikipedia.org/wiki/Register–memory_architecture)
- Instruction set architecture that allows operations to be performed on/from memory, as well as registers (a.k.a. "Register-Plus-Memory" architecture)
- In a register–memory approach one of the operands for operations such as the ADD operation may be in memory, while the other is in a register. 
- Examples of Register-Memory Architecture:
    - x86
    - VAX
    - Motorola 68000
    - IBM System/360

## Memory-Wall Problem
- [Memory-Wall Problem](https://developer20.com/memory-wall-problem/)
- The memory wall is a problem that occurs when the processor’s speed outpaces the rate at which data can be transferred to and from the memory system.
- To mitigate this problem, L-Cache was introduced. They are SRAMs that are placed between the CPU and the main memory. They are faster than the main memory and smaller in size.

## Dynamic RAM (DRAM) vs Static RAM (SRAM)
- [What is DRAM Frequency : A Complete Guide](https://www.electronicshub.org/what-is-dram-frequency/)
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