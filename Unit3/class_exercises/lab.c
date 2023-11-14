/************
 *  PART 1  *
*************/

/*
 .globl main
.text
main:
	# Tests simple looping behaviour
	li t0, 60
	li t1, 0
loop:
	addi t1, t1, 5
	addi t0, t0, -1
	bne t1, t0, loop  
	bne t1, zero, success
failure:
	li a0, 0
	li a7, 93 
	ecall
success:
	li a0, 42 
	li a7, 93
	ecall
 */

int main(void){
    int a = 60;
    int i = 0;
    while (i != a) {
        i += 5;
        a -= 1;
    }
    if (i == 0) return 0;
	else return 42;
}


/************
 *  PART 2  *
*************/



/************
 *  PART 3  *
*************/



/************
 *  PART 4  *
*************/
