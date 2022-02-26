#include <stdio.h>
#include <stdlib.h>

void profiled(int argc, int i) {
  if ((i + argc) % 3) {
    printf("Truey\n");
  } else {
    printf("Falsey\n");
  }
}

int main(int argc, char** argv) {
  for (int i = 0, e = atoi(argv[1]); i < e; ++i) {
    profiled(argc, i);
  }
  return 0;
}
