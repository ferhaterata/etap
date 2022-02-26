#include <malloc.h>

int get_sign() {
  int *p, c;
  p = malloc(sizeof(int));
  *p = 5;
  c = *p + 7;
  free(p);
  return c;
}

int main() { return get_sign(); }
