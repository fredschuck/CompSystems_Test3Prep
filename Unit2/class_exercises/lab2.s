.globl main
.data
A: .space 16
sum: .space 4
.text
main: 
    la a0, A        
    la a1, sum
    li t0, 0
    li t1, 10
    li t2, 11
    li t3, 12
    li t4, 13 
    sw t1, 0(a0)
    sw t2, 4(a0)
    sw t3, 8(a0)
    sw t4, 12(a0)
    add t5, t1, t2
    add t6, t3, t4
    add t0, t5, t6
    sw t0, 0(a1)

