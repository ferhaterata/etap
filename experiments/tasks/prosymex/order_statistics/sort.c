// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.                      sort.c
//    C program to sort the array in an
//    ascending order using selection sort
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2021 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <stdio.h>

__attribute__((always_inline)) inline void swap(int* xp, int* yp) {
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

/* Function to perform Selection Sort */
__attribute__((always_inline)) inline void selectionSort(int arr[], int n) {
//#pragma distribution parameter "arr <- env(`0`=5, `1`=14, `2`=18, `3`=9)"
#pragma distribution parameter "arr <- galloc(\"[4 x i32]\", 5, 14, 18, 9)"
#pragma distribution parameter "n <- 4"
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

__attribute__((always_inline)) inline int partition(int arr[], int l, int h) {
  int x = arr[h];
  int i = (l - 1);

  for (int j = l; j <= h - 1; j++) {
    if (arr[j] <= x) {
      i++;
      swap(&arr[i], &arr[j]);
    }
  }
  swap(&arr[i + 1], &arr[h]);
  return (i + 1);
}

__attribute__((always_inline)) inline void quickSort(int arr[], int l, int h) {
  // Create an auxiliary stack
  int stack[h - l + 1];
  // initialize top of stack
  int top = -1;
  // push initial values of l and h to stack
  stack[++top] = l;
  stack[++top] = h;
  // Keep popping from stack while is not empty
  while (top >= 0) {
    // Pop h and l
    h = stack[top--];
    l = stack[top--];
    // Set pivot element at its correct position in sorted array
    int p = partition(arr, l, h);
    // If there are elements on left side of pivot, then push left side to stack
    if (p - 1 > l) {
      stack[++top] = l;
      stack[++top] = p - 1;
    }
    // If there are elements on right side of pivot, then push right side to
    // stack
    if (p + 1 < h) {
      stack[++top] = p + 1;
      stack[++top] = h;
    }
  }
}

// Function to print an array
__attribute__((always_inline)) inline void printArray(int arr[], int size) {
  for (int i = 0; i < size; i++) printf("%d ", arr[i]);
  printf("\n");
}

// Driver code
int main() {
  int arr1[] = {87, 13, 55, 43, 41, 71, 76, 69, 69, 85, 61, 80, 58, 77, 96, 38,
                8,  45, 98, 35, 77, 93, 7,  2,  55, 56, 73, 47, 8,  27, 28, 12,
                39, 4,  43, 40, 18, 90, 68, 17, 13, 99, 80, 23, 97, 25, 85, 2,
                22, 71, 56, 12, 1,  82, 77, 50, 5,  40, 88, 63, 83, 33, 84, 2,
                95, 63, 40, 37, 16, 51, 21, 18, 45, 14, 97, 45, 5,  16, 57, 26,
                37, 1,  59, 66, 46, 21, 93, 69, 52, 80, 81, 84, 60, 31, 41, 4,
                6,  79, 80, 2,  32, 21, 58, 85, 13, 17, 25, 76, 91, 47, 74, 83,
                81, 25, 27, 48, 91, 44, 10, 58, 70, 30, 7,  98, 64, 84, 66, 86,
                87, 39, 5,  90, 15, 4,  60, 88, 26, 16, 33, 42, 85, 99, 93, 22,
                97, 20, 45, 59, 47, 77, 4,  11, 79, 58, 20, 34, 92, 27, 95, 97,
                74, 23, 9,  1,  40, 90, 83, 39, 58, 27, 20, 83, 57, 69, 40, 85,
                49, 89, 63, 64, 81, 89, 37, 74, 83, 81, 31, 21, 87, 6,  55, 65,
                77, 90, 75, 45, 26, 69, 42, 69, 77, 78, 18, 34, 18, 99, 81, 96,
                39, 50, 85, 36, 90, 6,  33, 46, 16, 92, 84, 41, 13, 56, 13, 14,
                55, 72, 30, 74, 45, 35, 63, 44, 17, 48, 76, 80, 85, 39, 94, 1,
                72, 97, 41, 59, 73, 79, 12, 90, 5,  6,  41, 4,  75, 64, 8,  16};

  int arr2[] = {
      60, 25, 53,  7,  18,  90, 54, 40, 35, 63, 9,  68, 31, 32, 79, 83, 45, 37,
      92, 53, 78,  77, 27,  90, 57, 96, 8,  14, 30, 44, 64, 61, 81, 31, 12, 73,
      46, 66, 77,  6,  54,  44, 11, 41, 80, 48, 77, 78, 31, 38, 65, 97, 98, 17,
      16, 8,  32,  82, 30,  40, 24, 93, 22, 53, 10, 65, 38, 46, 44, 3,  26, 42,
      22, 85, 97,  19, 19,  8,  65, 72, 70, 22, 36, 30, 82, 22, 53, 53, 25, 83,
      59, 58, 24,  92, 13,  67, 55, 53, 56, 3,  86, 48, 83, 95, 27, 67, 74, 16,
      38, 30, 97,  26, 16,  93, 18, 6,  70, 98, 48, 34, 41, 50, 5,  35, 77, 35,
      54, 21, 6,   80, 96,  64, 14, 77, 99, 94, 60, 68, 81, 40, 38, 54, 69, 73,
      72, 19, 23,  2,  49,  97, 75, 58, 94, 6,  87, 81, 9,  5,  86, 76, 25, 13,
      10, 28, 29,  64, 96,  6,  35, 64, 84, 96, 77, 38, 65, 48, 83, 11, 97, 18,
      94, 84, 2,   94, 46,  42, 86, 84, 89, 2,  70, 10, 75, 55, 30, 62, 50, 66,
      76, 31, 99,  56, 84,  51, 23, 99, 65, 85, 46, 7,  23, 51, 11, 14, 72, 81,
      56, 60, 100, 93, 100, 83, 78, 27, 31, 73, 50, 45, 30, 41, 69, 63, 52, 24,
      1,  8,  4,   76, 27,  51, 61, 17, 94, 47, 50, 62, 59, 63, 75, 41, 49, 59,
      64, 5,  18,  21};

  int arr3[] = {
      78, 99, 94, 81, 65, 61, 88, 3,  34, 37, 71, 24, 13, 16, 16, 90, 55,  52,
      84, 36, 59, 77, 44, 88, 15, 15, 70, 64, 21, 93, 30, 96, 65, 83, 40,  98,
      89, 29, 28, 64, 35, 20, 61, 18, 18, 83, 89, 34, 57, 4,  81, 33, 94,  96,
      20, 83, 52, 57, 36, 35, 87, 49, 79, 35, 49, 83, 16, 74, 63, 79, 73,  14,
      97, 13, 2,  29, 36, 20, 60, 61, 59, 45, 16, 36, 97, 35, 85, 98, 59,  23,
      76, 44, 80, 36, 13, 22, 65, 45, 47, 86, 43, 99, 77, 25, 4,  45, 32,  10,
      37, 29, 71, 28, 95, 4,  1,  8,  54, 43, 77, 94, 87, 65, 83, 98, 24,  99,
      27, 68, 17, 80, 98, 50, 30, 2,  35, 19, 89, 39, 84, 21, 43, 53, 97,  60,
      36, 27, 73, 80, 37, 98, 17, 43, 75, 27, 21, 52, 17, 38, 1,  93, 27,  84,
      41, 19, 89, 98, 27, 15, 3,  60, 43, 21, 7,  95, 33, 27, 52, 79, 18,  94,
      53, 17, 56, 2,  40, 97, 82, 14, 81, 37, 10, 21, 70, 69, 40, 48, 68,  9,
      60, 88, 62, 91, 70, 32, 21, 72, 29, 81, 17, 16, 43, 71, 98, 20, 100, 65,
      80, 56, 76, 87, 93, 64, 71, 48, 14, 60, 36, 68, 6,  82, 77, 23, 58,  68,
      9,  24, 13, 91, 51, 10, 16, 30, 18, 78, 45, 42, 93, 93, 13, 94, 14,  63,
      88, 30, 59, 17};

  int n = sizeof(arr1) / sizeof(arr1[0]);

  printf("Original array: \n");
  printArray(arr1, n);
  selectionSort(arr1, n);
  printf("\nInsertion Sorted array in Ascending order: \n");
  printArray(arr1, n);

  printArray(arr2, n);
  insertionSort(arr2, n);
  printf("\nSelection Sorted array in Ascending order: \n");
  printArray(arr2, n);

  printArray(arr3, n);
  quickSort(arr3, 0, n - 1);
  printf("\nQuick Sorted array in Ascending order: \n");
  printArray(arr3, n);

  // return the last element which should be the biggest one
  return arr1[n - 1];  // 0 9 12 14 23
}