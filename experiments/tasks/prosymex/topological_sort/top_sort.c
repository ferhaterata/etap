#include <stdio.h>

int main() {
  int a[4][4] = {{0, 1, 1, 0}, {0, 0, 0, 1}, {0, 0, 0, 1}, {0, 0, 0, 0}};
  int i, j, k, indeg[10], flag[10], count = 0;
  int n = 4;

  for (i = 0; i < n; i++) {
    indeg[i] = 0;
    flag[i] = 0;
  }

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++) indeg[i] = indeg[i] + a[j][i];

  printf("\nThe topological order is:\n");
  int result = 0;
  while (count < n) {
    for (k = 0; k < n; k++) {
      if ((indeg[k] == 0) && (flag[k] == 0)) {
        printf("%d\n", (k + 1));
        result = (k + 1);
        flag[k] = 1;
      }

      for (i = 0; i < n; i++) {
        if (a[i][k] == 1) indeg[k]--;
      }
    }

    count++;
  }
  printf("%d\n", result);
  return result;
}