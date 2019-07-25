# Makefile generated by XPJ for ANDROID
-include Makefile.custom
ProjectName = PxToolkit
PxToolkit_cppfiles   += ./../../PxToolkit/src/PxTkBmpLoader.cpp
PxToolkit_cppfiles   += ./../../PxToolkit/src/PxTkFPS.cpp
PxToolkit_cppfiles   += ./../../PxToolkit/src/PxTkMatrixUtils.cpp
PxToolkit_cppfiles   += ./../../PxToolkit/src/PxTkRandom.cpp
PxToolkit_cppfiles   += ./../../PxToolkit/src/PxTkStream.cpp

PxToolkit_cpp_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.debug.P, $(PxToolkit_cppfiles)))))
PxToolkit_c_debug_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.debug.P, $(PxToolkit_cfiles)))))
PxToolkit_cc_debug_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(PxToolkit_ccfiles)))))
PxToolkit_debug_dep      = $(PxToolkit_cpp_debug_dep) $(PxToolkit_cc_debug_dep) $(PxToolkit_c_debug_dep)
-include $(PxToolkit_debug_dep)
PxToolkit_cpp_checked_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.checked.P, $(PxToolkit_cppfiles)))))
PxToolkit_c_checked_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.checked.P, $(PxToolkit_cfiles)))))
PxToolkit_cc_checked_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.checked.P, $(PxToolkit_ccfiles)))))
PxToolkit_checked_dep      = $(PxToolkit_cpp_checked_dep) $(PxToolkit_cc_checked_dep) $(PxToolkit_c_checked_dep)
-include $(PxToolkit_checked_dep)
PxToolkit_cpp_profile_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.profile.P, $(PxToolkit_cppfiles)))))
PxToolkit_c_profile_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.profile.P, $(PxToolkit_cfiles)))))
PxToolkit_cc_profile_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.profile.P, $(PxToolkit_ccfiles)))))
PxToolkit_profile_dep      = $(PxToolkit_cpp_profile_dep) $(PxToolkit_cc_profile_dep) $(PxToolkit_c_profile_dep)
-include $(PxToolkit_profile_dep)
PxToolkit_cpp_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.release.P, $(PxToolkit_cppfiles)))))
PxToolkit_c_release_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.release.P, $(PxToolkit_cfiles)))))
PxToolkit_cc_release_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(PxToolkit_ccfiles)))))
PxToolkit_release_dep      = $(PxToolkit_cpp_release_dep) $(PxToolkit_cc_release_dep) $(PxToolkit_c_release_dep)
-include $(PxToolkit_release_dep)
PxToolkit_debug_hpaths    := 
PxToolkit_debug_hpaths    += ./../../../Include/foundation
PxToolkit_debug_hpaths    += ./../../../Source/foundation/include
PxToolkit_debug_hpaths    += ./../../../Include/physxprofilesdk
PxToolkit_debug_hpaths    += ./../../../Include/physxvisualdebuggersdk
PxToolkit_debug_hpaths    += ./../../PxToolkit/include
PxToolkit_debug_hpaths    += ./../../../Include/common
PxToolkit_debug_hpaths    += ./../../../Include/geometry
PxToolkit_debug_hpaths    += ./../../../Include/pvd
PxToolkit_debug_hpaths    += ./../../../Include/particles
PxToolkit_debug_hpaths    += ./../../../Include/cooking
PxToolkit_debug_hpaths    += ./../../../Include/extensions
PxToolkit_debug_hpaths    += ./../../../Include/characterdynamic
PxToolkit_debug_hpaths    += ./../../../Include/vehicle
PxToolkit_debug_hpaths    += ./../../../Include/RepX
PxToolkit_debug_hpaths    += ./../../../Include
PxToolkit_debug_hpaths    += ./../../../Source/GeomUtils/headers
PxToolkit_debug_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
PxToolkit_debug_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
PxToolkit_debug_lpaths    := 
PxToolkit_debug_defines   := $(PxToolkit_custom_defines)
PxToolkit_debug_defines   += ANDROID
PxToolkit_debug_defines   += GLES2
PxToolkit_debug_defines   += __ARM_ARCH_5__
PxToolkit_debug_defines   += __ARM_ARCH_5T__
PxToolkit_debug_defines   += __ARM_ARCH_5E__
PxToolkit_debug_defines   += __ARM_ARCH_5TE__
PxToolkit_debug_defines   += PX_PHYSX_STATIC_LIB
PxToolkit_debug_defines   += _DEBUG
PxToolkit_debug_defines   += PX_DEBUG
PxToolkit_debug_defines   += PX_CHECKED
PxToolkit_debug_defines   += PX_SUPPORT_VISUAL_DEBUGGER
PxToolkit_debug_defines   += PX_NVTX
PxToolkit_debug_libraries := 
PxToolkit_debug_common_cflags	:= $(PxToolkit_custom_cflags)
PxToolkit_debug_common_cflags    += -MMD
PxToolkit_debug_common_cflags    += $(addprefix -D, $(PxToolkit_debug_defines))
PxToolkit_debug_common_cflags    += $(addprefix -I, $(PxToolkit_debug_hpaths))
PxToolkit_debug_cflags	:= $(PxToolkit_debug_common_cflags)
PxToolkit_debug_cflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_debug_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_debug_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_debug_cflags  += -g3 -gdwarf-2
PxToolkit_debug_cppflags	:= $(PxToolkit_debug_common_cflags)
PxToolkit_debug_cppflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_debug_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_debug_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_debug_cppflags  += -g3 -gdwarf-2
PxToolkit_debug_lflags    := $(PxToolkit_custom_lflags)
PxToolkit_debug_lflags    += $(addprefix -L, $(PxToolkit_debug_lpaths))
PxToolkit_debug_lflags    += -Wl,--start-group $(addprefix -l, $(PxToolkit_debug_libraries)) -Wl,--end-group
PxToolkit_debug_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_debug_objsdir  = $(OBJS_DIR)/PxToolkit_debug
PxToolkit_debug_cpp_o    = $(addprefix $(PxToolkit_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(PxToolkit_cppfiles)))))
PxToolkit_debug_c_o      = $(addprefix $(PxToolkit_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(PxToolkit_cfiles)))))
PxToolkit_debug_cc_o      = $(addprefix $(PxToolkit_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(PxToolkit_ccfiles)))))
PxToolkit_debug_obj      = $(PxToolkit_debug_cpp_o) $(PxToolkit_debug_cc_o) $(PxToolkit_debug_c_o)
PxToolkit_debug_bin      := ./../../PxToolkit/lib/android9_neon/libPxToolkitDEBUG.a

clean_PxToolkit_debug: 
	@$(ECHO) clean PxToolkit debug
	@$(RMDIR) $(PxToolkit_debug_objsdir)
	@$(RMDIR) $(PxToolkit_debug_bin)

build_PxToolkit_debug: postbuild_PxToolkit_debug
postbuild_PxToolkit_debug: mainbuild_PxToolkit_debug
mainbuild_PxToolkit_debug: prebuild_PxToolkit_debug $(PxToolkit_debug_bin)
prebuild_PxToolkit_debug:

$(PxToolkit_debug_bin): $(PxToolkit_debug_obj) 
	@mkdir -p `dirname ./../../PxToolkit/lib/android9_neon/libPxToolkitDEBUG.a`
	@$(AR) rcs $(PxToolkit_debug_bin) $(PxToolkit_debug_obj)
	@$(ECHO) building $@ complete!

PxToolkit_debug_DEPDIR = $(dir $(@))/$(*F)
$(PxToolkit_debug_cpp_o): $(PxToolkit_debug_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cppfiles))))))
	@cp $(PxToolkit_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cppfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cppfiles))))).debug.P; \
	  rm -f $(PxToolkit_debug_DEPDIR).d

$(PxToolkit_debug_c_o): $(PxToolkit_debug_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(PxToolkit_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cfiles))))))
	@cp $(PxToolkit_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_cfiles))))).debug.P; \
	  rm -f $(PxToolkit_debug_DEPDIR).d

$(PxToolkit_debug_cc_o): $(PxToolkit_debug_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_ccfiles)))
	@cp $(PxToolkit_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_debug_objsdir),, $@))), $(PxToolkit_ccfiles))))).debug.P; \
	  rm -f $(PxToolkit_debug_DEPDIR).d

PxToolkit_checked_hpaths    := 
PxToolkit_checked_hpaths    += ./../../../Include/foundation
PxToolkit_checked_hpaths    += ./../../../Source/foundation/include
PxToolkit_checked_hpaths    += ./../../../Include/physxprofilesdk
PxToolkit_checked_hpaths    += ./../../../Include/physxvisualdebuggersdk
PxToolkit_checked_hpaths    += ./../../PxToolkit/include
PxToolkit_checked_hpaths    += ./../../../Include/common
PxToolkit_checked_hpaths    += ./../../../Include/geometry
PxToolkit_checked_hpaths    += ./../../../Include/pvd
PxToolkit_checked_hpaths    += ./../../../Include/particles
PxToolkit_checked_hpaths    += ./../../../Include/cooking
PxToolkit_checked_hpaths    += ./../../../Include/extensions
PxToolkit_checked_hpaths    += ./../../../Include/characterdynamic
PxToolkit_checked_hpaths    += ./../../../Include/vehicle
PxToolkit_checked_hpaths    += ./../../../Include/RepX
PxToolkit_checked_hpaths    += ./../../../Include
PxToolkit_checked_hpaths    += ./../../../Source/GeomUtils/headers
PxToolkit_checked_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
PxToolkit_checked_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
PxToolkit_checked_lpaths    := 
PxToolkit_checked_defines   := $(PxToolkit_custom_defines)
PxToolkit_checked_defines   += ANDROID
PxToolkit_checked_defines   += GLES2
PxToolkit_checked_defines   += __ARM_ARCH_5__
PxToolkit_checked_defines   += __ARM_ARCH_5T__
PxToolkit_checked_defines   += __ARM_ARCH_5E__
PxToolkit_checked_defines   += __ARM_ARCH_5TE__
PxToolkit_checked_defines   += PX_PHYSX_STATIC_LIB
PxToolkit_checked_defines   += NDEBUG
PxToolkit_checked_defines   += PX_CHECKED
PxToolkit_checked_defines   += PX_SUPPORT_VISUAL_DEBUGGER
PxToolkit_checked_defines   += PX_NVTX
PxToolkit_checked_libraries := 
PxToolkit_checked_common_cflags	:= $(PxToolkit_custom_cflags)
PxToolkit_checked_common_cflags    += -MMD
PxToolkit_checked_common_cflags    += $(addprefix -D, $(PxToolkit_checked_defines))
PxToolkit_checked_common_cflags    += $(addprefix -I, $(PxToolkit_checked_hpaths))
PxToolkit_checked_cflags	:= $(PxToolkit_checked_common_cflags)
PxToolkit_checked_cflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_checked_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_checked_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_checked_cflags  += -g3 -gdwarf-2 -O3 -fno-strict-aliasing
PxToolkit_checked_cflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_checked_cflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
PxToolkit_checked_cppflags	:= $(PxToolkit_checked_common_cflags)
PxToolkit_checked_cppflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_checked_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_checked_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_checked_cppflags  += -g3 -gdwarf-2 -O3 -fno-strict-aliasing
PxToolkit_checked_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_checked_cppflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
PxToolkit_checked_lflags    := $(PxToolkit_custom_lflags)
PxToolkit_checked_lflags    += $(addprefix -L, $(PxToolkit_checked_lpaths))
PxToolkit_checked_lflags    += -Wl,--start-group $(addprefix -l, $(PxToolkit_checked_libraries)) -Wl,--end-group
PxToolkit_checked_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_checked_objsdir  = $(OBJS_DIR)/PxToolkit_checked
PxToolkit_checked_cpp_o    = $(addprefix $(PxToolkit_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(PxToolkit_cppfiles)))))
PxToolkit_checked_c_o      = $(addprefix $(PxToolkit_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(PxToolkit_cfiles)))))
PxToolkit_checked_cc_o      = $(addprefix $(PxToolkit_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(PxToolkit_ccfiles)))))
PxToolkit_checked_obj      = $(PxToolkit_checked_cpp_o) $(PxToolkit_checked_cc_o) $(PxToolkit_checked_c_o)
PxToolkit_checked_bin      := ./../../PxToolkit/lib/android9_neon/libPxToolkitCHECKED.a

clean_PxToolkit_checked: 
	@$(ECHO) clean PxToolkit checked
	@$(RMDIR) $(PxToolkit_checked_objsdir)
	@$(RMDIR) $(PxToolkit_checked_bin)

build_PxToolkit_checked: postbuild_PxToolkit_checked
postbuild_PxToolkit_checked: mainbuild_PxToolkit_checked
mainbuild_PxToolkit_checked: prebuild_PxToolkit_checked $(PxToolkit_checked_bin)
prebuild_PxToolkit_checked:

$(PxToolkit_checked_bin): $(PxToolkit_checked_obj) 
	@mkdir -p `dirname ./../../PxToolkit/lib/android9_neon/libPxToolkitCHECKED.a`
	@$(AR) rcs $(PxToolkit_checked_bin) $(PxToolkit_checked_obj)
	@$(ECHO) building $@ complete!

PxToolkit_checked_DEPDIR = $(dir $(@))/$(*F)
$(PxToolkit_checked_cpp_o): $(PxToolkit_checked_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling checked $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_checked_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cppfiles))))))
	@cp $(PxToolkit_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cppfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cppfiles))))).checked.P; \
	  rm -f $(PxToolkit_checked_DEPDIR).d

$(PxToolkit_checked_c_o): $(PxToolkit_checked_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling checked $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(PxToolkit_checked_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cfiles))))))
	@cp $(PxToolkit_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_cfiles))))).checked.P; \
	  rm -f $(PxToolkit_checked_DEPDIR).d

$(PxToolkit_checked_cc_o): $(PxToolkit_checked_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_checked_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_ccfiles)))
	@cp $(PxToolkit_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_ccfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_checked_objsdir),, $@))), $(PxToolkit_ccfiles))))).checked.P; \
	  rm -f $(PxToolkit_checked_DEPDIR).d

PxToolkit_profile_hpaths    := 
PxToolkit_profile_hpaths    += ./../../../Include/foundation
PxToolkit_profile_hpaths    += ./../../../Source/foundation/include
PxToolkit_profile_hpaths    += ./../../../Include/physxprofilesdk
PxToolkit_profile_hpaths    += ./../../../Include/physxvisualdebuggersdk
PxToolkit_profile_hpaths    += ./../../PxToolkit/include
PxToolkit_profile_hpaths    += ./../../../Include/common
PxToolkit_profile_hpaths    += ./../../../Include/geometry
PxToolkit_profile_hpaths    += ./../../../Include/pvd
PxToolkit_profile_hpaths    += ./../../../Include/particles
PxToolkit_profile_hpaths    += ./../../../Include/cooking
PxToolkit_profile_hpaths    += ./../../../Include/extensions
PxToolkit_profile_hpaths    += ./../../../Include/characterdynamic
PxToolkit_profile_hpaths    += ./../../../Include/vehicle
PxToolkit_profile_hpaths    += ./../../../Include/RepX
PxToolkit_profile_hpaths    += ./../../../Include
PxToolkit_profile_hpaths    += ./../../../Source/GeomUtils/headers
PxToolkit_profile_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
PxToolkit_profile_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
PxToolkit_profile_lpaths    := 
PxToolkit_profile_defines   := $(PxToolkit_custom_defines)
PxToolkit_profile_defines   += ANDROID
PxToolkit_profile_defines   += GLES2
PxToolkit_profile_defines   += __ARM_ARCH_5__
PxToolkit_profile_defines   += __ARM_ARCH_5T__
PxToolkit_profile_defines   += __ARM_ARCH_5E__
PxToolkit_profile_defines   += __ARM_ARCH_5TE__
PxToolkit_profile_defines   += PX_PHYSX_STATIC_LIB
PxToolkit_profile_defines   += NDEBUG
PxToolkit_profile_defines   += PX_PROFILE
PxToolkit_profile_defines   += PX_SUPPORT_VISUAL_DEBUGGER
PxToolkit_profile_defines   += PX_NVTX
PxToolkit_profile_libraries := 
PxToolkit_profile_common_cflags	:= $(PxToolkit_custom_cflags)
PxToolkit_profile_common_cflags    += -MMD
PxToolkit_profile_common_cflags    += $(addprefix -D, $(PxToolkit_profile_defines))
PxToolkit_profile_common_cflags    += $(addprefix -I, $(PxToolkit_profile_hpaths))
PxToolkit_profile_cflags	:= $(PxToolkit_profile_common_cflags)
PxToolkit_profile_cflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_profile_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_profile_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_profile_cflags  += -O3 -fno-strict-aliasing
PxToolkit_profile_cflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_profile_cflags  += -fno-omit-frame-pointer -marm -funswitch-loops -finline-limit=300
PxToolkit_profile_cppflags	:= $(PxToolkit_profile_common_cflags)
PxToolkit_profile_cppflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_profile_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_profile_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_profile_cppflags  += -O3 -fno-strict-aliasing
PxToolkit_profile_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_profile_cppflags  += -fno-omit-frame-pointer -marm -funswitch-loops -finline-limit=300
PxToolkit_profile_lflags    := $(PxToolkit_custom_lflags)
PxToolkit_profile_lflags    += $(addprefix -L, $(PxToolkit_profile_lpaths))
PxToolkit_profile_lflags    += -Wl,--start-group $(addprefix -l, $(PxToolkit_profile_libraries)) -Wl,--end-group
PxToolkit_profile_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_profile_objsdir  = $(OBJS_DIR)/PxToolkit_profile
PxToolkit_profile_cpp_o    = $(addprefix $(PxToolkit_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(PxToolkit_cppfiles)))))
PxToolkit_profile_c_o      = $(addprefix $(PxToolkit_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(PxToolkit_cfiles)))))
PxToolkit_profile_cc_o      = $(addprefix $(PxToolkit_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(PxToolkit_ccfiles)))))
PxToolkit_profile_obj      = $(PxToolkit_profile_cpp_o) $(PxToolkit_profile_cc_o) $(PxToolkit_profile_c_o)
PxToolkit_profile_bin      := ./../../PxToolkit/lib/android9_neon/libPxToolkitPROFILE.a

clean_PxToolkit_profile: 
	@$(ECHO) clean PxToolkit profile
	@$(RMDIR) $(PxToolkit_profile_objsdir)
	@$(RMDIR) $(PxToolkit_profile_bin)

build_PxToolkit_profile: postbuild_PxToolkit_profile
postbuild_PxToolkit_profile: mainbuild_PxToolkit_profile
mainbuild_PxToolkit_profile: prebuild_PxToolkit_profile $(PxToolkit_profile_bin)
prebuild_PxToolkit_profile:

$(PxToolkit_profile_bin): $(PxToolkit_profile_obj) 
	@mkdir -p `dirname ./../../PxToolkit/lib/android9_neon/libPxToolkitPROFILE.a`
	@$(AR) rcs $(PxToolkit_profile_bin) $(PxToolkit_profile_obj)
	@$(ECHO) building $@ complete!

PxToolkit_profile_DEPDIR = $(dir $(@))/$(*F)
$(PxToolkit_profile_cpp_o): $(PxToolkit_profile_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling profile $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_profile_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cppfiles))))))
	@cp $(PxToolkit_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cppfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cppfiles))))).profile.P; \
	  rm -f $(PxToolkit_profile_DEPDIR).d

$(PxToolkit_profile_c_o): $(PxToolkit_profile_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling profile $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(PxToolkit_profile_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cfiles))))))
	@cp $(PxToolkit_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_cfiles))))).profile.P; \
	  rm -f $(PxToolkit_profile_DEPDIR).d

$(PxToolkit_profile_cc_o): $(PxToolkit_profile_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_profile_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_ccfiles)))
	@cp $(PxToolkit_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_ccfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_profile_objsdir),, $@))), $(PxToolkit_ccfiles))))).profile.P; \
	  rm -f $(PxToolkit_profile_DEPDIR).d

PxToolkit_release_hpaths    := 
PxToolkit_release_hpaths    += ./../../../Include/foundation
PxToolkit_release_hpaths    += ./../../../Source/foundation/include
PxToolkit_release_hpaths    += ./../../../Include/physxprofilesdk
PxToolkit_release_hpaths    += ./../../../Include/physxvisualdebuggersdk
PxToolkit_release_hpaths    += ./../../PxToolkit/include
PxToolkit_release_hpaths    += ./../../../Include/common
PxToolkit_release_hpaths    += ./../../../Include/geometry
PxToolkit_release_hpaths    += ./../../../Include/pvd
PxToolkit_release_hpaths    += ./../../../Include/particles
PxToolkit_release_hpaths    += ./../../../Include/cooking
PxToolkit_release_hpaths    += ./../../../Include/extensions
PxToolkit_release_hpaths    += ./../../../Include/characterdynamic
PxToolkit_release_hpaths    += ./../../../Include/vehicle
PxToolkit_release_hpaths    += ./../../../Include/RepX
PxToolkit_release_hpaths    += ./../../../Include
PxToolkit_release_hpaths    += ./../../../Source/GeomUtils/headers
PxToolkit_release_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
PxToolkit_release_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
PxToolkit_release_lpaths    := 
PxToolkit_release_defines   := $(PxToolkit_custom_defines)
PxToolkit_release_defines   += ANDROID
PxToolkit_release_defines   += GLES2
PxToolkit_release_defines   += __ARM_ARCH_5__
PxToolkit_release_defines   += __ARM_ARCH_5T__
PxToolkit_release_defines   += __ARM_ARCH_5E__
PxToolkit_release_defines   += __ARM_ARCH_5TE__
PxToolkit_release_defines   += PX_PHYSX_STATIC_LIB
PxToolkit_release_defines   += NDEBUG
PxToolkit_release_libraries := 
PxToolkit_release_common_cflags	:= $(PxToolkit_custom_cflags)
PxToolkit_release_common_cflags    += -MMD
PxToolkit_release_common_cflags    += $(addprefix -D, $(PxToolkit_release_defines))
PxToolkit_release_common_cflags    += $(addprefix -I, $(PxToolkit_release_hpaths))
PxToolkit_release_cflags	:= $(PxToolkit_release_common_cflags)
PxToolkit_release_cflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_release_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_release_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_release_cflags  += -O3 -fno-strict-aliasing
PxToolkit_release_cflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_release_cflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
PxToolkit_release_cppflags	:= $(PxToolkit_release_common_cflags)
PxToolkit_release_cppflags  += -fpic -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
PxToolkit_release_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
PxToolkit_release_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_release_cppflags  += -O3 -fno-strict-aliasing
PxToolkit_release_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
PxToolkit_release_cppflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
PxToolkit_release_lflags    := $(PxToolkit_custom_lflags)
PxToolkit_release_lflags    += $(addprefix -L, $(PxToolkit_release_lpaths))
PxToolkit_release_lflags    += -Wl,--start-group $(addprefix -l, $(PxToolkit_release_libraries)) -Wl,--end-group
PxToolkit_release_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
PxToolkit_release_objsdir  = $(OBJS_DIR)/PxToolkit_release
PxToolkit_release_cpp_o    = $(addprefix $(PxToolkit_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(PxToolkit_cppfiles)))))
PxToolkit_release_c_o      = $(addprefix $(PxToolkit_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(PxToolkit_cfiles)))))
PxToolkit_release_cc_o      = $(addprefix $(PxToolkit_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(PxToolkit_ccfiles)))))
PxToolkit_release_obj      = $(PxToolkit_release_cpp_o) $(PxToolkit_release_cc_o) $(PxToolkit_release_c_o)
PxToolkit_release_bin      := ./../../PxToolkit/lib/android9_neon/libPxToolkit.a

clean_PxToolkit_release: 
	@$(ECHO) clean PxToolkit release
	@$(RMDIR) $(PxToolkit_release_objsdir)
	@$(RMDIR) $(PxToolkit_release_bin)

build_PxToolkit_release: postbuild_PxToolkit_release
postbuild_PxToolkit_release: mainbuild_PxToolkit_release
mainbuild_PxToolkit_release: prebuild_PxToolkit_release $(PxToolkit_release_bin)
prebuild_PxToolkit_release:

$(PxToolkit_release_bin): $(PxToolkit_release_obj) 
	@mkdir -p `dirname ./../../PxToolkit/lib/android9_neon/libPxToolkit.a`
	@$(AR) rcs $(PxToolkit_release_bin) $(PxToolkit_release_obj)
	@$(ECHO) building $@ complete!

PxToolkit_release_DEPDIR = $(dir $(@))/$(*F)
$(PxToolkit_release_cpp_o): $(PxToolkit_release_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cppfiles))))))
	@cp $(PxToolkit_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cppfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cppfiles))))).release.P; \
	  rm -f $(PxToolkit_release_DEPDIR).d

$(PxToolkit_release_c_o): $(PxToolkit_release_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(PxToolkit_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cfiles))))))
	@cp $(PxToolkit_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_cfiles))))).release.P; \
	  rm -f $(PxToolkit_release_DEPDIR).d

$(PxToolkit_release_cc_o): $(PxToolkit_release_objsdir)/%.o:
	@$(ECHO) PxToolkit: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(PxToolkit_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_ccfiles)))
	@cp $(PxToolkit_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(PxToolkit_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(PxToolkit_release_objsdir),, $@))), $(PxToolkit_ccfiles))))).release.P; \
	  rm -f $(PxToolkit_release_DEPDIR).d

clean_PxToolkit:  clean_PxToolkit_debug clean_PxToolkit_checked clean_PxToolkit_profile clean_PxToolkit_release
	@rm -rf $(DEPSDIR)
