# Makefile generated by XPJ for android
-include Makefile.custom
ProjectName = InstancedTessellation
InstancedTessellation_cppfiles   += ./../../es2-aurora/InstancedTessellation/InstancedTessellation.cpp

InstancedTessellation_cpp_debug_dep    = $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(InstancedTessellation_cppfiles)))))
InstancedTessellation_cc_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(InstancedTessellation_ccfiles)))))
InstancedTessellation_c_debug_dep      = $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(InstancedTessellation_cfiles)))))
InstancedTessellation_debug_dep      = $(InstancedTessellation_cpp_debug_dep) $(InstancedTessellation_cc_debug_dep) $(InstancedTessellation_c_debug_dep)
-include $(InstancedTessellation_debug_dep)
InstancedTessellation_cpp_release_dep    = $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(InstancedTessellation_cppfiles)))))
InstancedTessellation_cc_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(InstancedTessellation_ccfiles)))))
InstancedTessellation_c_release_dep      = $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(InstancedTessellation_cfiles)))))
InstancedTessellation_release_dep      = $(InstancedTessellation_cpp_release_dep) $(InstancedTessellation_cc_release_dep) $(InstancedTessellation_c_release_dep)
-include $(InstancedTessellation_release_dep)
InstancedTessellation_debug_hpaths    := 
InstancedTessellation_debug_hpaths    += ./../../es2-aurora/InstancedTessellation
InstancedTessellation_debug_hpaths    += ./../../../extensions/include
InstancedTessellation_debug_hpaths    += ./../../../extensions/externals/include
InstancedTessellation_debug_hpaths    += ./../../../extensions/include/NsFoundation
InstancedTessellation_debug_hpaths    += ./../../../extensions/include/NvFoundation
InstancedTessellation_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/platforms/android-19/arch-arm/usr/include
InstancedTessellation_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include
InstancedTessellation_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a/include
InstancedTessellation_debug_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include/backward
InstancedTessellation_debug_lpaths    := 
InstancedTessellation_debug_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
InstancedTessellation_debug_lpaths    += ./../../../extensions/lib/Tegra-Android
InstancedTessellation_debug_lpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a
InstancedTessellation_debug_lpaths    += ./../../../extensions/lib/Tegra-Android
InstancedTessellation_debug_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
InstancedTessellation_debug_defines   := $(InstancedTessellation_custom_defines)
InstancedTessellation_debug_defines   += android
InstancedTessellation_debug_defines   += ANDROID
InstancedTessellation_debug_defines   += _LIB
InstancedTessellation_debug_defines   += NV_ANDROID
InstancedTessellation_debug_defines   += __STDC_LIMIT_MACROS
InstancedTessellation_debug_defines   += VK_NO_PROTOTYPES
InstancedTessellation_debug_defines   += GW_APP_NAME=\"InstancedTessellation\"
InstancedTessellation_debug_defines   += GL_API_LEVEL_ES2
InstancedTessellation_debug_defines   += _DEBUG
InstancedTessellation_debug_libraries := 
InstancedTessellation_debug_libraries += NsFoundationD
InstancedTessellation_debug_libraries += NvAppBaseD
InstancedTessellation_debug_libraries += NvAssetLoaderD
InstancedTessellation_debug_libraries += NvModelD
InstancedTessellation_debug_libraries += NvGLUtilsD
InstancedTessellation_debug_libraries += NvGamepadD
InstancedTessellation_debug_libraries += NvImageD
InstancedTessellation_debug_libraries += NvUID
InstancedTessellation_debug_libraries += HalfD
InstancedTessellation_debug_libraries += NvEGLUtilD
InstancedTessellation_debug_libraries += gnustl_static
InstancedTessellation_debug_libraries += EGL
InstancedTessellation_debug_libraries += android
InstancedTessellation_debug_libraries += m
InstancedTessellation_debug_libraries += c
InstancedTessellation_debug_libraries += supc++
InstancedTessellation_debug_libraries += log
InstancedTessellation_debug_libraries += gcc
InstancedTessellation_debug_libraries += GLESv2
InstancedTessellation_debug_common_cflags	:= $(InstancedTessellation_custom_cflags)
InstancedTessellation_debug_common_cflags    += -MMD
InstancedTessellation_debug_common_cflags    += $(addprefix -D, $(InstancedTessellation_debug_defines))
InstancedTessellation_debug_common_cflags    += $(addprefix -I, $(InstancedTessellation_debug_hpaths))
InstancedTessellation_debug_common_cflags  += -fpic -fPIC -ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fstrict-aliasing -funswitch-loops -finline-limit=300
InstancedTessellation_debug_common_cflags  += -funwind-tables -O0 -g -ggdb -fno-omit-frame-pointer -Wno-attributes
InstancedTessellation_debug_cflags	:= $(InstancedTessellation_debug_common_cflags)
InstancedTessellation_debug_cppflags	:= $(InstancedTessellation_debug_common_cflags)
InstancedTessellation_debug_cppflags  += -std="gnu++11"
InstancedTessellation_debug_lflags    := $(InstancedTessellation_custom_lflags)
InstancedTessellation_debug_lflags    += $(addprefix -L, $(InstancedTessellation_debug_lpaths))
InstancedTessellation_debug_lflags    += -Wl,--start-group $(addprefix -l, $(InstancedTessellation_debug_libraries)) -Wl,--end-group
InstancedTessellation_debug_lflags  += --sysroot=$(NDKROOT)/platforms/android-19/arch-arm -shared -Wl,--no-undefined
InstancedTessellation_debug_objsdir  = $(OBJS_DIR)/InstancedTessellation_debug
InstancedTessellation_debug_cpp_o    = $(addprefix $(InstancedTessellation_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(InstancedTessellation_cppfiles)))))
InstancedTessellation_debug_cc_o    = $(addprefix $(InstancedTessellation_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(InstancedTessellation_ccfiles)))))
InstancedTessellation_debug_c_o      = $(addprefix $(InstancedTessellation_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(InstancedTessellation_cfiles)))))
InstancedTessellation_debug_obj      =  $(InstancedTessellation_debug_cpp_o) $(InstancedTessellation_debug_cc_o) $(InstancedTessellation_debug_c_o) 
InstancedTessellation_debug_bin      := ./../../es2-aurora/InstancedTessellation/libs/armeabi-v7a/libInstancedTessellation.so

clean_InstancedTessellation_debug: 
	@$(ECHO) clean InstancedTessellation debug
	@$(RMDIR) $(InstancedTessellation_debug_objsdir)
	@$(RMDIR) $(InstancedTessellation_debug_bin)
	@$(RMDIR) $(DEPSDIR)/InstancedTessellation/debug

build_InstancedTessellation_debug: postbuild_InstancedTessellation_debug
postbuild_InstancedTessellation_debug: mainbuild_InstancedTessellation_debug preantbuild_InstancedTessellation_debug antbuild_InstancedTessellation_debug
preantbuild_InstancedTessellation_debug: mainbuild_InstancedTessellation_debug
antbuild_InstancedTessellation_debug: preantbuild_InstancedTessellation_debug
	dos2unix $(ANT_TOOL); JAVA_HOME=$(JAVA_HOME) $(ANT_TOOL) -f ./../../es2-aurora/InstancedTessellation/build.xml debug
mainbuild_InstancedTessellation_debug: prebuild_InstancedTessellation_debug $(InstancedTessellation_debug_bin)
prebuild_InstancedTessellation_debug:

$(InstancedTessellation_debug_bin): $(InstancedTessellation_debug_obj) build_NsFoundation_debug build_NvAppBase_debug build_NvAssetLoader_debug build_NvModel_debug build_NvGLUtils_debug build_NvGamepad_debug build_NvImage_debug build_NvUI_debug build_Half_debug build_NvEGLUtil_debug 
	mkdir -p `dirname ./../../es2-aurora/InstancedTessellation/libs/armeabi-v7a/libInstancedTessellation.so`
	$(CXX) -shared $(filter %.o, $(InstancedTessellation_debug_obj)) $(InstancedTessellation_debug_lflags) -lc -o $@ 
	$(ECHO) building $@ complete!

InstancedTessellation_debug_DEPDIR = $(dir $(@))/$(*F)
$(InstancedTessellation_debug_cpp_o): $(InstancedTessellation_debug_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(InstancedTessellation_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cppfiles))))))
	cp $(InstancedTessellation_debug_DEPDIR).d $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cppfiles))))).P; \
	  rm -f $(InstancedTessellation_debug_DEPDIR).d

$(InstancedTessellation_debug_cc_o): $(InstancedTessellation_debug_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling debug $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(InstancedTessellation_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_ccfiles))))))
	cp $(InstancedTessellation_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_ccfiles))))).debug.P; \
	  rm -f $(InstancedTessellation_debug_DEPDIR).d

$(InstancedTessellation_debug_c_o): $(InstancedTessellation_debug_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(InstancedTessellation_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cfiles))))))
	cp $(InstancedTessellation_debug_DEPDIR).d $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/InstancedTessellation/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_debug_objsdir),, $@))), $(InstancedTessellation_cfiles))))).P; \
	  rm -f $(InstancedTessellation_debug_DEPDIR).d

InstancedTessellation_release_hpaths    := 
InstancedTessellation_release_hpaths    += ./../../es2-aurora/InstancedTessellation
InstancedTessellation_release_hpaths    += ./../../../extensions/include
InstancedTessellation_release_hpaths    += ./../../../extensions/externals/include
InstancedTessellation_release_hpaths    += ./../../../extensions/include/NsFoundation
InstancedTessellation_release_hpaths    += ./../../../extensions/include/NvFoundation
InstancedTessellation_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/platforms/android-19/arch-arm/usr/include
InstancedTessellation_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include
InstancedTessellation_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a/include
InstancedTessellation_release_hpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/include/backward
InstancedTessellation_release_lpaths    := 
InstancedTessellation_release_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
InstancedTessellation_release_lpaths    += ./../../../extensions/lib/Tegra-Android
InstancedTessellation_release_lpaths    += $(if $(NVPACK_ROOT),$(NVPACK_ROOT),$(error the environment must define NVPACK_ROOT))/$(if $(NVPACK_NDK_VERSION),$(NVPACK_NDK_VERSION),android-ndk-r15c)/sources/cxx-stl/gnu-libstdc++/$(if $(NVPACK_NDK_TOOL_VERSION),$(NVPACK_NDK_TOOL_VERSION),4.9)/libs/armeabi-v7a
InstancedTessellation_release_lpaths    += ./../../../extensions/lib/Tegra-Android
InstancedTessellation_release_lpaths    += ./../../../extensions/externals/lib/Tegra-Android
InstancedTessellation_release_defines   := $(InstancedTessellation_custom_defines)
InstancedTessellation_release_defines   += android
InstancedTessellation_release_defines   += ANDROID
InstancedTessellation_release_defines   += _LIB
InstancedTessellation_release_defines   += NV_ANDROID
InstancedTessellation_release_defines   += __STDC_LIMIT_MACROS
InstancedTessellation_release_defines   += VK_NO_PROTOTYPES
InstancedTessellation_release_defines   += GW_APP_NAME=\"InstancedTessellation\"
InstancedTessellation_release_defines   += GL_API_LEVEL_ES2
InstancedTessellation_release_defines   += NDEBUG
InstancedTessellation_release_libraries := 
InstancedTessellation_release_libraries += NsFoundation
InstancedTessellation_release_libraries += NvAppBase
InstancedTessellation_release_libraries += NvAssetLoader
InstancedTessellation_release_libraries += NvModel
InstancedTessellation_release_libraries += NvGLUtils
InstancedTessellation_release_libraries += NvGamepad
InstancedTessellation_release_libraries += NvImage
InstancedTessellation_release_libraries += NvUI
InstancedTessellation_release_libraries += Half
InstancedTessellation_release_libraries += NvEGLUtil
InstancedTessellation_release_libraries += gnustl_static
InstancedTessellation_release_libraries += EGL
InstancedTessellation_release_libraries += android
InstancedTessellation_release_libraries += m
InstancedTessellation_release_libraries += c
InstancedTessellation_release_libraries += supc++
InstancedTessellation_release_libraries += log
InstancedTessellation_release_libraries += gcc
InstancedTessellation_release_libraries += GLESv2
InstancedTessellation_release_common_cflags	:= $(InstancedTessellation_custom_cflags)
InstancedTessellation_release_common_cflags    += -MMD
InstancedTessellation_release_common_cflags    += $(addprefix -D, $(InstancedTessellation_release_defines))
InstancedTessellation_release_common_cflags    += $(addprefix -I, $(InstancedTessellation_release_hpaths))
InstancedTessellation_release_common_cflags  += -fpic -fPIC -ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fstrict-aliasing -funswitch-loops -finline-limit=300
InstancedTessellation_release_common_cflags  += -funwind-tables -O2 -fno-omit-frame-pointer -Wno-attributes
InstancedTessellation_release_cflags	:= $(InstancedTessellation_release_common_cflags)
InstancedTessellation_release_cppflags	:= $(InstancedTessellation_release_common_cflags)
InstancedTessellation_release_cppflags  += -std="gnu++11"
InstancedTessellation_release_lflags    := $(InstancedTessellation_custom_lflags)
InstancedTessellation_release_lflags    += $(addprefix -L, $(InstancedTessellation_release_lpaths))
InstancedTessellation_release_lflags    += -Wl,--start-group $(addprefix -l, $(InstancedTessellation_release_libraries)) -Wl,--end-group
InstancedTessellation_release_lflags  += --sysroot=$(NDKROOT)/platforms/android-19/arch-arm -shared -Wl,--no-undefined
InstancedTessellation_release_objsdir  = $(OBJS_DIR)/InstancedTessellation_release
InstancedTessellation_release_cpp_o    = $(addprefix $(InstancedTessellation_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(InstancedTessellation_cppfiles)))))
InstancedTessellation_release_cc_o    = $(addprefix $(InstancedTessellation_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(InstancedTessellation_ccfiles)))))
InstancedTessellation_release_c_o      = $(addprefix $(InstancedTessellation_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(InstancedTessellation_cfiles)))))
InstancedTessellation_release_obj      =  $(InstancedTessellation_release_cpp_o) $(InstancedTessellation_release_cc_o) $(InstancedTessellation_release_c_o) 
InstancedTessellation_release_bin      := ./../../es2-aurora/InstancedTessellation/libs/armeabi-v7a/libInstancedTessellation.so

clean_InstancedTessellation_release: 
	@$(ECHO) clean InstancedTessellation release
	@$(RMDIR) $(InstancedTessellation_release_objsdir)
	@$(RMDIR) $(InstancedTessellation_release_bin)
	@$(RMDIR) $(DEPSDIR)/InstancedTessellation/release

build_InstancedTessellation_release: postbuild_InstancedTessellation_release
postbuild_InstancedTessellation_release: mainbuild_InstancedTessellation_release preantbuild_InstancedTessellation_release antbuild_InstancedTessellation_release
preantbuild_InstancedTessellation_release: mainbuild_InstancedTessellation_release
antbuild_InstancedTessellation_release: preantbuild_InstancedTessellation_release
	dos2unix $(ANT_TOOL); JAVA_HOME=$(JAVA_HOME) $(ANT_TOOL) -f ./../../es2-aurora/InstancedTessellation/build.xml debug
mainbuild_InstancedTessellation_release: prebuild_InstancedTessellation_release $(InstancedTessellation_release_bin)
prebuild_InstancedTessellation_release:

$(InstancedTessellation_release_bin): $(InstancedTessellation_release_obj) build_NsFoundation_release build_NvAppBase_release build_NvAssetLoader_release build_NvModel_release build_NvGLUtils_release build_NvGamepad_release build_NvImage_release build_NvUI_release build_Half_release build_NvEGLUtil_release 
	mkdir -p `dirname ./../../es2-aurora/InstancedTessellation/libs/armeabi-v7a/libInstancedTessellation.so`
	$(CXX) -shared $(filter %.o, $(InstancedTessellation_release_obj)) $(InstancedTessellation_release_lflags) -lc -o $@ 
	$(ECHO) building $@ complete!

InstancedTessellation_release_DEPDIR = $(dir $(@))/$(*F)
$(InstancedTessellation_release_cpp_o): $(InstancedTessellation_release_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(InstancedTessellation_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cppfiles))))))
	cp $(InstancedTessellation_release_DEPDIR).d $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cppfiles))))).P; \
	  rm -f $(InstancedTessellation_release_DEPDIR).d

$(InstancedTessellation_release_cc_o): $(InstancedTessellation_release_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling release $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(InstancedTessellation_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_ccfiles))))))
	cp $(InstancedTessellation_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_ccfiles))))).release.P; \
	  rm -f $(InstancedTessellation_release_DEPDIR).d

$(InstancedTessellation_release_c_o): $(InstancedTessellation_release_objsdir)/%.o:
	$(ECHO) InstancedTessellation: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(InstancedTessellation_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cfiles))))))
	cp $(InstancedTessellation_release_DEPDIR).d $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(InstancedTessellation_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/InstancedTessellation/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(InstancedTessellation_release_objsdir),, $@))), $(InstancedTessellation_cfiles))))).P; \
	  rm -f $(InstancedTessellation_release_DEPDIR).d

clean_InstancedTessellation:  clean_InstancedTessellation_debug clean_InstancedTessellation_release
	rm -rf $(DEPSDIR)

export VERBOSE
ifndef VERBOSE
.SILENT:
endif
