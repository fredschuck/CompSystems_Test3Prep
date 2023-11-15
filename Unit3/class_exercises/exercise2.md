# Unit 3 Exercise 2: Translate C Statements to RISC-V Assembly Using Branch Instructions

## Instructions
For all the questions, use **ONLY** the `add`, `addi`, `sub`, `slli`, `load`/`store` (`ld`/`sd`, `lw`/`sw`, `lhw`/`shw`, `lb`/`sb`), `beq`, `bne`, `bge`, and `blt` instructions to convert the given C statements to the corresponding RISC-V assembly. The use of registers for their values and memory address are pre-assigned in the following table. You can use the temporary registers t0-t6. Register x0 always contains 0 and cannot be changed. At the beginning of the program, the data for all variables and arrays are in memory, and data must be loaded to register in order to use it. The value of a variable or an array element must be stored back to memory EACH time it is modified. The int type has 4 bytes and the long int type has 8 bytes. 

| Variables and arrays | int a | int b | int i | int A[] | int B[] |
|----------------------|-------|-------|-------|---------|---------|
| Assigned register for data| x1 | x2 | x5 |  |  |
|Assigned register for memory addresses | x11 | x12 | x15 | Base address: x16 | Base address: x17 |

### Example 
```c
if (a == b) i = 0;
else i = a - b;
```
```s
        ld x1, 0(x11)    #load a
        ld x2, 0(x12)    #load b
        bne x1, x2, else #if a != b
        addi x5, x0, 0   #set x5 to 0 for i
        sd x5, 0(x15)    #i = 0, store to memory
        beq x0, x0, exit #jump to exit for the loop
else:   
        sub x5, x1, x2   #set x5 to have a-b
        sd x5, 0(x15)    #i=a-b, store to memory
exit: 
```


## Question 1 
```c
if (a == b) i = 0;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        bne x1, x2, exit    #if a != b, jump to exit
        sw x0, 0(x15)
exit:
```

## Question 2
```c
if (a != b) i = a-b;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        beq x1, x2, exit    #if a == b, jump to exit
        sub x5, x1, x2
        sw x5, 0(x15)
exit:
```

## Question 3
```c
if (a != b) i = a-b;
else i = 0;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        beq x1, x2, else    #if a == b, jump to else
        sub x5, x1, x2
        sw x5, 0(x15)
        beq x0, x0, exit
else:   
        sw x0, 0(x15)       #i = 0
exit:
```

## Question 4
```c
if (a>=b) a++;
else b++;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        ble x1, x2, else    #if a < b, jump to else
        addi x1, x1, 1
        sw x1, 0(x11)
        beq x0, x0, exit
else:   
        addi x2, x2, 1
        sw x2, 0(x12)
exit:
```

## Question 5
```c
if (a != b) A[4] = a - b;
else A[4] = 0;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        beq x1, x2, else    #if a == b, jump to else
        sub x20, x1, x2
        sw x20, 16(x16)
        beq x0, x0, exit
else:   
        sw x0, 16(x16)
exit:
```

## Question 6
```c
if (a == b) A[4] = a - b;
else A[4] = 0;
```
```s
        lw x1, 0(x11)  
        lw x2, 0(x12)
        bne x1, x2, else     #if a != b, jump to else
        sub x20, x1, x2
        sw x20, 16(x16)
        beq x0, x0, exit     #jump to exit
else:   
        sw x0, 16(x16)
exit:
```

## Question 7
```c
if (a != b) A[i] = a - b;
else A[i] = 0;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        lw x5, 0(x15)   
        slli x20, x5, 2       #x20 = i*4 bytes (size of each entry in array)
        addi x20, x20, x16    #x20 = &A[i]
        beq x1, x2, else      #if a == b, jump to else
        sub x21, x1, x2
        beq x0, x0, exit      #jump to exit
        sw x21, 0(x20)        #A[i] = a - b
else:   
        sw x0, 0(x20)
exit:
```

## Question 8
```c
if (a == b) A[i] = a - b;
else A[i] = 0;
```
```s
        lw x1, 0(x11)
        lw x2, 0(x12)
        lw x5, 0(x15)
        slli x20, x5, 2        #x20 = i*4 bytes (size of each entry in array)
        add x20, x20, x16      #add base address to offset (&A[0] + i*4 = &A[i])
        bne x1, x2, else
        sub x21, x1, x2        #x21 = a - b
        sw x21, 0(x20)         #A[i] = a - b (Since x20 is the address of A[i], we use offset 0)
        beq x0, x0, exit       #jump to exit
else:   
        sw x0, 0(x20)          #A[i] = 0
exit:
```

## Question 9
```c
if (A[4] != a) A[4] = a;
else A[4] = b;
```
```s
        lw x1, 0(x11)
        lw x20, 16(x16)         #load A[4]
        beq x1, x20, else       #if A[4] == a, jump to else
        sw x1, 16(x16)
        beq x0, x0, exit
else:   
        lw x2, 0(x12)
        sw x2, 16(x16)
exit:
```

## Question 10
```c
if (A[i] == B[i]) A[i] = 0;
else A[i] = A[i] - B[i];
```
```s
        lw x5, 0(x15)            #load i
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17        #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        lw x24, 0(x21)           #x24 = A[i]
        lw x25, 0(x22)           #x25 = B[i]
        bne x24, x25, else #if A[i] != B[i], jump to else
        sw x0, 0(x21)            #A[i] = 0 
        beq x0, x0, exit
else:   
        sub x23, x24, x25        #x23 = A[i] - B[i]
        sw x23, 0(x21)           #A[i] = A[i] - B[i]
exit:
```

## Question 11
```c
for (i=0; i<100; i++) {
    a = a + i;
}
```
```s
        li x5, 0                #i = 0
        li x23, 100             #x23 = 100 (We can use a register to hold 100 or use 100 itself)
loop:   
        bge x5, x23, exit       #if i >= 100, jump to exit
        add x1, x1, x5          #a = a + i
        addi x5, x5, 1          #i++
        beq x0, x0, loop        #jump to loop
exit:
```

## Question 12
```c
for (i=100; i>=0; i--) {
    a = a + i;
}
```
```s
        li x5, 100              #i = 100
loop:   
        blt x5, x0, exit        #if i < 0, jump to exit
        add x1, x1, x5          #a = a + i
        addi x5, x5, -1         #i--
        beq x0, x0, loop        #jump to loop
exit:
```

## Question 13
```c
for (i=0; i<100; i++) {
    A[i] = i;
}
```
```s
        li x5, 0                #i = 0
        li x23, 100             #x23 = 100
loop:   
        bge x5, x23, exit       #if i >= 100, jump to exit
        slli x20, x5, 2         #x20 = i*4 bytes (size of each entry in array)
        add x20, x20, x16       #add base address to offset (&A[0] + i*4 = &A[i]) - x20 = &A[i]
        sw x5, 0(x20)           #A[i] = i
        addi x5, x5, 1          #i++
        beq x0, x0, loop        #jump to loop
exit:
```

## Question 14
```c
for (i=0; i<100; i++) {
    A[i] = B[i];
}
```
```s
        li x5, 0                #i = 0
        li x23, 100             #x23 = 100
loop:   
        bge x5, x23, exit       #if i >= 100, jump to exit
        slli x20, x5, 2         #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16       #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17       #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        lw x24, 0(x22)          #x24 = B[i]
        sw x24, 0(x21)          #A[i] = B[i]
        addi x5, x5, 1          #i++
        beq x0, x0, loop        #if i < 0, jump to loop 
exit:
```

## Question 15 ****
```c
for (i=1; i<100; i++) {
    A[i] = B[i-1] + B[i] + B[i+1];
}
```
```s
        li x5, 1                 #i = 1
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17        #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        lw x24, -4(x22)          #x24 = B[i-1]
        lw x25, 0(x22)           #x25 = B[i]
        add x23, x24, x25        #x23 = B[i-1] + B[i]
        lw x24, 4(x22)           #x24 = B[i+1]
        add x23, x23, x24        #x23 = B[i-1] + B[i] + B[i+1]
        sw x23, 0(x21)           #A[i] = B[i-1] + B[i] + B[i+1]
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```

## Question 16
```c
i = 0;
while (i<100) {
    A[i] = B[i];
    i++;
}
```
```s
        li x5, 0                 #i = 0
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17        #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        lw x23, 0(x22)           #x22 = B[i]
        sw x23, 0(x21)           #A[i] = B[i]
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```

## Question 17
```c
i = 0;
while (A[i] != a) {
    i++;
}
```
```s
        li x5, 0                 #i = 0
        lw x1, 0(x11)            #load a
loop:   
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        lw x22, 0(x21)           #x22 = A[i]
        beq x22, x1, exit        #if A[i] == a, jump to exit
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```
### OR
```s
        li x5, 0                 #i = 0
        lw x1, 0(x11)            #load a
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        lw x22, 0(x21)           #x22 = A[i]
loop:   
        beq x22, x1, exit        #if A[i] == a, jump to exit
        addi x5, x5, 1           #i++
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        lw x22, 0(x21)           #x22 = A[i]
        beq x0, x0, loop         #jump to loop
exit:
```

## Question 18
```c
i = 0;
while (i<100) {
    if (A[i] == a) break;
    i++;
}
```
```s
        li x5, 0                 #i = 0
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        lw x22, 0(x21)           #x22 = A[i]
        beq x22, x1, break        #if A[i] == a, jump to break
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
break:
exit:
```

## Question 19
```c
for (i = 0; i<100; i++) {
    if (A[i] > B[i]) {
        a = A[i];
        A[i] = B[i];
        B[i] = a; 
    } 
}
```
```s
        lw x1, 0(x11)            #load a
        li x5, 0                 #i = 0
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17        #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        lw x24, 0(x21)           #x24 = A[i]
        lw x25, 0(x22)           #x25 = B[i]
        blt x24, x25, else       #if A[i] < B[i], jump to else
        beq x24, x25, else       #if A[i] == B[i], jump to else
        sw x24, 0(x11)           #a = A[i]
        sw x25, 0(x21)           #A[i] = B[i]
        sw x1, 0(x22)            #B[i] = a
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
else:   
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```

## Question 20 - This is not correct - need to fix
```c
for (i = 0; i<100; i++) {
    if (A[i] > B[i]) {
        A[i] = A[i] - B[i];
    } else A[i] = B[i] - A[i];
}
```
```s
        li x5, 0                 #i = 0
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        add x22, x20, x17        #add base address to offset (&B[0] + i*4 = &B[i]) - x22 = &B[i]
        blt 0(x21), 0(x22), else #if A[i] < B[i], jump to else
        beq 0(x21), 0(x22), else #if A[i] == B[i], jump to else
        sub x24, 0(x21), 0(x22)  #x23 = A[i] - B[i]
        sw x24, 0(x21)           #A[i] = A[i] - B[i]
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
else:   
        sub x24, 0(x22), 0(x21)  #x23 = B[i] - A[i]
        sw x24, 0(x21)           #A[i] = B[i] - A[i]
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```

## Question 21 - This is not correct - need to fix
```c
// Find the max
a = A[0];
for (i=0; i<100; i++) {
   if (A[i] > a) a = A[i];
}
```
```s
        sw 0(x16), 0(x11)        #a = A[0]
        li x5, 0                 #i = 0
        li x23, 100              #x23 = 100
loop:   
        bge x5, x23, exit        #if i >= 100, jump to exit
        slli x20, x5, 2          #x20 = i*4 bytes (size of each entry in array)
        add x21, x20, x16        #add base address to offset (&A[0] + i*4 = &A[i]) - x21 = &A[i]
        blt 0(x21), 0(x11), else #if A[i] < a, jump to else
        beq 0(x21), 0(x11), else #if A[i] == a, jump to else
        sw 0(x21), 0(x11)        #a = A[i]
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
else:   
        addi x5, x5, 1           #i++
        beq x0, x0, loop         #jump to loop
exit:
```