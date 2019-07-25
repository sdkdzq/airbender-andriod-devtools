# Set up configuration based on target architecture
ifeq ($(TARGET_ARCH),armv7l)
    #HOST_COMPILER ?= $(NDK_ROOT)/toolchains/arm-linux-androideabi-4.6/gen_standalone/linux-x86_64/bin/arm-linux-androideabi-g++
    HOST_COMPILER ?= $(NDK_ROOT)/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/arm-linux-androideabi-g++
    TARGET_SIZE := 32
    SM_ARCH ?= 32
else ifeq ($(TARGET_ARCH),aarch64)
    #HOST_COMPILER ?= $(NDK_ROOT)/toolchains/aarch64-linux-android-4.9/gen_standalone/linux-x86_64/bin/aarch64-linux-android-g++
    HOST_COMPILER ?= $(NDK_ROOT)/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/aarch64-linux-android-g++
    TARGET_SIZE := 64
    SM_ARCH ?= 53
else
    $(error TARGET_ARCH must be set to either "armv7l" or "aarch64")
endif

SYSROOT := /home/ais01/codes/kezhao.zhao/NVPACK.1R7/android-ndk-r15c/my-toolchain/sysroot
STLINC := -I /home/ais01/codes/kezhao.zhao/NVPACK.1R7/android-ndk-r15c/sources/cxx-stl/gnu-libstdc++/4.9/include \
	 -I /home/ais01/codes/kezhao.zhao/NVPACK.1R7/android-ndk-r15c/sources/cxx-stl/gnu-libstdc++/4.9/libs/arm64-v8a/include
NVCC := $(CUDA_TOOLKIT_ROOT)/bin/nvcc -Xcompiler --sysroot=$(SYSROOT) -ccbin $(HOST_COMPILER) -m$(TARGET_SIZE) -arch=sm_$(SM_ARCH) $(STLINC)

################################################################################
# Target rules
all: build

build: lib_convolutionSeparable.a

convolutionSeparable.o: convolutionSeparable.cu
	$(NVCC) $(EXTRA_CFLAGS) -o "$@" -c "$<"

lib_convolutionSeparable.a: convolutionSeparable.o
	$(NVCC) -lib -o "$@" "$<"

clean:
	rm -rf *.a *.o
