#include <stdio.h>

#define N 256

__global__ void vadd(float* a, float* b, float* c) {
	int idx = threadIdx.x;
	if (idx < N) {
		c[idx] = a[idx] + b[idx];
	}
	return;
}

int main(int argc, char** argv) {
	float *ha, *hb, *hc, *da, *db, *dc;
	cudaHostAlloc((void **)&ha, N * sizeof(float), cudaHostAllocMapped);
	cudaHostAlloc((void **)&hb, N * sizeof(float), cudaHostAllocMapped);
	cudaHostAlloc((void **)&hc, N * sizeof(float), cudaHostAllocMapped);
	for (int i = 0; i < N; i ++) {
		ha[i] = 1.0;
		hb[i] = 2.0;
		hc[i] = 0.0;
	}
	cudaHostGetDevicePointer((void **)&da, (void *)ha, 0);
	cudaHostGetDevicePointer((void **)&db, (void *)hb, 0);
	cudaHostGetDevicePointer((void **)&dc, (void *)hc, 0);
	vadd<<<1, N>>>(da, db, dc);
	cudaDeviceSynchronize();
	for (int i = 0; i < N; i ++) {
		printf("%lf ", hc[i]);
	}
	printf("\n");
	return 0;
}
