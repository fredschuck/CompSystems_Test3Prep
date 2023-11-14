# Exercise 2: RISC-V Assembly Programming with add/sub/slli

## Question 1
Using ONLY the add, sub and slli instruction to convert the following C statement to the corresponding RISC-V assembly. Assume that the variables f, g, and j are integers assigned to registers t0, t1, and t2 respectively. You can use other temporary registers such as t3, t4, t5, t6, etc.

`f = g * 3 – j * 16;`

Your Answer:
```s
slli t2, t0, 1 
add t2, t2, t0
slli t3, t1, 4
sub t0, t2, t3
```

## Question 2
Using ONLY the add, sub and slli instruction to convert the following C statement to the corresponding RISC-V assembly. Assume that the variables f, g, and j are integers assigned to registers t0, t1, and t2 respectively. You can use other temporary registers such as t3, t4, t5, t6, etc.

`f = g – j * 33 + f * 2; //Hint: 33 = 32 + 1`

Your Answer:
```s
slli t3, t1, 5 
add t3, t3, t1  
sub t0, t0, t3  
slli t2, t2, 1  
add t0, t0, t2
```