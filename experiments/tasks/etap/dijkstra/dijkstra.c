//#include <stdio.h>
// https://github.com/impedimentToProgress/MiBench2/blob/master/dijkstra/dijkstra.c
#include "checkpoint.h"
#define INFINITY 9999
#define MAX 10

#define INLINE __attribute__((always_inline)) inline

int AdjMatrix[10][10] = {
    {32, 32, 54, 12, 52, 56, 8, 30, 44, 94},
    {76, 54, 65, 14, 89, 69, 4, 16, 24, 47},
    {38, 31, 75, 40, 61, 21, 84, 51, 86, 41},
    {80, 16, 53, 14, 94, 29, 77, 99, 16, 29},
    {59, 7, 14, 78, 79, 45, 54, 83, 8, 94},
    {94, 41, 3, 61, 27, 19, 33, 35, 78, 38},
    {3, 55, 41, 76, 49, 68, 83, 23, 67, 15},
    {68, 28, 47, 12, 82, 6, 26, 96, 98, 75},
    {7, 1, 46, 39, 12, 68, 41, 28, 31, 0},
    {82, 97, 72, 61, 39, 48, 11, 99, 38, 49},
};

INLINE
int dijkstra(int G[MAX][MAX], int n, int startnode) {
  int cost[MAX][MAX], distance[MAX], pred[MAX];
  int visited[MAX], count, mindistance, nextnode, i, j;

  // pred[] stores the predecessor of each node
  // count gives the number of nodes seen so far
  // create the cost matrix
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      if (G[i][j] == 0)
        cost[i][j] = INFINITY;
      else
        cost[i][j] = G[i][j];
      checkpoint();
    }
  }

  // initialize pred[],distance[] and visited[]
  for (i = 0; i < n; i++) {
    distance[i] = cost[startnode][i];
    pred[i] = startnode;
    visited[i] = 0;
    checkpoint();
  }

  distance[startnode] = 0;
  visited[startnode] = 1;
  count = 1;

  checkpoint();
  while (count < n - 1) {
    mindistance = INFINITY;

    // nextnode gives the node at minimum distance
    for (i = 0; i < n; i++)
      if (distance[i] < mindistance && !visited[i]) {
        mindistance = distance[i];
        nextnode = i;
        checkpoint();
      }

    // check if a better path exists through nextnode
    visited[nextnode] = 1;
    for (i = 0; i < n; i++)
      if (!visited[i])
        if (mindistance + cost[nextnode][i] < distance[i]) {
          distance[i] = mindistance + cost[nextnode][i];
          pred[i] = nextnode;
        }
    count++;
  }

  return count;
}

int main_dijkstra() {
  int n = 5;
  int u = 3;
  int sum = 0;

  for (int i = 0; i < 10; ++i) {
    checkpoint();
    sum += dijkstra(AdjMatrix, n, u);
  }
  // printf("count: %d\n", sum);  // expected value: 40
  // main_dijkstra mean: 304260.7   std: 1.460787
  return sum;
}
