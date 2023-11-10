# Instructions

> For all the questions in this quiz, use ONLY the add, addi, sub, slli, load/store (ld/sd, lw/sw, lhw/shw, lb/sb) instructions to convert the given C statements to the corresponding RISC-V assembly. The use of registers for their values and memory address are pre-assigned as in the following table. You can use the temporary registers x20-x31. x0 always contains 0 and cannot be changed. At the beginning of the program, the data for all variables and arrays are in memory. The value of a variable or an array element must be stored back to memory EACH time it is modified. The int type has 4 bytes and the long int type has 8 bytes.

| Variables and arrays | int a | int b | long int la | long int lb | int i | int A[] | int B[] |
|----------------------|-------|-------|-------------|-------------|-------|---------|---------|
| Assigned register for data| x1 | x2 | x3 | x4 | x5 |  |  |
|Assigned register for memory addresses | x11 | x12 | x13 | x14 | x15 | Base address: x16 | Base address: x17 |


# Question 1
**a = b * 3 + i * 4**
```s
lw x2, 0(x12)       #load b from memory to register x2
slli x20, x2, 1     #x20 now has b * 2
add x20, x20, x2    #x20 now has b*2 + b 
lw x5, 0(x15)       #load i from memory to register x5
slli x21, x5, 2     #x21 now has i * 4 
add x1, x20, x21    #x1 now has b*3 + i*4
sw x1, 0(x11)       #store x1 to memory location of a (x11)
```

## Question 2

```s
lw x2, 0(x12)       #load b from memory to register x2
slli x20, x2, 5     #x20 now has b*32
add x20, x20, x2    #x20 now has b*32 + b 
lw x5, 0(x15)       #load i from memory to register x5
slli x21, x5, 1     #x21 now has i*2 
add x1, x20, x21    #x22 now has b*33 + i*2
sw x1, 0(x11)       #store x1 to memory location of a (x11)
```

## Question 3

```s
lw x1, 0(x11)       #load a from memory to register x1
slli x3, x1, 10     #x3 now has a*2^10 
sd x3, 0(x13)       #store x20 into memory location for la (x13)

lw x2, 0(x12)       #load b from memory to register x2
slli x4, x2, 30     #x4 now has b*2^30
sd x4, 0(x24)       #store x4 into data register for lb (x14)

add x3, x3, x4      #x3 now has la + lb
sd x3, 0(x13)       #store x3 into data register for la (x13)
```

## Question 4

```s
lw x5, 0(x15)       #load i from memory to register x5 
add x1, x5, 0       #a = i
addi x5, x5, 1      #i++
sw x5, 0(x11)       #store x5 to memory location of a (x11)
```

## Question 5

```s
lw x1, 0(x11)       #load a from memory to register x1
addi x1, x1, 10     #add 10 to a and save to a
sw x1, 0(x11)       #store x1 into memory location of a (x11)
```

## Question 6

```s
lw x1, 0(x11)
slli x1, x1, 7
sw x1, 0(x11)

lw x2, 0(x12)
addi x2, x2, 10
sw x2, 0(x12)

sub x1, x1, x2
sw x1, 0(x11)

ld x3, 0(x13)
addi x3, x1, x2
sd x3, 0(x13)
```

## Question 7

```s
lw x20, 40(x16)
sw x20, 0(x11)
lw x21, 80(x17)
sw x21, 0(x12)
```

## Question 8

```s
lw x1, 0(x11)
sw x1, 16(x16)

lw x2, 0(x12)
lw x5, 0(x15)
add x20, x2, x5
sw x20, 32(x17)
```

## Question 9

```s
lw x1, 0(x11)
lw x20, 40(x17)
add x21, x20, x1
sw x21, 40(x16)

lw x22, 80(x16)
lw x23, 80(x17)
add x22, x22, x23
sw x22, 80(x16)

lw x23, 120(x16) 
lw x24, 120(x17) 
addi x23, x23, x24
sw x23, 120(x16)
```

## Question 10

```s
lw x1, 0(x11)
lw x2, 0(x12)
lw x5, 0(x15)
add x5, x1, x2
sw x5, 0(x15)
add x21, x16, x5    #Add i to base address of A[] to get address of A[i]
lw x22, 0(x21)      #Load word from A[i] to x22 
add x23, x22, x1    #A[i] + a 
sw x23, 0(x21) 
add x24, x16, x5
lw x25, 0(x24)
sw x25, 0(x11)
sw x22, 0(x12)      #x22 currently holds A[i]  
sub x20, x5, 1      #x20 now holds i-1
add x26, x17, x20   #Add x20 to base address of B[] to get address of B[i-1]
lw x27, 0(x26)      #Load word from B[i-1] to x27
lw x1, 0(x11)       #Load a from memory to register x1
addi x1, x27, x1    #Add the loaded word in x27 to a 
sw x1, 0(x11)       #Store back to memory for a
```

## Question 11

```s
lw x1, 0(x11)
lw x2, 0(x12)
add x5, x1, x2

add x19, x16, x5    #x19 now holds base address of A[i]
lw x20, 0(x19)
add x20, x20, x1
sw x20, 0(x19)

add x20, x17, x5    #x20 now holds base address of B[i]
lw x22, 0(x20)      #x22 holds B[i]
lw x23, -8(x20)     #x23 holds B[i-2]
lw x24, -4(x20)     #x24 holds B[i-1]
lw x25, 4(x20)      #x25 holds B[i+1]
lw x26, 8(x20)      #x26 holds B[i+2]
add x21, x23, x24   #x21 holds B[i-2] + B[i-1]
add x27, x22, x25   #x27 holds B[i] + B[i+1]
add x28, x21, x27   #x28 holds B[i-2] + B[i-1] + B[i] + B[i+1]
add x29, x28, x26   #x29 holds x28 + B[i+2]
sw x29, 0(x19)
```