
#include <stdio.h>

__attribute__((always_inline)) inline void swap(int* xp, int* yp) {
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

/* Function to perform Selection Sort */
__attribute__((always_inline)) inline void selectionSort(int arr[], int n) {
  // One by one move boundary of unsorted subarray
  for (int i = 0; i < n - 1; i++) {
    // Find the minimum element in unsorted array
    int min_idx = i;
    for (int j = i + 1; j < n; j++)
      if (arr[j] < arr[min_idx]) min_idx = j;
    // Swap the found minimum element with the first element
    swap(&arr[min_idx], &arr[i]);
  }
}

// Function to print an array
__attribute__((always_inline)) inline void printArray(int arr[], int size) {
  for (int i = 0; i < size; i++) printf("%d ", arr[i]);
  printf("\n");
}

int main() {
  int arr2[] = {
      78, 99, 94, 81, 65, 61, 88, 3,  34,  37, 71, 24, 13, 16, 16, 90, 55,  52,
      84, 36, 59, 77, 44, 88, 15, 15, 70,  64, 21, 93, 30, 96, 65, 83, 40,  98,
      89, 29, 28, 64, 35, 20, 61, 18, 18,  83, 89, 34, 57, 4,  81, 33, 94,  96,
      20, 83, 52, 57, 36, 35, 87, 49, 79,  35, 49, 83, 16, 74, 63, 79, 73,  14,
      97, 13, 2,  29, 36, 20, 60, 61, 59,  45, 16, 36, 97, 35, 85, 98, 59,  23,
      76, 44, 80, 36, 13, 22, 65, 45, 47,  86, 43, 99, 77, 25, 4,  45, 32,  10,
      37, 29, 71, 28, 95, 4,  1,  8,  54,  43, 77, 94, 87, 65, 83, 98, 24,  99,
      27, 68, 17, 80, 98, 50, 30, 2,  35,  19, 89, 39, 84, 21, 43, 53, 97,  60,
      36, 27, 73, 80, 37, 98, 17, 43, 75,  27, 21, 52, 17, 38, 1,  93, 27,  84,
      41, 19, 89, 98, 27, 15, 3,  60, 43,  21, 7,  95, 33, 27, 52, 79, 18,  94,
      53, 17, 56, 2,  40, 97, 82, 14, 81,  37, 10, 21, 70, 69, 40, 48, 68,  9,
      60, 88, 62, 91, 70, 32, 21, 72, 29,  81, 17, 16, 43, 71, 98, 20, 100, 65,
      80, 56, 76, 87, 93, 64, 71, 48, 14,  60, 36, 68, 6,  82, 77, 23, 58,  68,
      9,  24, 13, 91, 51, 10, 16, 30, 110, 78, 45, 42, 93, 93, 13, 94, 14,  63,
      88, 30, 59, 17};
  int n = sizeof(arr2) / sizeof(arr2[0]);

  printArray(arr2, n);
  selectionSort(arr2, n);
  printf("\nSelection Sorted array in Ascending order: \n");
  printArray(arr2, n);
  return arr2[n - 1];
  // Error: protect(): protection stack overflow
}
