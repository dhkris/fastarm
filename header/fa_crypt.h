#ifndef FA_CRYPT_H
#define FA_CRYPT_H

void fa_rc4_prepare(char* output);;
unsigned char* fa_rc4_init(unsigned char* key, unsigned keylen, unsigned char* prepared);
unsigned char* fa_rc4_encrypt(unsigned char* bytes, unsigned int length, unsigned char* schedule, unsigned char* output);

#endif