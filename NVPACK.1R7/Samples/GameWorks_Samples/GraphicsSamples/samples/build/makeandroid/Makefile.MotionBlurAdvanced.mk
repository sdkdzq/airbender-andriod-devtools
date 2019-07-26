# Makefile generated by XPJ for android
-include Makefile.custom
ProjectName = MotionBlurAdvanced
MotionBlurAdvanced_cppfiles   += ./../../es3aep-kepler/MotionBlurAdvanced/MotionBlurAdvanced.cpp

MotionBlurAdvanced_cpp_debug_dep    = $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(MotionBlurAdvanced_cppfiles)))))
MotionBlurAdvanced_cc_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(MotionBlurAdvanced_ccfiles)))))
MotionBlurAdvanced_c_debug_dep      = $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(MotionBlurAdvanced_cfiles)))))
MotionBlurAdvanced_debug_dep      = $(MotionBlurAdvanced_cpp_debug_dep) $(MotionBlurAdvanced_cc_debug_dep) $(MotionBlurAdvanced_c_debug_dep)
-include $(MotionBlurAdvanced_debug_dep)
MotionBlurAdvanced_cpp_release_dep    = $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(MotionBlurAdvanced_cppfiles)))))
MotionBlurAdvanced_cc_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(MotionBlurAdvanced_ccfiles)))))
MotionBlurAdvanced_c_release_dep      = $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(MotionBlurAdvanced_cfiles)))))
MotionBlurAdvanced_release_dep      = $(MotionBlurAdvanced_cpp_release_dep) $(MotionBlurAdvanced_cc_release_dep) $(MotionBlurAdvanced_c_release_dep)
-include $(MotionBlurAdvanced_release_dep)
MotionBlurAdvanced_debug_hpaths    := 
MotionBlurAdvanced_debug_hpaths    += ./../../es3aep-kepler/MotionBlurAdvanced
MotionBlurAdvanced_debug_hpaths    += ./../../../extensions/include
MotionBlurAdvanced_debug_hpaths    += ./../../../extensions/externals/include
MotionBlurAdvanced_debug_hpaths    += ./../../../extensions/include/NsFoundation
MotionBlurAdvanced_debug_hpaths    += ./../../../extensions/include/NvFoundation
MotionBlurAdvanced_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/platforms/android-19/arch-arm/usr/include
MotionBlurAdvanced_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include
MotionBlurAdvanced_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a/include
MotionBlurAdvanced_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include/backward
MotionBlurAdvanced_debug_lpaths    := 
MotionBlurAdvanced_debug_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
MotionBlurAdvanced_debug_lpaths    += ./../../../extensions/lib/Tegra-Android
MotionBlurAdvanced_debug_lpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a
MotionBlurAdvanced_debug_lpaths    += ./../../../extensions/lib/Tegra-Android
MotionBlurAdvanced_debug_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
MotionBlurAdvanced_debug_defines   := $(MotionBlurAdvanced_custom_defines)
MotionBlurAdvanced_debug_defines   += android
MotionBlurAdvanced_debug_defines   += ANDROID
MotionBlurAdvanced_debug_defines   += _LIB
MotionBlurAdvanced_debug_defines   += NV_ANDROID
MotionBlurAdvanced_debug_defines   += __STDC_LIMIT_MACROS
MotionBlurAdvanced_debug_defines   += VK_NO_PROTOTYPES
MotionBlurAdvanced_debug_defines   += GW_APP_NAME=\"MotionBlurAdvanced\"
MotionBlurAdvanced_debug_defines   += GL_API_LEVEL_ES3_1_AEP
MotionBlurAdvanced_debug_defines   += _DEBUG
MotionBlurAdvanced_debug_libraries := 
MotionBlurAdvanced_debug_libraries += NsFoundationD
MotionBlurAdvanced_debug_libraries += NvAppBaseD
MotionBlurAdvanced_debug_libraries += NvAssetLoaderD
MotionBlurAdvanced_debug_libraries += NvModelD
MotionBlurAdvanced_debug_libraries += NvGLUtilsD
MotionBlurAdvanced_debug_libraries += NvGamepadD
MotionBlurAdvanced_debug_libraries += NvImageD
MotionBlurAdvanced_debug_libraries += NvUID
MotionBlurAdvanced_debug_libraries += HalfD
MotionBlurAdvanced_debug_libraries += NvEGLUtilD
MotionBlurAdvanced_debug_libraries += gnustl_static
MotionBlurAdvanced_debug_libraries += EGL
MotionBlurAdvanced_debug_libraries += android
MotionBlurAdvanced_debug_libraries += m
MotionBlurAdvanced_debug_libraries += c
MotionBlurAdvanced_debug_libraries += supc++
MotionBlurAdvanced_debug_libraries += log
MotionBlurAdvanced_debug_libraries += gcc
MotionBlurAdvanced_debug_libraries += GLESv3
MotionBlurAdvanced_debug_common_cflags	:= $(MotionBlurAdvanced_custom_cflags)
MotionBlurAdvanced_debug_common_cflags    += -MMD
MotionBlurAdvanced_debug_common_cflags    += $(addprefix -D, $(MotionBlurAdvanced_debug_defines))
MotionBlurAdvanced_debug_common_cflags    += $(addprefix -I, $(MotionBlurAdvanced_debug_hpaths))
MotionBlurAdvanced_debug_common_cflags  += -fpic -fPIC -ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fstrict-aliasing -funswitch-loops -finline-limit=300
MotionBlurAdvanced_debug_common_cflags  += -funwind-tables -O0 -g -ggdb -fno-omit-frame-pointer -Wno-attributes
MotionBlurAdvanced_debug_cflags	:= $(MotionBlurAdvanced_debug_common_cflags)
MotionBlurAdvanced_debug_cppflags	:= $(MotionBlurAdvanced_debug_common_cflags)
MotionBlurAdvanced_debug_cppflags  += -std="gnu++11"
MotionBlurAdvanced_debug_lflags    := $(MotionBlurAdvanced_custom_lflags)
MotionBlurAdvanced_debug_lflags    += $(addprefix -L, $(MotionBlurAdvanced_debug_lpaths))
MotionBlurAdvanced_debug_lflags    += -Wl,--start-group $(addprefix -l, $(MotionBlurAdvanced_debug_libraries)) -Wl,--end-group
MotionBlurAdvanced_debug_lflags  += --sysroot=$(NDKROOT)/platforms/android-19/arch-arm -shared -Wl,--no-undefined
MotionBlurAdvanced_debug_objsdir  = $(OBJS_DIR)/MotionBlurAdvanced_debug
MotionBlurAdvanced_debug_cpp_o    = $(addprefix $(MotionBlurAdvanced_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(MotionBlurAdvanced_cppfiles)))))
MotionBlurAdvanced_debug_cc_o    = $(addprefix $(MotionBlurAdvanced_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(MotionBlurAdvanced_ccfiles)))))
MotionBlurAdvanced_debug_c_o      = $(addprefix $(MotionBlurAdvanced_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(MotionBlurAdvanced_cfiles)))))
MotionBlurAdvanced_debug_obj      =  $(MotionBlurAdvanced_debug_cpp_o) $(MotionBlurAdvanced_debug_cc_o) $(MotionBlurAdvanced_debug_c_o) 
MotionBlurAdvanced_debug_bin      := ./../../es3aep-kepler/MotionBlurAdvanced/libs/armeabi-v7a/libMotionBlurAdvanced.so

clean_MotionBlurAdvanced_debug: 
	@$(ECHO) clean MotionBlurAdvanced debug
	@$(RMDIR) $(MotionBlurAdvanced_debug_objsdir)
	@$(RMDIR) $(MotionBlurAdvanced_debug_bin)
	@$(RMDIR) $(DEPSDIR)/MotionBlurAdvanced/debug

build_MotionBlurAdvanced_debug: postbuild_MotionBlurAdvanced_debug
postbuild_MotionBlurAdvanced_debug: mainbuild_MotionBlurAdvanced_debug preantbuild_MotionBlurAdvanced_debug antbuild_MotionBlurAdvanced_debug
preantbuild_MotionBlurAdvanced_debug: mainbuild_MotionBlurAdvanced_debug
antbuild_MotionBlurAdvanced_debug: preantbuild_MotionBlurAdvanced_debug
	dos2unix $(ANT_TOOL); JAVA_HOME=$(JAVA_HOME) $(ANT_TOOL) -f ./../../es3aep-kepler/MotionBlurAdvanced/build.xml debug
mainbuild_MotionBlurAdvanced_debug: prebuild_MotionBlurAdvanced_debug $(MotionBlurAdvanced_debug_bin)
prebuild_MotionBlurAdvanced_debug:

$(MotionBlurAdvanced_debug_bin): $(MotionBlurAdvanced_debug_obj) build_NsFoundation_debug build_NvAppBase_debug build_NvAssetLoader_debug build_NvModel_debug build_NvGLUtils_debug build_NvGamepad_debug build_NvImage_debug build_NvUI_debug build_Half_debug build_NvEGLUtil_debug 
	mkdir -p `dirname ./../../es3aep-kepler/MotionBlurAdvanced/libs/armeabi-v7a/libMotionBlurAdvanced.so`
	$(CXX) -shared $(filter %.o, $(MotionBlurAdvanced_debug_obj)) $(MotionBlurAdvanced_debug_lflags) -lc -o $@ 
	$(ECHO) building $@ complete!

MotionBlurAdvanced_debug_DEPDIR = $(dir $(@))/$(*F)
$(MotionBlurAdvanced_debug_cpp_o): $(MotionBlurAdvanced_debug_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(MotionBlurAdvanced_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))))
	cp $(MotionBlurAdvanced_debug_DEPDIR).d $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))).P; \
	  rm -f $(MotionBlurAdvanced_debug_DEPDIR).d

$(MotionBlurAdvanced_debug_cc_o): $(MotionBlurAdvanced_debug_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling debug $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(MotionBlurAdvanced_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))))
	cp $(MotionBlurAdvanced_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))).debug.P; \
	  rm -f $(MotionBlurAdvanced_debug_DEPDIR).d

$(MotionBlurAdvanced_debug_c_o): $(MotionBlurAdvanced_debug_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(MotionBlurAdvanced_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))))
	cp $(MotionBlurAdvanced_debug_DEPDIR).d $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/MotionBlurAdvanced/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_debug_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))).P; \
	  rm -f $(MotionBlurAdvanced_debug_DEPDIR).d

MotionBlurAdvanced_release_hpaths    := 
MotionBlurAdvanced_release_hpaths    += ./../../es3aep-kepler/MotionBlurAdvanced
MotionBlurAdvanced_release_hpaths    += ./../../../extensions/include
MotionBlurAdvanced_release_hpaths    += ./../../../extensions/externals/include
MotionBlurAdvanced_release_hpaths    += ./../../../extensions/include/NsFoundation
MotionBlurAdvanced_release_hpaths    += ./../../../extensions/include/NvFoundation
MotionBlurAdvanced_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/platforms/android-19/arch-arm/usr/include
MotionBlurAdvanced_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include
MotionBlurAdvanced_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a/include
MotionBlurAdvanced_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include/backward
MotionBlurAdvanced_release_lpaths    := 
MotionBlurAdvanced_release_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
MotionBlurAdvanced_release_lpaths    += ./../../../extensions/lib/Tegra-Android
MotionBlurAdvanced_release_lpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a
MotionBlurAdvanced_release_lpaths    += ./../../../extensions/lib/Tegra-Android
MotionBlurAdvanced_release_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
MotionBlurAdvanced_release_defines   := $(MotionBlurAdvanced_custom_defines)
MotionBlurAdvanced_release_defines   += android
MotionBlurAdvanced_release_defines   += ANDROID
MotionBlurAdvanced_release_defines   += _LIB
MotionBlurAdvanced_release_defines   += NV_ANDROID
MotionBlurAdvanced_release_defines   += __STDC_LIMIT_MACROS
MotionBlurAdvanced_release_defines   += VK_NO_PROTOTYPES
MotionBlurAdvanced_release_defines   += GW_APP_NAME=\"MotionBlurAdvanced\"
MotionBlurAdvanced_release_defines   += GL_API_LEVEL_ES3_1_AEP
MotionBlurAdvanced_release_defines   += NDEBUG
MotionBlurAdvanced_release_libraries := 
MotionBlurAdvanced_release_libraries += NsFoundation
MotionBlurAdvanced_release_libraries += NvAppBase
MotionBlurAdvanced_release_libraries += NvAssetLoader
MotionBlurAdvanced_release_libraries += NvModel
MotionBlurAdvanced_release_libraries += NvGLUtils
MotionBlurAdvanced_release_libraries += NvGamepad
MotionBlurAdvanced_release_libraries += NvImage
MotionBlurAdvanced_release_libraries += NvUI
MotionBlurAdvanced_release_libraries += Half
MotionBlurAdvanced_release_libraries += NvEGLUtil
MotionBlurAdvanced_release_libraries += gnustl_static
MotionBlurAdvanced_release_libraries += EGL
MotionBlurAdvanced_release_libraries += android
MotionBlurAdvanced_release_libraries += m
MotionBlurAdvanced_release_libraries += c
MotionBlurAdvanced_release_libraries += supc++
MotionBlurAdvanced_release_libraries += log
MotionBlurAdvanced_release_libraries += gcc
MotionBlurAdvanced_release_libraries += GLESv3
MotionBlurAdvanced_release_common_cflags	:= $(MotionBlurAdvanced_custom_cflags)
MotionBlurAdvanced_release_common_cflags    += -MMD
MotionBlurAdvanced_release_common_cflags    += $(addprefix -D, $(MotionBlurAdvanced_release_defines))
MotionBlurAdvanced_release_common_cflags    += $(addprefix -I, $(MotionBlurAdvanced_release_hpaths))
MotionBlurAdvanced_release_common_cflags  += -fpic -fPIC -ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fstrict-aliasing -funswitch-loops -finline-limit=300
MotionBlurAdvanced_release_common_cflags  += -funwind-tables -O2 -fno-omit-frame-pointer -Wno-attributes
MotionBlurAdvanced_release_cflags	:= $(MotionBlurAdvanced_release_common_cflags)
MotionBlurAdvanced_release_cppflags	:= $(MotionBlurAdvanced_release_common_cflags)
MotionBlurAdvanced_release_cppflags  += -std="gnu++11"
MotionBlurAdvanced_release_lflags    := $(MotionBlurAdvanced_custom_lflags)
MotionBlurAdvanced_release_lflags    += $(addprefix -L, $(MotionBlurAdvanced_release_lpaths))
MotionBlurAdvanced_release_lflags    += -Wl,--start-group $(addprefix -l, $(MotionBlurAdvanced_release_libraries)) -Wl,--end-group
MotionBlurAdvanced_release_lflags  += --sysroot=$(NDKROOT)/platforms/android-19/arch-arm -shared -Wl,--no-undefined
MotionBlurAdvanced_release_objsdir  = $(OBJS_DIR)/MotionBlurAdvanced_release
MotionBlurAdvanced_release_cpp_o    = $(addprefix $(MotionBlurAdvanced_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(MotionBlurAdvanced_cppfiles)))))
MotionBlurAdvanced_release_cc_o    = $(addprefix $(MotionBlurAdvanced_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(MotionBlurAdvanced_ccfiles)))))
MotionBlurAdvanced_release_c_o      = $(addprefix $(MotionBlurAdvanced_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(MotionBlurAdvanced_cfiles)))))
MotionBlurAdvanced_release_obj      =  $(MotionBlurAdvanced_release_cpp_o) $(MotionBlurAdvanced_release_cc_o) $(MotionBlurAdvanced_release_c_o) 
MotionBlurAdvanced_release_bin      := ./../../es3aep-kepler/MotionBlurAdvanced/libs/armeabi-v7a/libMotionBlurAdvanced.so

clean_MotionBlurAdvanced_release: 
	@$(ECHO) clean MotionBlurAdvanced release
	@$(RMDIR) $(MotionBlurAdvanced_release_objsdir)
	@$(RMDIR) $(MotionBlurAdvanced_release_bin)
	@$(RMDIR) $(DEPSDIR)/MotionBlurAdvanced/release

build_MotionBlurAdvanced_release: postbuild_MotionBlurAdvanced_release
postbuild_MotionBlurAdvanced_release: mainbuild_MotionBlurAdvanced_release preantbuild_MotionBlurAdvanced_release antbuild_MotionBlurAdvanced_release
preantbuild_MotionBlurAdvanced_release: mainbuild_MotionBlurAdvanced_release
antbuild_MotionBlurAdvanced_release: preantbuild_MotionBlurAdvanced_release
	dos2unix $(ANT_TOOL); JAVA_HOME=$(JAVA_HOME) $(ANT_TOOL) -f ./../../es3aep-kepler/MotionBlurAdvanced/build.xml debug
mainbuild_MotionBlurAdvanced_release: prebuild_MotionBlurAdvanced_release $(MotionBlurAdvanced_release_bin)
prebuild_MotionBlurAdvanced_release:

$(MotionBlurAdvanced_release_bin): $(MotionBlurAdvanced_release_obj) build_NsFoundation_release build_NvAppBase_release build_NvAssetLoader_release build_NvModel_release build_NvGLUtils_release build_NvGamepad_release build_NvImage_release build_NvUI_release build_Half_release build_NvEGLUtil_release 
	mkdir -p `dirname ./../../es3aep-kepler/MotionBlurAdvanced/libs/armeabi-v7a/libMotionBlurAdvanced.so`
	$(CXX) -shared $(filter %.o, $(MotionBlurAdvanced_release_obj)) $(MotionBlurAdvanced_release_lflags) -lc -o $@ 
	$(ECHO) building $@ complete!

MotionBlurAdvanced_release_DEPDIR = $(dir $(@))/$(*F)
$(MotionBlurAdvanced_release_cpp_o): $(MotionBlurAdvanced_release_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(MotionBlurAdvanced_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))))
	cp $(MotionBlurAdvanced_release_DEPDIR).d $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cppfiles))))).P; \
	  rm -f $(MotionBlurAdvanced_release_DEPDIR).d

$(MotionBlurAdvanced_release_cc_o): $(MotionBlurAdvanced_release_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling release $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(MotionBlurAdvanced_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))))
	cp $(MotionBlurAdvanced_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_ccfiles))))).release.P; \
	  rm -f $(MotionBlurAdvanced_release_DEPDIR).d

$(MotionBlurAdvanced_release_c_o): $(MotionBlurAdvanced_release_objsdir)/%.o:
	$(ECHO) MotionBlurAdvanced: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(MotionBlurAdvanced_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))))
	cp $(MotionBlurAdvanced_release_DEPDIR).d $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(MotionBlurAdvanced_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/MotionBlurAdvanced/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(MotionBlurAdvanced_release_objsdir),, $@))), $(MotionBlurAdvanced_cfiles))))).P; \
	  rm -f $(MotionBlurAdvanced_release_DEPDIR).d

clean_MotionBlurAdvanced:  clean_MotionBlurAdvanced_debug clean_MotionBlurAdvanced_release
	rm -rf $(DEPSDIR)

export VERBOSE
ifndef VERBOSE
.SILENT:
endif
