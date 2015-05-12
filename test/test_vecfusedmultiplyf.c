#include<stdio.h>
#include <fa_simplef.h>

main() {
	float* a = (float[]){1.0f, 3.5f, 8.1f, 1458.f, 0.001f};
	float* b = (float[]){0.2f, 2.0f, 10.0f, 0.005f, 1000.001f};
	float* dest = (float[]){31.295f, 21.9f, -0.09475f, 3.334f, 199.301f};

	int i = 0;
	fa_vecfmaf(a, b, dest, 5);
	for(i = 0; i < 5; i++) {
		printf("%f %f %f\n", i, a[i], b[i], dest[i]);	
	}	
	fa_vecfmsf(b, a, dest, 5);
	for(i = 0; i < 5; i++) {
		printf("%f %f %f\n", i, a[i], b[i], dest[i]);	
	}		
}
