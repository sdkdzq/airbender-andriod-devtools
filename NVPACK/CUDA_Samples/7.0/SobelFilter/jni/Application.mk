APP_STL := gnustl_static
NDK_TOOLCHAIN_VERSION := 4.9

ifeq ($(NV_TARGET_ARCH),armv7l)
  APP_ABI := armeabi-v7a
else ifeq ($(NV_TARGET_ARCH),aarch64)
  APP_ABI := arm64-v8a
endif
APP_PLATFORM := android-21
