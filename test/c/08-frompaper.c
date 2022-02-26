#include <stdio.h>

void profiled(int i) {
  printf("%d%d%d\n", i & 1, i & 2, i & 4);
  if (i & 1 || i & 2) {
    printf("How happy is the blameless vestal's lot!\n");
  }
  printf("The world forgetting, by the world forgot.\n");
  if (i & 4) {
    printf("Eternal sunshine of the spotless mind!\n");
  }
  printf("Each pray'r accepted, and each wish resign'd;\n\n");
}

int main(int argc, char** argv) {
  for (int i = 0; i < 100; ++i) {
    profiled(i);
  }
  return 0;
}
