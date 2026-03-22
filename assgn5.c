#include <stdio.h>

int main() {
    int array[5] = {1,2,3,4,5};
    int size = sizeof(array) / sizeof(array[0]); // Gets the size of the array

    for (int i = 0; i < size; i++) {
        *(array + i) = *(array + i) * *(array + i); // Squares the values
    }

    // Loops back through the array and prints out the new values
    for (int i = 0; i < size; i++) {
        printf("%d ", *(array + i));
    }
    return 0;
}
