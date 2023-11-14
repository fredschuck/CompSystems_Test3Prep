# Instructions

> For all the questions in this quiz, use ONLY the **add, addi, sub, slli, load/store (ld/sd, lw/sw, lhw/shw, lb/sb) instructions** to convert the given C statements to the corresponding RISC-V assembly. The use of registers for their values and memory address are pre-assigned as in the following table. You can use the temporary registers x20-x31. x0 always contains 0 and cannot be changed. At the beginning of the program, the data for all variables and arrays are in memory. The value of a variable or an array element must be stored back to memory EACH time it is modified. The int type has 4 bytes and the long int type has 8 bytes.

| Variables and arrays | int a | int b | long int la | long int lb | int i | int A[] | int B[] |
|----------------------|-------|-------|-------------|-------------|-------|---------|---------|
| Assigned register for data| x1 | x2 | x3 | x4 | x5 |  |  |
|Assigned register for memory addresses | x11 | x12 | x13 | x14 | x15 | Base address: x16 | Base address: x17 |


## Question 1
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
**a = b * 33 + i * 2** // Hint: 33 = 32 + 1
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
**la = a * 1024**

**lb = b * 2^30**

**la = la + lb**
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
**a = i++**
```s
lw x5, 0(x15)       #load i from memory to register x5 
add x1, x5, x0      #a = i
sw x1, 0(x11)       #store x1 to memory location of a (x11)
addi x5, x5, 1      #i++
sw x5, 0(x11)       #store x5 to memory location of i (x15)
```

## Question 5
**a += 10**
```s
lw x1, 0(x11)       #load a from memory to register x1
addi x1, x1, 10     #add 10 to a and save to a
sw x1, 0(x11)       #store x1 into memory location of a (x11)
```

## Question 6
**a = a * 128**

**b += 10**

**a -= b**

**la += a + b**
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
add x20, x1, x2
addi x3, x3, x20
sd x3, 0(x13)
```

## Question 7
**a = A[10]**

**b = A[20]**
```s
lw x1, 40(x16)
sw x1, 0(x11)
lw x2, 80(x17)
sw x2, 0(x12)
```

## Question 8
**A[4] = a**

**B[8] = b + i**
```s
lw x1, 0(x11)
sw x1, 16(x16)

lw x2, 0(x12)
lw x5, 0(x15)
add x20, x2, x5
sw x20, 32(x17)
```

## Question 9
**A[10] = B[10] + a**

**A[20] = A[20] + B[20]**

**A[30] += B[30]**
```s
lw x1, 0(x11)
lw x20, 40(x17)
add x20, x20, x1
sw x20, 40(x16)

lw x20, 80(x16)
lw x21, 80(x17)
add x20, x20, x21
sw x20, 80(x16)

lw x20, 120(x16) 
lw x21, 120(x17) 
addi x21, x21, x20
sw x21, 120(x16)
```

## Question 10
**i = a + b**

**A[i] = A[i] + a**

**a = B[i]**

**b = A[i]**

**a += B[i-1]**

```s
lw x1, 0(x11)
lw x2, 0(x12)
add x5, x1, x2
sw x5, 0(x15)

slli x20, x5, 2     #x20 now holds i * 4 for the offset
add x21, x20, x16   #Add i to base address (&) of A[] to get &A[i]
lw x22, 0(x21)      #Load word from A[i] to x22 
add x22, x22, x1    #A[i] + a 
sw x22, 0(x21)      #Store back to memory for A[i]

add x21, x20, x17   #Add i to base address of B[] to get &B[i] - Remember that x20 still holds i * 4
lw x1, 0(x21)       #Load word from B[i] to x25
sw x1, 0(x11)       #Store back to memory for a

add x21, x20, x16   #Add i * 4 to &A[] to move to &A[i] - Remember that x20 still holds i * 4
lw x2, 0(x21)       #Load word from A[i] to b (x2)
sw x2, 0(x12)       #Store back to memory for b

addi x20, x5, -1    #x20 now holds i-1
slli x20, x20, 2    #x20 now holds (i-1) * 4
add x21, x20, x17   #Add (i-1) to base address of B[] to get &B[i-1]
lw x22, 0(x21)      #Load word from B[i-1] to x22
lw x1, 0(x11)       #Load word from a to x1
addi x1, x22, x1    #Add the loaded word in x22 to a
sw x1, 0(x11)       #Store back to memory for a
```

## Question 11
**i = a + b**

**A[i] = A[i] + a**

**A[i] = B[i-2] + B[i-1] + B[i] + B[i+1] + B[i+2]**

```s
lw x1, 0(x11)
lw x2, 0(x12)
add x5, x1, x2
sw x5, 0(x15)

slli x20, x5, 2     #x20 now holds i * 4 for the offset
add x21, x16, x20   #x21 now holds base address of A[i]
lw x23, 0(x20)      #x20 holds value of A[i]
add x23, x23, x1    #A[i] + a
sw x23, 0(x21)      #Store back to memory for A[i]

add x22, x17, x20   #x20 now holds base address of B[i] - Remember that x20 still holds i * 4
lw x23, 0(x22)      #x23 holds B[i]
lw x24, 4(x22)      #x24 holds B[i+1]
add x23, x23, x24   #x23 holds B[i] + B[i+1]
lw x24, 8(x22)      #x24 holds B[i+2]
add x23, x23, x24   #x23 holds B[i] + B[i+1] + B[i+2]
lw x24, -4(x22)     #x24 holds B[i-1]
add x23, x23, x24   #x23 holds B[i] + B[i+1] + B[i+2] + B[i-1]
lw x24, -8(x22)     #x24 holds B[i-2]
add x23, x23, x24   #x23 holds B[i] + B[i+1] + B[i+2] + B[i-1] + B[i-2]
sw x23, 0(x21)      #Store back to memory for A[i]
```