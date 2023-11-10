![RISC-V Card](<RISC-V Reference Card.png>)


1) Obtain assembly for the following function: 
```c
int strcpy (char x[], char y[]){
    int i = 0;
    while ((x[i]=y[i]) != '\0') { i++; }
    return i;
}
```

Assembly:
```assembly
#RISC-V (64-bits) gcc (trunk)
strcpy(char*, char*):
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48
        sd      a0,-40(s0)
        sd      a1,-48(s0)
        sw      zero,-20(s0)
        j       .L2
.L3:
        lw      a5,-20(s0)
        addiw   a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a5,-20(s0)
        ld      a4,-48(s0)
        add     a4,a4,a5
        lw      a5,-20(s0)
        ld      a3,-40(s0)
        add     a5,a3,a5
        lbu     a4,0(a4)
        sb      a4,0(a5)
        lbu     a5,0(a5)
        sext.w  a5,a5
        snez    a5,a5
        andi    a5,a5,0xff
        bne     a5,zero,.L3
        lw      a5,-20(s0)
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
```

2) Count the number of load and store instructions (ld/sd, lw/sw, lhw/shw, lbu/sbu)
used. = **16**