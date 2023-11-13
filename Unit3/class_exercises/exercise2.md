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
else:   sub x5, x1, x2   #set x5 to have a-b
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
    bne x1, x2, exit
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
    beq x1, x2, exit
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
    beq x1, x2, else
    sub x5, x1, x2
    sw x5, 0(x15)
    beq x0, x0, exit
else:
    sw x0, 0(x15)

```

## Question 4
```c
if (a>=b) a++;
else b++;
```
```s

```

## Question 5
```c
if (a != b) A[4] = a - b;
else A[4] = 0;
```
```s

```

## Question 6
```c
if (a == b) A[4] = a - b;
else A[4] = 0;
```
```s

```

## Question 7
```c
if (a != b) A[i] = a - b;
else A[i] = 0;
```
```s

```

## Question 8
```c
if (a == b) A[i] = a - b;
else A[i] = 0;
```
```s

```

## Question 9
```c
if (A[4] != a ) A[4] = a;
else A[4] = b;
```
```s

```

## Question 10
```c
if (A[i] == B[i] ) A[i] = 0;
else A[i] = A[i] - B[i];
```
```s

```

## Question 11
```c
for (i=0; i<100; i++) {
    a = a + i;
}
```
```s

```

## Question 12
```c
for (i=100; i>=0; i--) {
    a = a + i;
}
```
```s

```

## Question 13
```c
for (i=0; i<100; i++) {
    A[i] = i;
}
```
```s

```

## Question 14
```c
for (i=0; i<100; i++) {
    A[i] = B[i];
}
```
```s

```

## Question 15
```c
for (i=1; i<100; i++) {
    A[i] = B[i-1] + B[i] + B[i+1];
}
```
```s

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

```

## Question 17
```c
i = 0;
while (A[i] != a) {
    i++;
}
```
```s

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

```

## Question 20
```c
for (i = 0; i<100; i++) {
    if (A[i] > B[i]) {
        A[i] = A[i] - B[i];
    } else A[i] = B[i] - A[i];
}
```
```s

```

## Question 21
```c
// Find the max
a = A[0];
for (i=0; i<100; i++) {
   if (A[i] > a) a = A[i];
}
```
```s

```