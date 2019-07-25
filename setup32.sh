#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > envsetup.sh
echo "export NDK_ROOT=$(pwd)/NVPACK.1R7/android-ndk-r15c" >> envsetup.sh
echo "export NVPACK_ROOT=$(pwd)/NVPACK" >> envsetup.sh
echo "export ANDROID_ABI=armeabi" >> envsetup.sh
echo "export TOOLCHAIN=$(pwd)/toolchains" >> envsetup.sh
echo "export SYSROOT=\$TOOLCHAIN/sysroot" >> envsetup.sh
echo "export CC=\$TOOLCHAIN/bin/arm-linux-androideabi-gcc" >> envsetup.sh
echo "export CXX=\$TOOLCHAIN/bin/arm-linux-androideabi-g++" >> envsetup.sh
echo "export AR=\$TOOLCHAIN/bin/arm-linux-androideabi-ar" >> envsetup.sh
echo "export LD=\$TOOLCHAIN/bin/arm-linux-androideabi-ld" >> envsetup.sh

NDK_ROOT=$(pwd)/NVPACK.1R7/android-ndk-r15c
$NDK_ROOT/build/tools/make-standalone-toolchain.sh --stl=gnustl --install-dir=./toolchains --platform=android-21 --arch=arm --toolchain=arm-linux-androideabi-4.9
