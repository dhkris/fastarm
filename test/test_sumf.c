#include<stdio.h>
#include <fa_simplef.h>

static int TESTSIZE=655360;
int test() {
	int a = 2;
	return a + 2;
}

float * myTest = (float[]) {1.0f, 2.0f, 3.0f};

main() {
	float* testdata = (float*)malloc(TESTSIZE*4);
	int i = 0;
	for(i = 0; i < TESTSIZE; i++) {
		testdata[i] = ((float)rand())/333.0f;
	}
	float res = fa_sumf(testdata, TESTSIZE);
	res = fa_sumf(myTest, 3);
	printf("Test sum: %f\n", res);
}
