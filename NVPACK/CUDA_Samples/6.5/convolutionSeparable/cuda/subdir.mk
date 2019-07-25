
OBJS += \
convolutionSeparable.o

%.o: %.cu
	$(NVCC) $(CFLAGS) $(EXTRA_CFLAGS) -c -o "$@" "$<"
