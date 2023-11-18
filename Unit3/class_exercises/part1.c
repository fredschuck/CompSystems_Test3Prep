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