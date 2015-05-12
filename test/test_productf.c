#include<stdio.h>
#include <fa_simplef.h>

float * myTest = (float[]) {1.0f, 2.0f, 3.0f};

main() {
	float res = fa_productf(myTest, 3);
	float max = fa_maximumf(myTest, 3);
	printf("Test product: %f\n", res);
	printf("Highest value: %f\n", max);
}
