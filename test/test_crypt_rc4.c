#include <stdio.h>
#include <string.h>
#include <fa_crypt.h>

char* testData = "Test input to RC4 algorithm";
char* testKey = "My test key";

main() {

	unsigned char* statePointer = (unsigned char*)malloc(256);
	fa_rc4_prepare(statePointer);
	fa_rc4_init(testKey, strlen(testKey), statePointer);
	
	char* test = (char*)malloc(65536);
	FILE* input = fopen("/dev/urandom", "rb");
	fread(test, 1, 65536, input);
	
	unsigned char* ciphertext = (unsigned char*)malloc(65536);
	int j;
	for(j=0; j < 65536; j++) {
		fa_rc4_encrypt(test, 65536, statePointer, ciphertext);
	}

}
