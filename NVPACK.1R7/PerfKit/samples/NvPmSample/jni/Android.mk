LOCAL_PATH := $(call my-dir)

# Pack libNvPmApi.Core.so into the APK, so that we needn't
# have to push it into /system/lib or /vendor/lib
include $(CLEAR_VARS)
LOCAL_MODULE    := NvPmApiLib

$(info Building for target arch ABI: $(TARGET_ARCH_ABI))

ifneq ($(findstring armeabi-v7a,$(TARGET_ARCH_ABI)),)
LOCAL_SRC_FILES := ..\..\..\lib\a32\libNvPmApi.Core.so
include $(PREBUILT_SHARED_LIBRARY)
endif

ifneq ($(findstring arm64-v8a,$(TARGET_ARCH_ABI)),)
LOCAL_SRC_FILES := ..\..\..\lib\a64\libNvPmApi.Core.so
include $(PREBUILT_SHARED_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := NvPmSample
LOCAL_SRC_FILES := NvPmSample.cpp WinSysEGL.cpp
LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lGLESv3
LOCAL_STATIC_LIBRARIES := android_native_app_glue
# Add include path to the NvPmApi headers
LOCAL_C_INCLUDES += ..\..\include
include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)

