# Makefile generated by XPJ for linux-aarch64
-include Makefile.custom
ProjectName = freetype
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/autofit/autofit.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/bdf/bdf.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/cff/cff.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftbase.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftbitmap.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/cache/ftcache.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftdebug.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftfstype.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftgasp.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftglyph.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/gzip/ftgzip.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftinit.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/lzw/ftlzw.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftstroke.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftsystem.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/smooth/smooth.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftbbox.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftgxval.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftlcdfil.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftmm.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftotval.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftpatent.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftpfr.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftsynth.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/fttype1.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftwinfnt.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/base/ftxf86.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/pcf/pcf.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/pfr/pfr.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/psaux/psaux.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/pshinter/pshinter.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/psnames/psmodule.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/raster/raster.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/sfnt/sfnt.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/truetype/truetype.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/type1/type1.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/cid/type1cid.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/type42/type42.c
freetype_cfiles   += ./../../../extensions/externals/src/freetype-2.4.9/src/winfonts/winfnt.c

freetype_cpp_debug_dep    = $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(freetype_cppfiles)))))
freetype_cc_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(freetype_ccfiles)))))
freetype_c_debug_dep      = $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(freetype_cfiles)))))
freetype_debug_dep      = $(freetype_cpp_debug_dep) $(freetype_cc_debug_dep) $(freetype_c_debug_dep)
-include $(freetype_debug_dep)
freetype_cpp_release_dep    = $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(freetype_cppfiles)))))
freetype_cc_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(freetype_ccfiles)))))
freetype_c_release_dep      = $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(freetype_cfiles)))))
freetype_release_dep      = $(freetype_cpp_release_dep) $(freetype_cc_release_dep) $(freetype_c_release_dep)
-include $(freetype_release_dep)
freetype_debug_hpaths    := 
freetype_debug_hpaths    += ./../../../extensions/externals/src/freetype-2.4.9/include
freetype_debug_hpaths    += ./../../../extensions/externals/src/freetype-2.4.9/src
freetype_debug_hpaths    += ./../../../extensions/extensions/include
freetype_debug_hpaths    += ./../../../extensions/extensions/include/NsFoundation
freetype_debug_hpaths    += ./../../../extensions/extensions/include/NvFoundation
freetype_debug_hpaths    += ./../../../extensions/extensions/externals/include
freetype_debug_hpaths    += ./../../../extensions/extensions/externals/include/GLFW
freetype_debug_lpaths    := 
freetype_debug_defines   := $(freetype_custom_defines)
freetype_debug_defines   += FT2_BUILD_LIBRARY
freetype_debug_defines   += LINUX=1
freetype_debug_defines   += NV_LINUX
freetype_debug_defines   += GLEW_NO_GLU=1
freetype_debug_defines   += _DEBUG
freetype_debug_libraries := 
freetype_debug_common_cflags	:= $(freetype_custom_cflags)
freetype_debug_common_cflags    += -MMD
freetype_debug_common_cflags    += $(addprefix -D, $(freetype_debug_defines))
freetype_debug_common_cflags    += $(addprefix -I, $(freetype_debug_hpaths))
freetype_debug_common_cflags  += -funwind-tables -Wall -Wextra -Wno-unused-parameter -Wno-ignored-qualifiers -Wno-unused-but-set-variable -Wno-switch -Wno-unused-variable -Wno-unused-function -pthread
freetype_debug_common_cflags  += -funwind-tables -O0 -g -ggdb -fno-omit-frame-pointer
freetype_debug_cflags	:= $(freetype_debug_common_cflags)
freetype_debug_cppflags	:= $(freetype_debug_common_cflags)
freetype_debug_cppflags  += -Wno-reorder -std=c++11
freetype_debug_cppflags  += -Wno-reorder
freetype_debug_lflags    := $(freetype_custom_lflags)
freetype_debug_lflags    += $(addprefix -L, $(freetype_debug_lpaths))
freetype_debug_lflags    += -Wl,--start-group $(addprefix -l, $(freetype_debug_libraries)) -Wl,--end-group
freetype_debug_lflags  += -Wl,--unresolved-symbols=ignore-in-shared-libs -pthread
freetype_debug_objsdir  = $(OBJS_DIR)/freetype_debug
freetype_debug_cpp_o    = $(addprefix $(freetype_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(freetype_cppfiles)))))
freetype_debug_cc_o    = $(addprefix $(freetype_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(freetype_ccfiles)))))
freetype_debug_c_o      = $(addprefix $(freetype_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(freetype_cfiles)))))
freetype_debug_obj      =  $(freetype_debug_cpp_o) $(freetype_debug_cc_o) $(freetype_debug_c_o) 
freetype_debug_bin      := ./../../../extensions/externals/lib/linux-aarch64/libfreetypeD.a

clean_freetype_debug: 
	@$(ECHO) clean freetype debug
	@$(RMDIR) $(freetype_debug_objsdir)
	@$(RMDIR) $(freetype_debug_bin)
	@$(RMDIR) $(DEPSDIR)/freetype/debug

build_freetype_debug: postbuild_freetype_debug
postbuild_freetype_debug: mainbuild_freetype_debug
mainbuild_freetype_debug: prebuild_freetype_debug $(freetype_debug_bin)
prebuild_freetype_debug:

$(freetype_debug_bin): $(freetype_debug_obj) 
	mkdir -p `dirname ./../../../extensions/externals/lib/linux-aarch64/libfreetypeD.a`
	@$(AR) rcs $(freetype_debug_bin) $(freetype_debug_obj)
	$(ECHO) building $@ complete!

freetype_debug_DEPDIR = $(dir $(@))/$(*F)
$(freetype_debug_cpp_o): $(freetype_debug_objsdir)/%.o:
	$(ECHO) freetype: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(freetype_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cppfiles))))))
	cp $(freetype_debug_DEPDIR).d $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cppfiles))))).P; \
	  rm -f $(freetype_debug_DEPDIR).d

$(freetype_debug_cc_o): $(freetype_debug_objsdir)/%.o:
	$(ECHO) freetype: compiling debug $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(freetype_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_ccfiles))))))
	cp $(freetype_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_ccfiles))))).debug.P; \
	  rm -f $(freetype_debug_DEPDIR).d

$(freetype_debug_c_o): $(freetype_debug_objsdir)/%.o:
	$(ECHO) freetype: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(freetype_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cfiles))))))
	cp $(freetype_debug_DEPDIR).d $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/freetype/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_debug_objsdir),, $@))), $(freetype_cfiles))))).P; \
	  rm -f $(freetype_debug_DEPDIR).d

freetype_release_hpaths    := 
freetype_release_hpaths    += ./../../../extensions/externals/src/freetype-2.4.9/include
freetype_release_hpaths    += ./../../../extensions/externals/src/freetype-2.4.9/src
freetype_release_hpaths    += ./../../../extensions/extensions/include
freetype_release_hpaths    += ./../../../extensions/extensions/include/NsFoundation
freetype_release_hpaths    += ./../../../extensions/extensions/include/NvFoundation
freetype_release_hpaths    += ./../../../extensions/extensions/externals/include
freetype_release_hpaths    += ./../../../extensions/extensions/externals/include/GLFW
freetype_release_lpaths    := 
freetype_release_defines   := $(freetype_custom_defines)
freetype_release_defines   += FT2_BUILD_LIBRARY
freetype_release_defines   += LINUX=1
freetype_release_defines   += NV_LINUX
freetype_release_defines   += GLEW_NO_GLU=1
freetype_release_defines   += NDEBUG
freetype_release_libraries := 
freetype_release_common_cflags	:= $(freetype_custom_cflags)
freetype_release_common_cflags    += -MMD
freetype_release_common_cflags    += $(addprefix -D, $(freetype_release_defines))
freetype_release_common_cflags    += $(addprefix -I, $(freetype_release_hpaths))
freetype_release_common_cflags  += -funwind-tables -Wall -Wextra -Wno-unused-parameter -Wno-ignored-qualifiers -Wno-unused-but-set-variable -Wno-switch -Wno-unused-variable -Wno-unused-function -pthread
freetype_release_cflags	:= $(freetype_release_common_cflags)
freetype_release_cppflags	:= $(freetype_release_common_cflags)
freetype_release_cppflags  += -Wno-reorder -std=c++11
freetype_release_cppflags  += -Wno-reorder
freetype_release_lflags    := $(freetype_custom_lflags)
freetype_release_lflags    += $(addprefix -L, $(freetype_release_lpaths))
freetype_release_lflags    += -Wl,--start-group $(addprefix -l, $(freetype_release_libraries)) -Wl,--end-group
freetype_release_lflags  += -Wl,--unresolved-symbols=ignore-in-shared-libs -pthread
freetype_release_objsdir  = $(OBJS_DIR)/freetype_release
freetype_release_cpp_o    = $(addprefix $(freetype_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(freetype_cppfiles)))))
freetype_release_cc_o    = $(addprefix $(freetype_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(freetype_ccfiles)))))
freetype_release_c_o      = $(addprefix $(freetype_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(freetype_cfiles)))))
freetype_release_obj      =  $(freetype_release_cpp_o) $(freetype_release_cc_o) $(freetype_release_c_o) 
freetype_release_bin      := ./../../../extensions/externals/lib/linux-aarch64/libfreetype.a

clean_freetype_release: 
	@$(ECHO) clean freetype release
	@$(RMDIR) $(freetype_release_objsdir)
	@$(RMDIR) $(freetype_release_bin)
	@$(RMDIR) $(DEPSDIR)/freetype/release

build_freetype_release: postbuild_freetype_release
postbuild_freetype_release: mainbuild_freetype_release
mainbuild_freetype_release: prebuild_freetype_release $(freetype_release_bin)
prebuild_freetype_release:

$(freetype_release_bin): $(freetype_release_obj) 
	mkdir -p `dirname ./../../../extensions/externals/lib/linux-aarch64/libfreetype.a`
	@$(AR) rcs $(freetype_release_bin) $(freetype_release_obj)
	$(ECHO) building $@ complete!

freetype_release_DEPDIR = $(dir $(@))/$(*F)
$(freetype_release_cpp_o): $(freetype_release_objsdir)/%.o:
	$(ECHO) freetype: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(freetype_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cppfiles))))))
	cp $(freetype_release_DEPDIR).d $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cppfiles))))).P; \
	  rm -f $(freetype_release_DEPDIR).d

$(freetype_release_cc_o): $(freetype_release_objsdir)/%.o:
	$(ECHO) freetype: compiling release $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_release_objsdir),, $@))), $(freetype_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(freetype_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_release_objsdir),, $@))), $(freetype_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_release_objsdir),, $@))), $(freetype_ccfiles))))))
	cp $(freetype_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_release_objsdir),, $@))), $(freetype_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(freetype_release_objsdir),, $@))), $(freetype_ccfiles))))).release.P; \
	  rm -f $(freetype_release_DEPDIR).d

$(freetype_release_c_o): $(freetype_release_objsdir)/%.o:
	$(ECHO) freetype: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(freetype_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cfiles))))))
	cp $(freetype_release_DEPDIR).d $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(freetype_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/freetype/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(freetype_release_objsdir),, $@))), $(freetype_cfiles))))).P; \
	  rm -f $(freetype_release_DEPDIR).d

clean_freetype:  clean_freetype_debug clean_freetype_release
	rm -rf $(DEPSDIR)

export VERBOSE
ifndef VERBOSE
.SILENT:
endif
