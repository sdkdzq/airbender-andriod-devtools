LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := lib_convolutionSeparable
LOCAL_SRC_FILES := ../cuda/lib_convolutionSeparable.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libcudart_static
ifeq ($(TARGET_ARCH),arm)
  LOCAL_LIB_PATH   += $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib/
else ifeq ($(TARGET_ARCH),arm64)
  LOCAL_LIB_PATH   += $(CUDA_TOOLKIT_ROOT)/targets/aarch64-linux-androideabi/lib/
endif
LOCAL_SRC_FILES  := $(LOCAL_LIB_PATH)/libcudart_static.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := convolutionSeparable

NVPACK := $(NDK_ROOT)/..
CONVOLUTION_FILTER_ROOT := $(LOCAL_PATH)/..

MY_PREFIX       := $(LOCAL_PATH)/
MY_SOURCES      := $(wildcard $(LOCAL_PATH)/*.cpp)
LOCAL_SRC_FILES := $(MY_SOURCES:$(MY_PREFIX)%=%)
 
LOCAL_STATIC_LIBRARIES := lib_convolutionSeparable libcudart_static
LOCAL_STATIC_LIBRARIES += nv_and_util nv_egl_util nv_glesutil nv_shader nv_file
LOCAL_LDLIBS := -llog -landroid -lGLESv2 -lEGL 
LOCAL_C_INCLUDES += $(CONVOLUTION_FILTER_ROOT)/cuda
ifeq ($(TARGET_ARCH),arm)
  LOCAL_C_INCLUDES += $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include
else ifeq ($(TARGET_ARCH),arm64)
  LOCAL_C_INCLUDES += $(CUDA_TOOLKIT_ROOT)/targets/aarch64-linux-androideabi/include
endif

include $(BUILD_SHARED_LIBRARY)

$(call import-add-path, $(NVPACK)/Samples/TDK_Samples/libs/jni)

$(call import-module,nv_and_util)
$(call import-module,nv_egl_util)
$(call import-module,nv_shader)
$(call import-module,nv_file)
$(call import-module,nv_glesutil)
