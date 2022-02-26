/* NIST Secure Hash Algorithm */

#include "input.h"
#include "sha.h"

int main() {
  SHA_INFO sha_info;

  sha_stream(&sha_info, InputString);
  sha_print(&sha_info);

  return (0);
}
