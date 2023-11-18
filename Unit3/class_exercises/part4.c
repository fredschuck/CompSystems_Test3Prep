#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (void) {
    int arr[100];
    int max = 0;
    srand(time(NULL));
    // load array with random numbers
    for (int i = 0; i < 100; i++) {
        arr[i] = rand() % 101;
    }
    // find maximum
    for (int i = 0; i < 100; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    printf("%d\n", max);
    return 0;
}