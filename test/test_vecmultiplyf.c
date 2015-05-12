#include<stdio.h>
#include <fa_simplef.h>

main() {
	float* a = (float[]){1.0f, 3.5f, 8.1f, 1458.f, 0.001f};
	float* b = (float[]){0.2f, 2.0f, 10.0f, 0.005f, 1000.001f};
	float* dest = (float*)malloc(150);
	
	fa_vecmultiplyf(a, b, dest, 5);
	
	int i = 0;
	for(i = 0; i < 5; i++) {
		printf("%i: %f x %f = %f\n", i, a[i], b[i], dest[i]);	
	}
	
}
