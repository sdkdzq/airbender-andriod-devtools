//#include <iostream>

__global__ void hello() {
	printf("hello world\n");
	return;
}

int main(int argc, char** argv) {
	hello<<<1, 1>>>();
	cudaDeviceSynchronize();
	return 0;
}
