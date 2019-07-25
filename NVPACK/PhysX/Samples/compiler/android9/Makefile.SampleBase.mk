# Makefile generated by XPJ for ANDROID
-include Makefile.custom
ProjectName = SampleBase
SampleBase_cppfiles   += ./../../SampleBase/ParticleEmitter.cpp
SampleBase_cppfiles   += ./../../SampleBase/ParticleEmitterPressure.cpp
SampleBase_cppfiles   += ./../../SampleBase/ParticleEmitterRate.cpp
SampleBase_cppfiles   += ./../../SampleBase/ParticleFactory.cpp
SampleBase_cppfiles   += ./../../SampleBase/ParticleSystem.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderBaseActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderBaseObject.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderBoxActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderCapsuleActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderGridActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderMaterial.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderMeshActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderParticleSystemActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderSphereActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderTexture.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderClothActor.cpp
SampleBase_cppfiles   += ./../../SampleBase/RaycastCCD.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleCamera.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleCameraController.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleConsole.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleMain.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleStepper.cpp
SampleBase_cppfiles   += ./../../SampleBase/TestGroup.cpp
SampleBase_cppfiles   += ./../../SampleBase/PhysXSample.cpp
SampleBase_cppfiles   += ./../../SampleBase/PhysXSampleApplication.cpp
SampleBase_cppfiles   += ./../../SampleBase/InputEventBuffer.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleInputMappingAsset.cpp
SampleBase_cppfiles   += ./../../SampleBase/Picking.cpp
SampleBase_cppfiles   += ./../../SampleBase/RawLoader.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleAllocator.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleMouseFilter.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleRandomPrecomputed.cpp
SampleBase_cppfiles   += ./../../SampleBase/RenderPhysX3Debug.cpp
SampleBase_cppfiles   += ./../../SampleBase/wavefront.cpp
SampleBase_cppfiles   += ./../../SampleBase/SampleCharacterHelpers.cpp
SampleBase_cppfiles   += ./../../SampleBase/AcclaimLoader.cpp
SampleBase_cppfiles   += ./../../SampleBase/TestMotionGenerator.cpp
SampleBase_cppfiles   += ./../../SampleBase/TestGeometryHelpers.cpp
SampleBase_cppfiles   += ./../../SampleBase/TestClothHelpers.cpp

SampleBase_cpp_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.debug.P, $(SampleBase_cppfiles)))))
SampleBase_c_debug_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.debug.P, $(SampleBase_cfiles)))))
SampleBase_cc_debug_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(SampleBase_ccfiles)))))
SampleBase_debug_dep      = $(SampleBase_cpp_debug_dep) $(SampleBase_cc_debug_dep) $(SampleBase_c_debug_dep)
-include $(SampleBase_debug_dep)
SampleBase_cpp_checked_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.checked.P, $(SampleBase_cppfiles)))))
SampleBase_c_checked_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.checked.P, $(SampleBase_cfiles)))))
SampleBase_cc_checked_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.checked.P, $(SampleBase_ccfiles)))))
SampleBase_checked_dep      = $(SampleBase_cpp_checked_dep) $(SampleBase_cc_checked_dep) $(SampleBase_c_checked_dep)
-include $(SampleBase_checked_dep)
SampleBase_cpp_profile_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.profile.P, $(SampleBase_cppfiles)))))
SampleBase_c_profile_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.profile.P, $(SampleBase_cfiles)))))
SampleBase_cc_profile_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.profile.P, $(SampleBase_ccfiles)))))
SampleBase_profile_dep      = $(SampleBase_cpp_profile_dep) $(SampleBase_cc_profile_dep) $(SampleBase_c_profile_dep)
-include $(SampleBase_profile_dep)
SampleBase_cpp_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.release.P, $(SampleBase_cppfiles)))))
SampleBase_c_release_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.release.P, $(SampleBase_cfiles)))))
SampleBase_cc_release_dep      = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(SampleBase_ccfiles)))))
SampleBase_release_dep      = $(SampleBase_cpp_release_dep) $(SampleBase_cc_release_dep) $(SampleBase_c_release_dep)
-include $(SampleBase_release_dep)
SampleBase_debug_hpaths    := 
SampleBase_debug_hpaths    += ./../../PxToolkit/include
SampleBase_debug_hpaths    += ./../../SampleFramework/framework/include
SampleBase_debug_hpaths    += ./../../SampleFramework/renderer/include
SampleBase_debug_hpaths    += ./../../SampleFramework/platform/include
SampleBase_debug_hpaths    += ./../../../Source/shared/general/shared
SampleBase_debug_hpaths    += ./../../../Include
SampleBase_debug_hpaths    += ./../../../Source/foundation/include
SampleBase_debug_hpaths    += ./../../../Source/Common/src
SampleBase_debug_hpaths    += ./../../../Source/GeomUtils/headers
SampleBase_debug_hpaths    += ./../../../Source/GeomUtils/include
SampleBase_debug_hpaths    += ./../../../Include/foundation
SampleBase_debug_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
SampleBase_debug_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
SampleBase_debug_lpaths    := 
SampleBase_debug_lpaths    += ./../../SampleFramework/framework/lib/android9
SampleBase_debug_lpaths    += ./../../SampleFramework/renderer/lib/android9
SampleBase_debug_lpaths    += ./../../SampleFramework/platform/lib/android9
SampleBase_debug_defines   := $(SampleBase_custom_defines)
SampleBase_debug_defines   += PHYSX_PROFILE_SDK
SampleBase_debug_defines   += ANDROID
SampleBase_debug_defines   += GLES2
SampleBase_debug_defines   += __ARM_ARCH_5__
SampleBase_debug_defines   += __ARM_ARCH_5T__
SampleBase_debug_defines   += __ARM_ARCH_5E__
SampleBase_debug_defines   += __ARM_ARCH_5TE__
SampleBase_debug_defines   += _DEBUG
SampleBase_debug_defines   += PX_DEBUG
SampleBase_debug_defines   += PX_CHECKED
SampleBase_debug_defines   += PX_SUPPORT_VISUAL_DEBUGGER
SampleBase_debug_defines   += PX_NVTX
SampleBase_debug_libraries := 
SampleBase_debug_libraries += SampleFramework-MTDEBUG
SampleBase_debug_libraries += SampleRenderer-MTDEBUG
SampleBase_debug_libraries += SamplePlatform-MTDEBUG
SampleBase_debug_common_cflags	:= $(SampleBase_custom_cflags)
SampleBase_debug_common_cflags    += -MMD
SampleBase_debug_common_cflags    += $(addprefix -D, $(SampleBase_debug_defines))
SampleBase_debug_common_cflags    += $(addprefix -I, $(SampleBase_debug_hpaths))
SampleBase_debug_cflags	:= $(SampleBase_debug_common_cflags)
SampleBase_debug_cflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_debug_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_debug_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_debug_cflags  += -g3 -gdwarf-2
SampleBase_debug_cppflags	:= $(SampleBase_debug_common_cflags)
SampleBase_debug_cppflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_debug_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_debug_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_debug_cppflags  += -g3 -gdwarf-2
SampleBase_debug_lflags    := $(SampleBase_custom_lflags)
SampleBase_debug_lflags    += $(addprefix -L, $(SampleBase_debug_lpaths))
SampleBase_debug_lflags    += -Wl,--start-group $(addprefix -l, $(SampleBase_debug_libraries)) -Wl,--end-group
SampleBase_debug_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_debug_objsdir  = $(OBJS_DIR)/SampleBase_debug
SampleBase_debug_cpp_o    = $(addprefix $(SampleBase_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(SampleBase_cppfiles)))))
SampleBase_debug_c_o      = $(addprefix $(SampleBase_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(SampleBase_cfiles)))))
SampleBase_debug_cc_o      = $(addprefix $(SampleBase_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(SampleBase_ccfiles)))))
SampleBase_debug_obj      = $(SampleBase_debug_cpp_o) $(SampleBase_debug_cc_o) $(SampleBase_debug_c_o)
SampleBase_debug_bin      := ./../../lib/android9/libSampleBaseDEBUG.a

clean_SampleBase_debug: 
	@$(ECHO) clean SampleBase debug
	@$(RMDIR) $(SampleBase_debug_objsdir)
	@$(RMDIR) $(SampleBase_debug_bin)

build_SampleBase_debug: postbuild_SampleBase_debug
postbuild_SampleBase_debug: mainbuild_SampleBase_debug
mainbuild_SampleBase_debug: prebuild_SampleBase_debug $(SampleBase_debug_bin)
prebuild_SampleBase_debug:

$(SampleBase_debug_bin): $(SampleBase_debug_obj) build_SampleFramework-MT_debug build_SampleRenderer-MT_debug build_SamplePlatform-MT_debug 
	@mkdir -p `dirname ./../../lib/android9/libSampleBaseDEBUG.a`
	@$(AR) rcs $(SampleBase_debug_bin) $(SampleBase_debug_obj)
	@$(ECHO) building $@ complete!

SampleBase_debug_DEPDIR = $(dir $(@))/$(*F)
$(SampleBase_debug_cpp_o): $(SampleBase_debug_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cppfiles))))))
	@cp $(SampleBase_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cppfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cppfiles))))).debug.P; \
	  rm -f $(SampleBase_debug_DEPDIR).d

$(SampleBase_debug_c_o): $(SampleBase_debug_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(SampleBase_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cfiles))))))
	@cp $(SampleBase_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_cfiles))))).debug.P; \
	  rm -f $(SampleBase_debug_DEPDIR).d

$(SampleBase_debug_cc_o): $(SampleBase_debug_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_ccfiles)))
	@cp $(SampleBase_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_debug_objsdir),, $@))), $(SampleBase_ccfiles))))).debug.P; \
	  rm -f $(SampleBase_debug_DEPDIR).d

SampleBase_checked_hpaths    := 
SampleBase_checked_hpaths    += ./../../PxToolkit/include
SampleBase_checked_hpaths    += ./../../SampleFramework/framework/include
SampleBase_checked_hpaths    += ./../../SampleFramework/renderer/include
SampleBase_checked_hpaths    += ./../../SampleFramework/platform/include
SampleBase_checked_hpaths    += ./../../../Source/shared/general/shared
SampleBase_checked_hpaths    += ./../../../Include
SampleBase_checked_hpaths    += ./../../../Source/foundation/include
SampleBase_checked_hpaths    += ./../../../Source/Common/src
SampleBase_checked_hpaths    += ./../../../Source/GeomUtils/headers
SampleBase_checked_hpaths    += ./../../../Source/GeomUtils/include
SampleBase_checked_hpaths    += ./../../../Include/foundation
SampleBase_checked_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
SampleBase_checked_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
SampleBase_checked_lpaths    := 
SampleBase_checked_lpaths    += ./../../SampleFramework/framework/lib/android9
SampleBase_checked_lpaths    += ./../../SampleFramework/renderer/lib/android9
SampleBase_checked_lpaths    += ./../../SampleFramework/platform/lib/android9
SampleBase_checked_defines   := $(SampleBase_custom_defines)
SampleBase_checked_defines   += PHYSX_PROFILE_SDK
SampleBase_checked_defines   += ANDROID
SampleBase_checked_defines   += GLES2
SampleBase_checked_defines   += __ARM_ARCH_5__
SampleBase_checked_defines   += __ARM_ARCH_5T__
SampleBase_checked_defines   += __ARM_ARCH_5E__
SampleBase_checked_defines   += __ARM_ARCH_5TE__
SampleBase_checked_defines   += NDEBUG
SampleBase_checked_defines   += PX_CHECKED
SampleBase_checked_defines   += PX_SUPPORT_VISUAL_DEBUGGER
SampleBase_checked_defines   += PX_NVTX
SampleBase_checked_libraries := 
SampleBase_checked_libraries += SampleFramework-MTCHECKED
SampleBase_checked_libraries += SampleRenderer-MTCHECKED
SampleBase_checked_libraries += SamplePlatform-MTCHECKED
SampleBase_checked_common_cflags	:= $(SampleBase_custom_cflags)
SampleBase_checked_common_cflags    += -MMD
SampleBase_checked_common_cflags    += $(addprefix -D, $(SampleBase_checked_defines))
SampleBase_checked_common_cflags    += $(addprefix -I, $(SampleBase_checked_hpaths))
SampleBase_checked_cflags	:= $(SampleBase_checked_common_cflags)
SampleBase_checked_cflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_checked_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_checked_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_checked_cflags  += -g3 -gdwarf-2 -O3 -fno-strict-aliasing
SampleBase_checked_cflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_checked_cflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
SampleBase_checked_cppflags	:= $(SampleBase_checked_common_cflags)
SampleBase_checked_cppflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_checked_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_checked_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_checked_cppflags  += -g3 -gdwarf-2 -O3 -fno-strict-aliasing
SampleBase_checked_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_checked_cppflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
SampleBase_checked_lflags    := $(SampleBase_custom_lflags)
SampleBase_checked_lflags    += $(addprefix -L, $(SampleBase_checked_lpaths))
SampleBase_checked_lflags    += -Wl,--start-group $(addprefix -l, $(SampleBase_checked_libraries)) -Wl,--end-group
SampleBase_checked_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_checked_objsdir  = $(OBJS_DIR)/SampleBase_checked
SampleBase_checked_cpp_o    = $(addprefix $(SampleBase_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(SampleBase_cppfiles)))))
SampleBase_checked_c_o      = $(addprefix $(SampleBase_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(SampleBase_cfiles)))))
SampleBase_checked_cc_o      = $(addprefix $(SampleBase_checked_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(SampleBase_ccfiles)))))
SampleBase_checked_obj      = $(SampleBase_checked_cpp_o) $(SampleBase_checked_cc_o) $(SampleBase_checked_c_o)
SampleBase_checked_bin      := ./../../lib/android9/libSampleBaseCHECKED.a

clean_SampleBase_checked: 
	@$(ECHO) clean SampleBase checked
	@$(RMDIR) $(SampleBase_checked_objsdir)
	@$(RMDIR) $(SampleBase_checked_bin)

build_SampleBase_checked: postbuild_SampleBase_checked
postbuild_SampleBase_checked: mainbuild_SampleBase_checked
mainbuild_SampleBase_checked: prebuild_SampleBase_checked $(SampleBase_checked_bin)
prebuild_SampleBase_checked:

$(SampleBase_checked_bin): $(SampleBase_checked_obj) build_SampleFramework-MT_checked build_SampleRenderer-MT_checked build_SamplePlatform-MT_checked 
	@mkdir -p `dirname ./../../lib/android9/libSampleBaseCHECKED.a`
	@$(AR) rcs $(SampleBase_checked_bin) $(SampleBase_checked_obj)
	@$(ECHO) building $@ complete!

SampleBase_checked_DEPDIR = $(dir $(@))/$(*F)
$(SampleBase_checked_cpp_o): $(SampleBase_checked_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling checked $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_checked_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cppfiles))))))
	@cp $(SampleBase_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cppfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cppfiles))))).checked.P; \
	  rm -f $(SampleBase_checked_DEPDIR).d

$(SampleBase_checked_c_o): $(SampleBase_checked_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling checked $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(SampleBase_checked_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cfiles))))))
	@cp $(SampleBase_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_cfiles))))).checked.P; \
	  rm -f $(SampleBase_checked_DEPDIR).d

$(SampleBase_checked_cc_o): $(SampleBase_checked_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_checked_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_ccfiles)))
	@cp $(SampleBase_checked_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_ccfiles))))).checked.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_checked_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_checked_objsdir),, $@))), $(SampleBase_ccfiles))))).checked.P; \
	  rm -f $(SampleBase_checked_DEPDIR).d

SampleBase_profile_hpaths    := 
SampleBase_profile_hpaths    += ./../../PxToolkit/include
SampleBase_profile_hpaths    += ./../../SampleFramework/framework/include
SampleBase_profile_hpaths    += ./../../SampleFramework/renderer/include
SampleBase_profile_hpaths    += ./../../SampleFramework/platform/include
SampleBase_profile_hpaths    += ./../../../Source/shared/general/shared
SampleBase_profile_hpaths    += ./../../../Include
SampleBase_profile_hpaths    += ./../../../Source/foundation/include
SampleBase_profile_hpaths    += ./../../../Source/Common/src
SampleBase_profile_hpaths    += ./../../../Source/GeomUtils/headers
SampleBase_profile_hpaths    += ./../../../Source/GeomUtils/include
SampleBase_profile_hpaths    += ./../../../Include/foundation
SampleBase_profile_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
SampleBase_profile_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
SampleBase_profile_lpaths    := 
SampleBase_profile_lpaths    += ./../../SampleFramework/framework/lib/android9
SampleBase_profile_lpaths    += ./../../SampleFramework/renderer/lib/android9
SampleBase_profile_lpaths    += ./../../SampleFramework/platform/lib/android9
SampleBase_profile_defines   := $(SampleBase_custom_defines)
SampleBase_profile_defines   += PHYSX_PROFILE_SDK
SampleBase_profile_defines   += ANDROID
SampleBase_profile_defines   += GLES2
SampleBase_profile_defines   += __ARM_ARCH_5__
SampleBase_profile_defines   += __ARM_ARCH_5T__
SampleBase_profile_defines   += __ARM_ARCH_5E__
SampleBase_profile_defines   += __ARM_ARCH_5TE__
SampleBase_profile_defines   += NDEBUG
SampleBase_profile_defines   += PX_PROFILE
SampleBase_profile_defines   += PX_SUPPORT_VISUAL_DEBUGGER
SampleBase_profile_defines   += PX_NVTX
SampleBase_profile_libraries := 
SampleBase_profile_libraries += SampleFramework-MTPROFILE
SampleBase_profile_libraries += SampleRenderer-MTPROFILE
SampleBase_profile_libraries += SamplePlatform-MTPROFILE
SampleBase_profile_common_cflags	:= $(SampleBase_custom_cflags)
SampleBase_profile_common_cflags    += -MMD
SampleBase_profile_common_cflags    += $(addprefix -D, $(SampleBase_profile_defines))
SampleBase_profile_common_cflags    += $(addprefix -I, $(SampleBase_profile_hpaths))
SampleBase_profile_cflags	:= $(SampleBase_profile_common_cflags)
SampleBase_profile_cflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_profile_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_profile_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_profile_cflags  += -O3 -fno-strict-aliasing
SampleBase_profile_cflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_profile_cflags  += -fno-omit-frame-pointer -marm -funswitch-loops -finline-limit=300
SampleBase_profile_cppflags	:= $(SampleBase_profile_common_cflags)
SampleBase_profile_cppflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_profile_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_profile_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_profile_cppflags  += -O3 -fno-strict-aliasing
SampleBase_profile_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_profile_cppflags  += -fno-omit-frame-pointer -marm -funswitch-loops -finline-limit=300
SampleBase_profile_lflags    := $(SampleBase_custom_lflags)
SampleBase_profile_lflags    += $(addprefix -L, $(SampleBase_profile_lpaths))
SampleBase_profile_lflags    += -Wl,--start-group $(addprefix -l, $(SampleBase_profile_libraries)) -Wl,--end-group
SampleBase_profile_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_profile_objsdir  = $(OBJS_DIR)/SampleBase_profile
SampleBase_profile_cpp_o    = $(addprefix $(SampleBase_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(SampleBase_cppfiles)))))
SampleBase_profile_c_o      = $(addprefix $(SampleBase_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(SampleBase_cfiles)))))
SampleBase_profile_cc_o      = $(addprefix $(SampleBase_profile_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(SampleBase_ccfiles)))))
SampleBase_profile_obj      = $(SampleBase_profile_cpp_o) $(SampleBase_profile_cc_o) $(SampleBase_profile_c_o)
SampleBase_profile_bin      := ./../../lib/android9/libSampleBasePROFILE.a

clean_SampleBase_profile: 
	@$(ECHO) clean SampleBase profile
	@$(RMDIR) $(SampleBase_profile_objsdir)
	@$(RMDIR) $(SampleBase_profile_bin)

build_SampleBase_profile: postbuild_SampleBase_profile
postbuild_SampleBase_profile: mainbuild_SampleBase_profile
mainbuild_SampleBase_profile: prebuild_SampleBase_profile $(SampleBase_profile_bin)
prebuild_SampleBase_profile:

$(SampleBase_profile_bin): $(SampleBase_profile_obj) build_SampleFramework-MT_profile build_SampleRenderer-MT_profile build_SamplePlatform-MT_profile 
	@mkdir -p `dirname ./../../lib/android9/libSampleBasePROFILE.a`
	@$(AR) rcs $(SampleBase_profile_bin) $(SampleBase_profile_obj)
	@$(ECHO) building $@ complete!

SampleBase_profile_DEPDIR = $(dir $(@))/$(*F)
$(SampleBase_profile_cpp_o): $(SampleBase_profile_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling profile $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_profile_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cppfiles))))))
	@cp $(SampleBase_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cppfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cppfiles))))).profile.P; \
	  rm -f $(SampleBase_profile_DEPDIR).d

$(SampleBase_profile_c_o): $(SampleBase_profile_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling profile $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(SampleBase_profile_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cfiles))))))
	@cp $(SampleBase_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_cfiles))))).profile.P; \
	  rm -f $(SampleBase_profile_DEPDIR).d

$(SampleBase_profile_cc_o): $(SampleBase_profile_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_profile_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_ccfiles)))
	@cp $(SampleBase_profile_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_ccfiles))))).profile.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_profile_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_profile_objsdir),, $@))), $(SampleBase_ccfiles))))).profile.P; \
	  rm -f $(SampleBase_profile_DEPDIR).d

SampleBase_release_hpaths    := 
SampleBase_release_hpaths    += ./../../PxToolkit/include
SampleBase_release_hpaths    += ./../../SampleFramework/framework/include
SampleBase_release_hpaths    += ./../../SampleFramework/renderer/include
SampleBase_release_hpaths    += ./../../SampleFramework/platform/include
SampleBase_release_hpaths    += ./../../../Source/shared/general/shared
SampleBase_release_hpaths    += ./../../../Include
SampleBase_release_hpaths    += ./../../../Source/foundation/include
SampleBase_release_hpaths    += ./../../../Source/Common/src
SampleBase_release_hpaths    += ./../../../Source/GeomUtils/headers
SampleBase_release_hpaths    += ./../../../Source/GeomUtils/include
SampleBase_release_hpaths    += ./../../../Include/foundation
SampleBase_release_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/include
SampleBase_release_hpaths    += ./../../../externals/android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.7/libs/armeabi-v7a/include
SampleBase_release_lpaths    := 
SampleBase_release_lpaths    += ./../../SampleFramework/framework/lib/android9
SampleBase_release_lpaths    += ./../../SampleFramework/renderer/lib/android9
SampleBase_release_lpaths    += ./../../SampleFramework/platform/lib/android9
SampleBase_release_defines   := $(SampleBase_custom_defines)
SampleBase_release_defines   += PHYSX_PROFILE_SDK
SampleBase_release_defines   += ANDROID
SampleBase_release_defines   += GLES2
SampleBase_release_defines   += __ARM_ARCH_5__
SampleBase_release_defines   += __ARM_ARCH_5T__
SampleBase_release_defines   += __ARM_ARCH_5E__
SampleBase_release_defines   += __ARM_ARCH_5TE__
SampleBase_release_defines   += NDEBUG
SampleBase_release_libraries := 
SampleBase_release_libraries += SampleFramework-MT
SampleBase_release_libraries += SampleRenderer-MT
SampleBase_release_libraries += SamplePlatform-MT
SampleBase_release_common_cflags	:= $(SampleBase_custom_cflags)
SampleBase_release_common_cflags    += -MMD
SampleBase_release_common_cflags    += $(addprefix -D, $(SampleBase_release_defines))
SampleBase_release_common_cflags    += $(addprefix -I, $(SampleBase_release_hpaths))
SampleBase_release_cflags	:= $(SampleBase_release_common_cflags)
SampleBase_release_cflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_release_cflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_release_cflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_release_cflags  += -O3 -fno-strict-aliasing
SampleBase_release_cflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_release_cflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
SampleBase_release_cppflags	:= $(SampleBase_release_common_cflags)
SampleBase_release_cppflags  += -fpic -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb-interwork -fno-exceptions -fno-rtti
SampleBase_release_cppflags  += -Wno-invalid-offsetof -Wno-unknown-pragmas -Wno-psabi
SampleBase_release_cppflags  += -isysroot ../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_release_cppflags  += -O3 -fno-strict-aliasing
SampleBase_release_cppflags  += -ffunction-sections -funwind-tables -fstack-protector
SampleBase_release_cppflags  += -fomit-frame-pointer -funswitch-loops -finline-limit=300
SampleBase_release_lflags    := $(SampleBase_custom_lflags)
SampleBase_release_lflags    += $(addprefix -L, $(SampleBase_release_lpaths))
SampleBase_release_lflags    += -Wl,--start-group $(addprefix -l, $(SampleBase_release_libraries)) -Wl,--end-group
SampleBase_release_lflags  += --sysroot=../../../externals/android-ndk-r8e/platforms/android-9/arch-arm
SampleBase_release_objsdir  = $(OBJS_DIR)/SampleBase_release
SampleBase_release_cpp_o    = $(addprefix $(SampleBase_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(SampleBase_cppfiles)))))
SampleBase_release_c_o      = $(addprefix $(SampleBase_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(SampleBase_cfiles)))))
SampleBase_release_cc_o      = $(addprefix $(SampleBase_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(SampleBase_ccfiles)))))
SampleBase_release_obj      = $(SampleBase_release_cpp_o) $(SampleBase_release_cc_o) $(SampleBase_release_c_o)
SampleBase_release_bin      := ./../../lib/android9/libSampleBase.a

clean_SampleBase_release: 
	@$(ECHO) clean SampleBase release
	@$(RMDIR) $(SampleBase_release_objsdir)
	@$(RMDIR) $(SampleBase_release_bin)

build_SampleBase_release: postbuild_SampleBase_release
postbuild_SampleBase_release: mainbuild_SampleBase_release
mainbuild_SampleBase_release: prebuild_SampleBase_release $(SampleBase_release_bin)
prebuild_SampleBase_release:

$(SampleBase_release_bin): $(SampleBase_release_obj) build_SampleFramework-MT_release build_SampleRenderer-MT_release build_SamplePlatform-MT_release 
	@mkdir -p `dirname ./../../lib/android9/libSampleBase.a`
	@$(AR) rcs $(SampleBase_release_bin) $(SampleBase_release_obj)
	@$(ECHO) building $@ complete!

SampleBase_release_DEPDIR = $(dir $(@))/$(*F)
$(SampleBase_release_cpp_o): $(SampleBase_release_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cppfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cppfiles))))))
	@cp $(SampleBase_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cppfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cppfiles))))).release.P; \
	  rm -f $(SampleBase_release_DEPDIR).d

$(SampleBase_release_c_o): $(SampleBase_release_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cfiles))...
	@mkdir -p $(dir $(@))
	@$(CC) $(SampleBase_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cfiles))))))
	@cp $(SampleBase_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_cfiles))))).release.P; \
	  rm -f $(SampleBase_release_DEPDIR).d

$(SampleBase_release_cc_o): $(SampleBase_release_objsdir)/%.o:
	@$(ECHO) SampleBase: compiling  $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_ccfiles))...
	@mkdir -p $(dir $(@))
	@$(CXX) $(SampleBase_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_ccfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_ccfiles)))
	@cp $(SampleBase_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(SampleBase_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(SampleBase_release_objsdir),, $@))), $(SampleBase_ccfiles))))).release.P; \
	  rm -f $(SampleBase_release_DEPDIR).d

clean_SampleBase:  clean_SampleBase_debug clean_SampleBase_checked clean_SampleBase_profile clean_SampleBase_release
	@rm -rf $(DEPSDIR)
