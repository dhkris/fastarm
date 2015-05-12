#include <bubblesort.h>
#include <stdio.h>

int* data = (int[]){50, 1, 95, 34, 109};

main() {
	printf("Data addr: %d\n", (int)data);
	fbubblesort((void*)data, 4, 5);
	int i = 0;
	for(i = 0; i < 5; i++) {
		printf("Sorted %d: %d\n", i+1, data[i]);
	}
}
