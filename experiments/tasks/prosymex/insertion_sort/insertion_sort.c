
#include <stdio.h>

/* Function to sort an array using insertion sort*/
__attribute__((always_inline)) inline void insertionSort(int arr[], int n) {
//#pragma distribution parameter "arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"
#pragma distribution parameter "arr <- galloc(\"[4 x i32]\", 5, 14, 18, 9)"
#pragma distribution parameter "n <- 4"
  int key, j;
  for (int i = 1; i < n; i++) {
    key = arr[i];
    j = i - 1;
    /* Move elements of arr[0..i-1], that are
    greater than key, to one position ahead
    of their current position */
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j = j - 1;
    }
    arr[j + 1] = key;
  }
}
// Function to print an array
__attribute__((always_inline)) inline void printArray(int arr[], int size) {
  for (int i = 0; i < size; i++) printf("%d ", arr[i]);
  printf("\n");
}
int main() {
  int arr1[] = {87,  13, 55, 43, 41, 71, 76, 69, 69, 85, 61, 80, 58, 77, 96,
                38,  8,  45, 98, 35, 77, 93, 7,  2,  55, 56, 73, 47, 8,  27,
                28,  12, 39, 4,  43, 40, 18, 90, 68, 17, 13, 99, 80, 23, 97,
                25,  85, 2,  22, 71, 56, 12, 1,  82, 77, 50, 5,  40, 88, 63,
                83,  33, 84, 2,  95, 63, 40, 37, 16, 51, 21, 18, 45, 14, 97,
                45,  5,  16, 57, 26, 37, 1,  59, 66, 46, 21, 93, 69, 52, 80,
                100, 84, 60, 31, 41, 4,  6,  79, 80, 2,  32, 21, 58, 85, 13,
                17,  25, 76, 91, 47, 74, 83, 81, 25, 27, 48, 91, 44, 10, 58,
                70,  30, 7,  98, 64, 84, 66, 86};
  int n = sizeof(arr1) / sizeof(arr1[0]);

  printf("Original array: \n");
  printArray(arr1, n);
  insertionSort(arr1, n);
  printf("\nInsertion Sorted array in Ascending order: \n");
  printArray(arr1, n);
  return arr1[n - 1];  // 0 9 12 14 23
}