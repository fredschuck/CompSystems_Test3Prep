# Instructions

> For all the questions in this quiz, use ONLY the **add, addi, sub, slli, load/store (ld/sd, lw/sw, lhw/shw, lb/sb) instructions** to convert the given C statements to the corresponding RISC-V assembly. The use of registers for their values and memory address are pre-assigned as in the following table. You can use the temporary registers x20-x31. x0 always contains 0 and cannot be changed. At the beginning of the program, the data for all variables and arrays are in memory. The value of a variable or an array element must be stored back to memory EACH time it is modified. The int type has 4 bytes and the long int type has 8 bytes.

| Variables and arrays | int a | int b | long int la | long int lb | int i | int A[] | int B[] |
|----------------------|-------|-------|-------------|-------------|-------|---------|---------|
| Assigned register for data| x1 | x2 | x3 | x4 | x5 |  |  |
|Assigned register for memory addresses | x11 | x12 | x13 | x14 | x15 | Base address: x16 | Base address: x17 |

## Question 1
**a = b * 3 + i * 64**
```s
lw x1, 0(x11)       #load a from memory to register x1
lw x2, 0(x12)       #load b from memory to register x2
lw x5, 0(x15)       #load i from memory to register x5
slli x20, x2, 2     #x20 now has b*4
sub x20, x20, x2    #x20 now has b*4-b = b*3
slli x21, x5, 6     #x21 now has i*64
add x1, x20, x21    #x1 now has b*3 + i*64
sw x1, 0(x11)       #store x1 to memory location of a (x11)
```

## Question 2
**a = A[5]**

**b = B[10]**

**A[8] = a + b * 4**

**B[10] += A[8] + 2**
```s
lw x1, 20(x16)      #load A[5] into x1
sw x1, 0(x11)       #store x1 into a

lw x2, 40(x17)      #load B[10] into b (x2)
sw x2, 0(x12)       #store x2 into b

lw x1, 0(x11)       #load a into a (x1)
lw x2, 0(x12)       #load b into b (x2)
slli x20, x2, 2     #x20 now has b*4
add x20, x20, x1    #x20 now has b*4 + a
sw x20, 32(x16)     #store x20 into A[8]

lw x20, 32(x16)     #load A[8] into x20
lw x21, 40(x17)     #load B[10] into x21
addi x20, x20, 2    #x20 now has A[8] + 2
add x20, x20, x21   #x20 now has A[8] + 2 + B[10]
sw x20, 40(x17)     #store x20 into B[10]
```