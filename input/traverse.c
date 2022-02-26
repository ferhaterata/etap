// C program to traverse the array

#include <stdio.h>

// Function to traverse and print the array
void __attribute__((always_inline)) printArray(int* arr, int n) {
  for (int i = 0; i < n; i++) {
    printf("%d ", arr[i]);
  }
  printf("\n");
}

// Driver program
int main() {
  int arr[] = {2, -1, 5, 6, 0, -3};
  int n = sizeof(arr) / sizeof(arr[0]);
  printArray(arr, n);
  return 0;
}