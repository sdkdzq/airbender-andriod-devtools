
OBJS += \
bilateral_kernel.o

%.o: %.cu
	$(NVCC) $(CFLAGS) $(EXTRA_CFLAGS) -c -o "$@" "$<"
