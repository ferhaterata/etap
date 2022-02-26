#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "rsa.h"

int main(int argc, char** argv) {
  struct public_key_class pub[0];
  struct private_key_class priv[0];
  rsa_gen_keys(pub, priv, PRIME_SOURCE_FILE);
  // Private Key:
  // Modulus: 5466615599
  // Exponent: 3935004593
  // Public Key:
  // Modulus: 5466615599
  // Exponent: 257

  printf("Private Key:\n Modulus: %lld\n Exponent: %lld\n",
         (long long)priv->modulus, (long long)priv->exponent);
  printf("Public Key:\n Modulus: %lld\n Exponent: %lld\n",
         (long long)pub->modulus, (long long)pub->exponent);

  char message[] = "123abc";
  int i;

  printf("Original:\n");
  for (i = 0; i < strlen(message); i++) {
    printf("%lld\n", (long long)message[i]);
  }

  long long* encrypted = rsa_encrypt(message, sizeof(message), pub);
  if (!encrypted) {
    fprintf(stderr, "Error in encryption!\n");
    return 1;
  }
  printf("Encrypted:\n");
  for (i = 0; i < strlen(message); i++) {
    printf("%lld\n", (long long)encrypted[i]);
  }

  char* decrypted = rsa_decrypt(encrypted, 8 * sizeof(message), priv);
  if (!decrypted) {
    fprintf(stderr, "Error in decryption!\n");
    return 1;
  }
  printf("Decrypted:\n");
  for (i = 0; i < strlen(message); i++) {
    printf("%lld\n", (long long)decrypted[i]);
  }

  printf("\n");
  free(encrypted);
  free(decrypted);
  return 0;
}
