/*
 * Copyright 2014-2015 NVIDIA Corporation.  All rights reserved.
 *
 * NOTICE TO USER:
 *
 * This source code is subject to NVIDIA ownership rights under U.S. and
 * international Copyright laws.
 *
 * This software and the information contained herein is PROPRIETARY and
 * CONFIDENTIAL to NVIDIA and is being provided under the terms and conditions
 * of a form of NVIDIA software license agreement.
 *
 * NVIDIA MAKES NO REPRESENTATION ABOUT THE SUITABILITY OF THIS SOURCE
 * CODE FOR ANY PURPOSE.  IT IS PROVIDED "AS IS" WITHOUT EXPRESS OR
 * IMPLIED WARRANTY OF ANY KIND.  NVIDIA DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOURCE CODE, INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
 * IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL,
 * OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
 * OF USE, DATA OR PROFITS,  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
 * OR OTHER TORTIOUS ACTION,  ARISING OUT OF OR IN CONNECTION WITH THE USE
 * OR PERFORMANCE OF THIS SOURCE CODE.
 *
 * U.S. Government End Users.   This source code is a "commercial item" as
 * that term is defined at  48 C.F.R. 2.101 (OCT 1995), consisting  of
 * "commercial computer  software"  and "commercial computer software
 * documentation" as such terms are  used in 48 C.F.R. 12.212 (SEPT 1995)
 * and is provided to the U.S. Government only as a commercial end item.
 * Consistent with 48 C.F.R.12.212 and 48 C.F.R. 227.7202-1 through
 * 227.7202-4 (JUNE 1995), all U.S. Government End Users acquire the
 * source code with only those rights set forth herein.
 *
 * Any use of this source code in individual and commercial software must
 * include, in the user documentation and internal comments to the code,
 * the above Disclaimer and U.S. Government End Users Notice.
 */

#include <stdlib.h>
#include <GLES3/gl3.h>

#include "WinSysEGL.h"
#include "CheckMacros.h"

// =============================================================================
// DEFINES
// =============================================================================

#ifndef EGL_OPENGL_ES3_BIT_KHR
#define EGL_OPENGL_ES3_BIT_KHR                              0x00000040
#endif

// ===========================================================================
// WinSysTerminate() - close the window system connection
// ===========================================================================

void WinSysTerminate(WinInfo& info)
{
    if (info.dpy)
    {
        eglTerminate(info.dpy);
    }
    eglReleaseThread();
}

// =============================================================================
// GetCurrentContext() - query the current opengl es context
// =============================================================================

uint64_t GetCurrentContext()
{
    return (uint64_t)eglGetCurrentContext();
}

// =============================================================================
// GetGLProcAddress() - get proc address by name
// =============================================================================

void* GetGLProcAddress (const char* procname)
{
    return (void*) eglGetProcAddress(procname);
}

// =============================================================================
// SwapBuffers() - Posts colour buffer to the associated native window
// =============================================================================

void SwapBuffers(WinInfo& info)
{
    eglSwapBuffers(info.dpy, info.surf);
}

// ===========================================================================
// WinSysInitialize() - Initialize the window in which we can render
// ===========================================================================

int WinSysInitialize(WinInfo& info)
{
    EGLint esBit = EGL_OPENGL_ES2_BIT;
    EGLint esVersion = 2;

    extern int g_glversion;

    if (g_glversion == 20)
    {
        esBit = EGL_OPENGL_ES2_BIT;
        esVersion = 2;
    }
    else if (g_glversion == 30 || g_glversion == 31)
    {
        esBit = EGL_OPENGL_ES3_BIT_KHR;
        esVersion = 3;
    }

    static EGLint configAttrs[] =
    {
        EGL_RENDERABLE_TYPE, esBit,
        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
        EGL_DEPTH_SIZE, 16,
        EGL_NONE
    };

    static EGLint configAttrsRGBA8888[] =
    {
        EGL_RENDERABLE_TYPE, esBit,
        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
        EGL_RED_SIZE, 8,
        EGL_GREEN_SIZE, 8,
        EGL_BLUE_SIZE, 8,
        EGL_ALPHA_SIZE, 8,
        EGL_DEPTH_SIZE, 16,
        EGL_NONE
    };

    static EGLint contextAttrs[] =
    {
        EGL_CONTEXT_CLIENT_VERSION, esVersion,
        EGL_NONE
    };

    info.dpy = eglGetDisplay(EGL_DEFAULT_DISPLAY);

    CHECK(info.dpy == EGL_NO_DISPLAY, 1, "Error: %s", "EGL failed to obtain display");

    EGLBoolean rv = eglInitialize(info.dpy, 0, 0);
    CHECK(rv == 0, 1, "Error: %s", "EGL failed to initialize");

    rv = eglBindAPI(EGL_OPENGL_ES_API);
    CHECK(rv == 0, 1, "Error: %s", "EGL failed to bind API");

    EGLint ncfg = 0;
    rv = eglChooseConfig(
        info.dpy,
        configAttrs,
        &info.cfg,
        1,
        &ncfg);
    CHECK(rv == 0, 1, "Error: %s", "EGL failed to choose config");
    CHECK(ncfg == 0, 1, "Error: %s", "EGL found no GLES2 configs");

    info.surf = eglCreateWindowSurface(
        info.dpy,
        info.cfg,
        info.nativeWindow, 0);
    if(info.surf == EGL_NO_SURFACE)
    {
        ncfg = 0;
        rv = eglChooseConfig(
            info.dpy,
            configAttrsRGBA8888,
            &info.cfg,
            1,
            &ncfg);
        CHECK(rv == 0, 1, "Error: %s", "EGL failed to choose config");
        CHECK(ncfg == 0, 1, "Error: %s", "EGL found no GLES2 configs");
        info.surf = eglCreateWindowSurface(
            info.dpy,
            info.cfg,
            info.nativeWindow, 0);
        CHECK(info.surf == EGL_NO_SURFACE, 1, "Error: %s", "EGL failed to create surface");
    }

    info.ctx = eglCreateContext(
        info.dpy,
        info.cfg,
        EGL_NO_CONTEXT,
        contextAttrs);
    CHECK(info.ctx == EGL_NO_CONTEXT, 1, "Error: %s", "EGL failed to create context");

    rv = eglMakeCurrent(info.dpy, info.surf, info.surf, info.ctx);
    CHECK(rv == 0, 1, "Error: %s", "EGL couldn't make context current");

    rv = eglSwapInterval(info.dpy, 1);
    CHECK(rv == 0, 1, "Error: %s", "EGL couldn't set swap interval");

    return 0;
}

