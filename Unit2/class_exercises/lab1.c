#include <stdio.h>
#include <stdlib.h>

/*** PART 1 ***/
int main (void) {
    int sum = 0;
    for (int i = 0; i <= 100; i++) {
        sum += i;
    }
    printf("%d", sum);
    return 0;
}


/*** PART 2 ***/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (void) {
    int arr[100];
    srand(time(NULL));
    for (int i = 0; i < 100; i++) {
        arr[i] = rand() % 101;
    }
    for (int i = 0; i < 100; i++) {
        printf("%d) %d\n", i+1, arr[i]);
    }
    int sum = 0;
    for (int i = 0; i <= 100; i++) {
        sum += i;
    }
    float average = sum / 100;
    printf("%f", average);
    return 0;
}