#include<stdio.h>
#include <fa_simplef.h>


main() {
	unsigned testVar = 400000000;
	unsigned test = fa_sqrt32(testVar);
	printf("Test sqrt(%d): %d\n", testVar, test);
}
