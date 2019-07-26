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

//
// NvPmApi OpenGL sample
// This sample program shows the developer how to instrument a simple
// OpenGL application with NvPmApi. The sample supports
// - querying of NvPmApi counters
// - collection of realtime counters on CPU frame boundaries
// - collection of counters per draw call/dispatch using application defined
//   frame replay.
//
// Comments tagged with NVPMINSTRUMENT in the sample explain how to instrument
// the code.
//

// NVPMINSTRUMENT
// NVPM has two different collection modes:
// 1. Real-time Mode
// 2. Experiment Mode
//
// In Real-time mode the functions NVPMSample and NVPMSampleEx are used to
// query the current active counter values from the GPU. If all active
// counters cannot be simultaneously collected real-time mode will collect
// the counters using a round-robin scheduling.
//
// In Experiment mode the application has to structure the program so that
// the same rendering frame can be replayed multiple times in order for
// NVPMAPI to collect all of the experiments. In this mode counters are
// collected for each draw call or compute dispatch.
//
// The program must be written to meet the following high level design:
//
//  NVPMBeginExperiment(perfCtx, &numPasses)
//  for (int pass = 0; pass < numPasses; ++pass) {
//      int object = 0;
//      NVPMBeginPass(perfCtx, pass);
//      NVPMBeginObject(perfCtx, object);
//          glDraw*
//          // required CPU/GPU synchronization
//          glFinish();
//      NVPMEndObject(perfCtx, object++);
//      // repeat NVPMBeginOject ... NVPMEndObject
//      NVPMEndPass(perfCtx, pass);
//  }
//  NVPMEndExperiment(perfCtx);
//  // collect results
//
// This design often requires the implementation of a state machine.
// The struct Mode and the two implementation RealtimeMode and ExperimentMode
// show how to instrument a program to collect counters in both modes.

// =============================================================================
// INCLUDES
// =============================================================================

#include <android/log.h>
#include <android_native_app_glue.h>

#include <math.h>
#include <stdarg.h>
#include <GLES3/gl3.h>

// =============================================================================
// NVPMINSTRUMENT
// Define NVPM_INITGUID in one compilation unit before including NvPmApi.h
// in order to define the NvPmApi export table GUID.
//
// NvPmApi.Manager.h contains NvPmApiManager, a C++ helper class, that simplifies
// loading the NvPmApi shared library and querying for the NvPmApi export table.
// =============================================================================

#ifndef NVPM_INITGUID
#define NVPM_INITGUID   1
#endif
#include <NvPmApi.h>
#include <NvPmApi.Manager.h>

#include "CheckMacros.h"
#include "WinSysEGL.h"

// =============================================================================
// MODE
// =============================================================================

struct Mode;
typedef void (*FrameBegin_Pfn)(Mode* pMode);
typedef void (*FrameEnd_Pfn)(Mode* pMode);
typedef void (*WorkBegin_Pfn)(Mode* pMode);
typedef void (*WorkEnd_Pfn)(Mode* pMode);
typedef bool (*IsComplete_Pfn)(Mode* pMode);

#define MODE_INIT()             ModeInit(&globals.mode, globals.samplemode, globals.workload, globals.nvpmContext);
#define MODE_FRAME_BEGIN()      globals.mode.FrameBegin(&globals.mode);
#define MODE_FRAME_END()        globals.mode.FrameEnd(&globals.mode);
#define MODE_WORK_BEGIN()       globals.mode.WorkBegin(&globals.mode);
#define MODE_WORK_END()         globals.mode.WorkEnd(&globals.mode);
//#define MODE_ISCOMPLETE_BREAK() if (globals.mode.IsComplete(&globals.mode)) { ; }

struct Mode
{
    FrameBegin_Pfn  FrameBegin;
    FrameEnd_Pfn    FrameEnd;
    WorkBegin_Pfn   WorkBegin;
    WorkEnd_Pfn     WorkEnd;
    IsComplete_Pfn  IsComplete;

    NVPMContext     perfCtx;

    int             nFrame;
    NVPMUINT        nPass;
    NVPMUINT        nTotalPasses;
    int             nObjectID;
    bool            bCollecting;

    const char**    counterNames;
    int             counterCount;
};

enum SampleMode
{
    SM_REALTIME,
    SM_EXPERIMENT
};

enum GLWorkload
{
    GW_SHADER,
    GW_TEXTURE,
    GW_BLEND,
    GW_MULTIOBJECTS,
    GW_INSTANCE,
    GW_COMPUTE
};

// =============================================================================
// GL DEFINES
// =============================================================================
#ifndef GL_COMPUTE_SHADER
#define GL_COMPUTE_SHADER                 0x91B9
#endif

#ifndef GL_READ_ONLY
#define GL_READ_ONLY                      35000
#endif

#ifndef GL_WRITE_ONLY
#define GL_WRITE_ONLY                     35001
#endif

int CheckGlErrors(const char *file, int line)
{
    int err = 0;
    GLenum glErr;
    EGLint eglErr;
    while ((glErr = glGetError()) != GL_NO_ERROR)
    {
        Print("\nglError 0x%04x\n at %s:%d\n\n", (int)glErr, file, line);
        err = 1;
    }
    if ((eglErr = eglGetError()) != EGL_SUCCESS)
    {
        Print("\neglError 0x%04x\n at %s:%d\n\n", (int)eglErr, file, line);
        err = 1;
    }

    return err;
}

#define CHECKGLERRORS()                                                     \
        CheckGlErrors(__FILE__,__LINE__)

// =============================================================================
// TYPES
// =============================================================================

struct GraphicsInfo
{
    GLuint graphicsProgram;
    GLuint graphicsTex;
    GLint graphicsSampler;
    GLint graphicsOffset;
    GLuint computeProgram;
};

typedef void (*FPNGLDISPATCHCOMPUTE)(GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);

struct Globals
{
    SampleMode samplemode;
    GLWorkload workload;
    int framestart;
    int framecount;
    int objcount;
    FILE* pfh;
    Mode mode;

    // NVPMINSTRUMENT
    // NvPmApi requires a user to create a context from the GL API context. The
    // NVPMContext maintains the configuration state and counter values for the
    // API context.
    NVPMContext nvpmContext;

    GraphicsInfo graphicsInfo;
    WinInfo winInfo;

    bool bInitialized;

};

// =============================================================================
// DECLARES
// =============================================================================
const int NVPM_GL_PRECISION_SHADER_VERSION = 20;
const int NVPM_GL_INSTANCE_SHADER_VERSION  = 30;
const int NVPM_GL_COMPUTE_SHADER_VERSION   = 31;

const  char*    NVPMResultToString  (NVPMRESULT result);

// =============================================================================
// GLOBALS
// =============================================================================
char computeShaderSource[1024] = "#version 310 es\n";
char vertexShaderInstanceSource[1024] = "#version 300 es\n";
int g_glversion;

FPNGLDISPATCHCOMPUTE glDispatchComputePtr = 0;
Globals globals;

// NVPMINSTRUMENT
// This sample creates a NvPmApiManager singleton. This singleton is used
// to access the NvPmApi C interface through an export table.
static NvPmApiManager s_NvPmApiManager;
extern NvPmApiManager *GetNvPmApiManager()
{
    return &s_NvPmApiManager;
}
const NvPmApi *GetNvPmApi()
{
    return s_NvPmApiManager.Api();
}

// -----------------------------------------------------------------------------
// COUNTERS
// User can add counters to any location in each of these lists.
// -----------------------------------------------------------------------------

#define ARRAY_SIZE(A)   (sizeof(A) / sizeof(A[0]))

static const char* REALTIME_MODE_COMPUTE_COUNTERS[] =
{
    "gpu_idle",
    "sm_active_cycles",
    "sm_active_warps",
    "sm_inst_executed",
};
static const int REALTIME_MODE_COMPUTE_COUNTERS_COUNT = ARRAY_SIZE(REALTIME_MODE_COMPUTE_COUNTERS);

static const char* EXPERIMENT_MODE_COMPUTE_COUNTERS[] =
{
    "sm_ctas_launched",
    "sm_warps_launched",
    "sm_active_cycles",
    "sm_active_warps",
    "sm_inst_executed",
    "sm_executed_ipc",
};
static const int EXPERIMENT_MODE_COMPUTE_COUNTERS_COUNT = ARRAY_SIZE(EXPERIMENT_MODE_COMPUTE_COUNTERS);

static const char* REALTIME_MODE_GRAPHICS_COUNTERS[] =
{
    // cpu counters -- linux/mobile only
    "cpu_load",
    // driver counters -- collected only per frame
    "OGL frame time",
    "OGL AGP/PCI-E usage (bytes)",
    "OGL AGP/PCI-E usage (MB)",
    "OGL vidmem total bytes",
    "OGL vidmem total MB",
    "OGL vidmem bytes",
    "OGL vidmem MB",
    "OGL Frame Batch Count",
    "OGL Frame Vertex Count",
    "OGL Frame Primitive Count",
    // gpu counters
    "gpu_busy",
};
static const int REALTIME_MODE_GRAPHICS_COUNTERS_COUNT = ARRAY_SIZE(REALTIME_MODE_GRAPHICS_COUNTERS);

static const char* EXPERIMENT_MODE_GRAPHICS_COUNTERS[] =
{
    "IA Bottleneck",
    "IA SOL",
    "L2 Bottleneck",
    "Primitive Setup Bottleneck",
    "Primitive Setup SOL",
    "ROP Bottleneck",
    "ROP SOL",
    "Rasterization Bottleneck",
    "Rasterization SOL",
    "SHD Bottleneck",
    "SHD SOL",
    "TEX Bottleneck",
    "TEX SOL",
    "inst_executed_ps",
    "inst_executed_ps_ratio",
    "inst_executed_vs",
    "inst_executed_vs_ratio",
    "setup_primitive_count",
    "shaded_pixel_count",
};
static const int EXPERIMENT_MODE_GRAPHICS_COUNTERS_COUNT = ARRAY_SIZE(EXPERIMENT_MODE_GRAPHICS_COUNTERS);

// =============================================================================
// NVPMAPI HELPER FUNCTIONS
// =============================================================================

const char* NVPMResultToString(NVPMRESULT result)
{
    switch (result)
    {
        case NVPM_FAILURE_DISABLED:                 return "NVPM_FAILURE_DISABLED";             break;
        case NVPM_FAILURE_32BIT_ON_64BIT:           return "NVPM_FAILURE_32BIT_ON_64BIT";       break;
        case NVPM_NO_IMPLEMENTATION:                return "NVPM_NO_IMPLEMENTATION";            break;
        case NVPM_LIBRARY_NOT_FOUND:                return "NVPM_LIBRARY_NOT_FOUND";            break;
        case NVPM_FAILURE:                          return "NVPM_FAILURE";                      break;
        case NVPM_OK:                               return "NVPM_OK";                           break;
        case NVPM_ERROR_INVALID_PARAMETER:          return "NVPM_ERROR_INVALID_PARAMETER";      break;
        case NVPM_ERROR_DRIVER_MISMATCH:            return "NVPM_ERROR_DRIVER_MISMATCH";        break;
        case NVPM_ERROR_NOT_INITIALIZED:            return "NVPM_ERROR_NOT_INITIALIZED";        break;
        case NVPM_ERROR_ALREADY_INITIALIZED:        return "NVPM_ERROR_ALREADY_INITIALIZED";    break;
        case NVPM_ERROR_BAD_ENUMERATOR:             return "NVPM_ERROR_BAD_ENUMERATOR";         break;
        case NVPM_ERROR_STRING_TOO_SMALL:           return "NVPM_ERROR_STRING_TOO_SMALL";       break;
        case NVPM_ERROR_INVALID_COUNTER:            return "NVPM_ERROR_INVALID_COUNTER";        break;
        case NVPM_ERROR_OUT_OF_MEMORY:              return "NVPM_ERROR_OUT_OF_MEMORY";          break;
        case NVPM_ERROR_EXPERIMENT_INCOMPLETE:      return "NVPM_ERROR_EXPERIMENT_INCOMPLETE";  break;
        case NVPM_ERROR_INVALID_PASS:               return "NVPM_ERROR_INVALID_PASS";           break;
        case NVPM_ERROR_INVALID_OBJECT:             return "NVPM_ERROR_INVALID_OBJECT";         break;
        case NVPM_ERROR_COUNTER_NOT_ENABLED:        return "NVPM_ERROR_COUNTER_NOT_ENABLED";    break;
        case NVPM_ERROR_COUNTER_NOT_FOUND:          return "NVPM_ERROR_COUNTER_NOT_FOUND";      break;
        case NVPM_ERROR_EXPERIMENT_NOT_RUN:         return "NVPM_ERROR_EXPERIMENT_NOT_RUN";     break;
        case NVPM_ERROR_32BIT_ON_64BIT:             return "NVPM_ERROR_32BIT_ON_64BIT";         break;
        case NVPM_ERROR_STATE_MACHINE:              return "NVPM_ERROR_STATE_MACHINE";          break;
        case NVPM_ERROR_INTERNAL:                   return "NVPM_ERROR_INTERNAL";               break;
        case NVPM_WARNING_ENDED_EARLY:              return "NVPM_WARNING_ENDED_EARLY";          break;
        case NVPM_ERROR_TIME_OUT:                   return "NVPN_ERROR_TIME_OUT";               break;
        case NVPM_WARNING_DUPLICATE:                return "NVPM_WARNING_DUPLICATE";            break;
        case NVPM_ERROR_COUNTERS_ENABLED:           return "NVPM_ERROR_COUNTERS_ENABLED";       break;
        case NVPM_ERROR_CONTEXT_NOT_SUPPORTED:      return "NVPM_ERROR_CONTEXT_NOT_SUPPORTED";  break;
        case NVPM_ERROR_INVALID_CONTEXT:            return "NVPM_ERROR_INVALID_CONTEXT";        break;
        case NVPM_ERROR_GPU_UNSUPPORTED:            return "NVPM_ERROR_GPU_UNSUPPORTED";        break;
        case NVPM_INCORRECT_VALUE_TYPE:             return "NVPM_INCORRECT_VALUE_TYPE";         break;
        default:                                    return "NVPM_ERROR_UNKNOWN";                break;
    }
}

static void PrintCounters(FILE* fpFile, NVPMContext perfCtx, const char ** const counterNames, int counterCount)
{
    // NVPMINSTRUMENT
    // The functions GetCounterValueUint64 and GetCounterValueFloat64 should be
    // used to query the value of counters after a NVPMSample or NVPMEndExperiment
    // call.
    // For Real-time mode the function NVPMSampleEx can also be used to
    // collect the results.
    //
    // OPTIMIZATIONS
    // - Applications using Real-time mode should cache the counter ID
    //  and CounterAttribute NVPMA_COUNTER_VALUE_TYPE to avoid overhead.
    //
    for (int i = 0; i < counterCount; ++i)
    {
        NVPMCounterID id = 0;
        NVPMUINT64 type = 0;

        NVPMCHECKCONTINUE(GetNvPmApi()->GetCounterIDByContext(perfCtx, counterNames[i], &id));
        NVPMCHECKCONTINUE(GetNvPmApi()->GetCounterAttribute(id, NVPMA_COUNTER_VALUE_TYPE, &type));

        NVPMUINT64 cycles = 0;
        NVPMUINT8  overflow = 0;
        for (int j = 0; j < globals.objcount; j++)
        {

            if (type == NVPM_VALUE_TYPE_UINT64)
            {
                NVPMUINT64 value = 0;
                GetNvPmApi()->GetCounterValueUint64(perfCtx, id, j, &value, &cycles, &overflow);
                fprintf(fpFile, "%40s value: %10lld cycles: %10lld overflow: %s objectId: %d\n",
                    counterNames[i], (long long int)value, (long long int)cycles, overflow ? "true" : "false", j);
            }
            else if (type == NVPM_VALUE_TYPE_FLOAT64)
            {
                NVPMFLOAT64 value = 0;
                GetNvPmApi()->GetCounterValueFloat64(perfCtx, id, j, &value, &cycles, &overflow);
                fprintf(fpFile, "%40s value: %10f cycles: %10lld overflow: %s objectId: %d\n",
                    counterNames[i], value, (long long int)cycles, overflow ? "true" : "false", j);
            }
        }
    }
}

// -----------------------------------------------------------------------------
// REAL-TIME MODE
// -----------------------------------------------------------------------------

static void RealtimeModeFrameBegin(Mode* pMode)
{
    // NVPMINSTRUMENT
    // In real-time mode the value of counters is sampled from the first
    // frame the counter is added to the first call to NVPMSample. On the first
    // collection frame NVPMSample is called to reset the counter values. Call
    // glFinish to guarantee any frames in progress have completed.
    if (pMode->nFrame == globals.framestart)
    {
        glFinish();
        NVPMUINT unCount = 0;
        GetNvPmApi()->Sample(pMode->perfCtx, 0, &unCount);
        pMode->bCollecting = true;
    }
}

static void RealtimeModeFrameEnd(Mode* pMode)
{
    if (pMode->bCollecting)
    {
        // NVPMINSTRUMENT
        // In real-time mode the counters are synchronously queried. Calling
        // glFinish guarantees the GPU work is complete. If NVPMSample is called
        // prior to glFinish the measurement is for the CPU frame not the GPU
        // frame.
        glFinish();

        // Call NVPMSample to collect the counters to backing store. The counters
        // can be read with NVPMGetCounterValue* prior until the next call to
        // NVPMSample*.
        NVPMUINT unCount = 0;
        GetNvPmApi()->Sample(pMode->perfCtx, 0, &unCount);

        PrintCounters(globals.pfh,
            pMode->perfCtx,
            pMode->counterNames,
            pMode->counterCount);
    }
    ++pMode->nFrame;

    const int maxframe = globals.framestart + globals.framecount;
    if (pMode->nFrame == maxframe)
    {
        pMode->bCollecting = false;
    }
}

static void RealtimeModeWorkBegin(Mode* pMode)
{
    // NVPMINSTRUMENT
    // In real-time mode no work is done on a per draw call or dispatch basis.
    // It is possible to sample per work item but the results are not as
    // accurate as experiment mode.
}

static void RealtimeModeWorkEnd(Mode* pMode)
{
    // NVPMINSTRUMENT
    // In real-time mode no work is done on a per draw call or dispatch basis.
    // It is possible to sample per work item but the results are not as
    // accurate as experiment mode.
}

static bool RealtimeModeIsComplete(Mode* pMode)
{
    const int maxframe = globals.framestart + globals.framecount;
    if (pMode->nFrame >= maxframe)
    {
        return true;
    }
    return false;
}

// -----------------------------------------------------------------------------
// EXPERIMENT MODE
// -----------------------------------------------------------------------------
static void ExperimentModeReserveObjects(Mode* pMode)
{
    // NVPMINSTRUMENT
    // In experiment mode, reserve certain amount of NVPMPerfObjects.
    NVPMCHECKEXIT(GetNvPmApi()->ReserveObjects(pMode->perfCtx,
        globals.objcount));

}

static void ExperimentModeDeleteObjects(Mode* pMode)
{
    // NVPMINSTRUMENT
    // In experiment mode, delete all NVPMPerfObjects in a given NVPMPerfContext
    NVPMCHECKEXIT(GetNvPmApi()->DeleteObjects(pMode->perfCtx));
}

static void ExperimentModeFrameBegin(Mode* pMode)
{
    // NVPMINSTRUMENT
    // The functions NVPMBeginExperiment and NVPMEndExperiment are used to
    // specify the experiment. NVPMBeginExperiment will schedule all active
    // counters and return the number of times the application has to rendering
    // the frame. The application should try to deterministically replay the
    // same content; otherwise, the results may not make sense.
    if (pMode->nFrame == globals.framestart)
    {
        glFinish();
        ExperimentModeReserveObjects(pMode);
        NVPMCHECKEXIT(GetNvPmApi()->BeginExperiment(pMode->perfCtx,
            &pMode->nTotalPasses));
        pMode->bCollecting = true;
        pMode->nPass = 0;
    }

    // NVPMINSTRUMENT
    // For each frame in NVPMBeginExperiment to NVPMEndExperiment range call
    // NVPMBeginPass and NVPMEndPass around the frame. The application must
    // send a pass count start at 0 and increasing by 1 to NumPasses exclusive
    // where NumPasses is the value returned by NVPMBeginExperiment.
    if (pMode->bCollecting)
    {
        NVPMCHECKEXIT(GetNvPmApi()->BeginPass(pMode->perfCtx, pMode->nPass));
    }
}

static void ExperimentModeFrameEnd(Mode* pMode)
{
    // NVPMINSTRUMENT
    // NVPMEndPass must be called with the matching nPass.
    if (pMode->bCollecting)
    {
        NVPMCHECKEXIT(GetNvPmApi()->EndPass(pMode->perfCtx, pMode->nPass));
        ++pMode->nPass;
        pMode->nObjectID = 0;
    }
    if (pMode->bCollecting && pMode->nPass == pMode->nTotalPasses)
    {
        pMode->bCollecting = false;
        pMode->nPass = 0;
        pMode->nTotalPasses = 0;
        // NVPMINSTRUMENT
        // NVPMEndExperiment is called after nTotalPasses.
        NVPMCHECKEXIT(GetNvPmApi()->EndExperiment(pMode->perfCtx));

        PrintCounters(globals.pfh,
            pMode->perfCtx,
            pMode->counterNames,
            pMode->counterCount);
        ExperimentModeDeleteObjects(pMode);
    }
    ++pMode->nFrame;
}

static void ExperimentModeWorkBegin(Mode* pMode)
{
    // NVPMINSTRUMENT
    // Each draw call and dispatch that should be sampled must be wrapped
    // with a NVPMBeginObject NVPMEndObject pair. If more than one draw call
    // or dispatch occur within a range then only the results for the last
    // work item will be sampled.
    //
    // If instrumentation is not done for every draw call and dispatch or
    // if the pass consists of both draw calls and dispatches that are
    // independent (not guaranteed to be ordered by dependencies) then
    // a CPU/GPU synchronization should be made before the BeginObject.
    if (pMode->bCollecting)
    {
        glFinish();
        NVPMCHECKEXIT(GetNvPmApi()->BeginObject(pMode->perfCtx, pMode->nObjectID));
    }
}

static void ExperimentModeWorkEnd(Mode* pMode)
{
    // NVPMINSTRUMENT
    // After each draw call and dispatch the instrumentation is required to
    // force completion of the GPU work item. In OpenGL this is accomplished
    // by calling glFinish.
    if (pMode->bCollecting)
    {
        glFinish();
        NVPMCHECKEXIT(GetNvPmApi()->EndObject(pMode->perfCtx, pMode->nObjectID));
        ++pMode->nObjectID;
    }
}

static bool ExperimentModeIsComplete(Mode* pMode)
{
    if (pMode->nFrame > globals.framestart
        && pMode->nPass >= pMode->nTotalPasses)
    {
       return true;
    }
    return false;
}

// -----------------------------------------------------------------------------
// MODE
// -----------------------------------------------------------------------------

static void ModeReset(Mode* pMode)
{
    pMode->nFrame = 0;
    pMode->nPass = 0;
    pMode->nTotalPasses = 0;
    pMode->nObjectID = 0;
    pMode->counterNames = 0;
    pMode->counterCount = 20;
    pMode->bCollecting = false;
}

static void ModeInit(Mode* pMode, SampleMode samplemode, GLWorkload workload, NVPMContext perfCtx)
{
    ModeReset(pMode);

    if (samplemode == SM_REALTIME)
    {
        pMode->FrameBegin = RealtimeModeFrameBegin;
        pMode->FrameEnd   = RealtimeModeFrameEnd;
        pMode->WorkBegin  = RealtimeModeWorkBegin;
        pMode->WorkEnd    = RealtimeModeWorkEnd;
        pMode->IsComplete = RealtimeModeIsComplete;

        pMode->counterNames = (workload == GW_COMPUTE)
            ? REALTIME_MODE_COMPUTE_COUNTERS
            : REALTIME_MODE_GRAPHICS_COUNTERS;
        pMode->counterCount = (workload == GW_COMPUTE)
            ? REALTIME_MODE_COMPUTE_COUNTERS_COUNT
            : REALTIME_MODE_GRAPHICS_COUNTERS_COUNT;
    }
    else if (samplemode == SM_EXPERIMENT)
    {
        pMode->FrameBegin = ExperimentModeFrameBegin;
        pMode->FrameEnd   = ExperimentModeFrameEnd;
        pMode->WorkBegin  = ExperimentModeWorkBegin;
        pMode->WorkEnd    = ExperimentModeWorkEnd;
        pMode->IsComplete = ExperimentModeIsComplete;

        pMode->counterNames = (workload == GW_COMPUTE)
            ? EXPERIMENT_MODE_COMPUTE_COUNTERS
            : EXPERIMENT_MODE_GRAPHICS_COUNTERS;
        pMode->counterCount = (workload == GW_COMPUTE)
            ? EXPERIMENT_MODE_COMPUTE_COUNTERS_COUNT
            : EXPERIMENT_MODE_GRAPHICS_COUNTERS_COUNT;
    }

    pMode->perfCtx = perfCtx;

    // NVPMINSTRUMENT
    // NPVMAddCounterByName or NVPMAddCounter(s) can be called to activate
    // counters. Counter cannot be added when in a NVPM{Begin/End}Experiment
    // range.
    for (int i = 0; i < pMode->counterCount; ++i)
    {
        NVPMRESULT nvpmResult = NVPM_OK;
        nvpmResult = GetNvPmApi()->AddCounterByName(pMode->perfCtx, pMode->counterNames[i]);
        CHECKCONTINUE(nvpmResult != NVPM_OK,
            "AddCounterByName(%s) returned %08x => %s",
            pMode->counterNames[i], nvpmResult, NVPMResultToString(nvpmResult));
    }
}

// =============================================================================
// GLSL SHADERS
// =============================================================================

static const char vertexShaderSource[] =
{
    "attribute vec3 position;\n"
    "attribute vec3 normal;\n"
    "attribute vec2 texcoord;\n"
    "\n"
    "varying vec2 newtexcoord;\n"
    "\n"
    "void main()\n"
    "{\n"
    "    gl_Position = vec4(position.xyz, 1.0);\n"
    "    newtexcoord = texcoord;\n"
    "}\n"
};

static const char fragmentShaderSource[] =
{
    "precision highp float;\n"
    "uniform sampler2D tex;\n"
    "\n"
    "varying vec2 newtexcoord;\n"
    "\n"
    "void main()\n"
    "{\n"
    "    gl_FragColor = texture2D(tex, newtexcoord);\n"
    "}\n"
};

static const char computeShaderBody[] =
{
    //version number will be added here dynamically
    "precision highp float;\n"
    "precision highp int;\n"
    "layout(binding=0,rgba8) readonly uniform highp image2D srcTex;\n"
    "layout(binding=1,rgba8) writeonly uniform highp image2D destTex;\n"
    "layout (local_size_x = 16, local_size_y = 16) in;\n"
    "void main()\n"
    "{\n"
    "   ivec2 pos = ivec2(gl_GlobalInvocationID.xy);\n"
    "   vec4 tex = imageLoad(srcTex, pos);\n"
    "   imageStore(destTex, pos, vec4(1.0) - tex);\n"
    "}"
};

static const char vertexShaderInstanceBody[] =
{
    //version number will be added here dynamically
    "attribute vec3 position;\n"
    "attribute vec3 normal;\n"
    "attribute vec2 texcoord;\n"
    "\n"
    "uniform vec3 offset[5];\n"
    "\n"
    "varying vec2 newtexcoord;\n"
    "\n"
    "void main()\n"
    "{\n"
    "    gl_Position = vec4(position.xyz + offset[gl_InstanceID], 1.0);\n"
    "    newtexcoord = texcoord;\n"
    "}\n"
};

// =============================================================================
// GEOMETRY - a cube, position/normal/texcoord for every vertex
// =============================================================================
static GLfloat vert[] =
{
    // front
    -1.0f,  1.0f,  1.0f, 0, 0, 1.0f, 0, 1.0f,
    -1.0f, -1.0f,  1.0f, 0, 0, 1.0f, 0, 0,
     1.0f,  1.0f,  1.0f, 0, 0, 1.0f, 1.0f, 1.0f,
     1.0f,  1.0f,  1.0f, 0, 0, 1.0f, 1.0f, 1.0f,
    -1.0f, -1.0f,  1.0f, 0, 0, 1.0f, 0, 0,
     1.0f, -1.0f,  1.0f, 0, 0, 1.0f, 1.0f, 0,

    // back
    1.0f,  1.0f,  -1.0f, 0, 0, -1.0f, 0, 1.0f,
    1.0f, -1.0f,  -1.0f, 0, 0, -1.0f, 0, 0,
    -1.0f,  1.0f,  -1.0f, 0, 0, -1.0f, 1.0f, 1.0f,
    -1.0f,  1.0f,  -1.0f, 0, 0, -1.0f, 1.0f, 1.0f,
    1.0f, -1.0f,  -1.0f, 0, 0, -1.0f, 0, 0,
    -1.0f, -1.0f,  -1.0f, 0, 0, -1.0f, 1.0f, 0,

    // left
    -1.0f,  1.0f,  -1.0f, -1.0f, 0, 0, 0, 1.0f,
    -1.0f, -1.0f,  -1.0f, -1.0f, 0, 0, 0, 0,
    -1.0f,  1.0f,  1.0f, -1.0f, 0, 0, 1.0f, 1.0f,
    -1.0f,  1.0f,  1.0f, -1.0f, 0, 0, 1.0f, 1.0f,
    -1.0f, -1.0f,  -1.0f, -1.0f, 0, 0, 0, 0,
    -1.0f, -1.0f,  1.0f, -1.0f, 0, 0, 1.0f, 0,

    // right
    1.0f,  1.0f,  1.0f, 1.0f, 0, 0, 0, 1.0f,
    1.0f, -1.0f,  1.0f, 1.0f, 0, 0, 0, 0,
    1.0f,  1.0f,  -1.0f, 1.0f, 0, 0, 1.0f, 1.0f,
    1.0f,  1.0f,  -1.0f, 1.0f, 0, 0, 1.0f, 1.0f,
    1.0f, -1.0f,  1.0f, 1.0f, 0, 0, 0, 0,
    1.0f, -1.0f,  -1.0f, 1.0f, 0, 0, 1.0f, 0,

    // top
    -1.0f,  1.0f,  -1.0f, 0, 1.0f, 0, 0, 1.0f,
    -1.0f,  1.0f,  1.0f, 0, 1.0f, 0, 0, 0,
     1.0f,  1.0f,  -1.0f, 0, 1.0f, 0, 1.0f, 1.0f,
     1.0f,  1.0f,  -1.0f, 0, 1.0f, 0, 1.0f, 1.0f,
    -1.0f,  1.0f,  1.0f, 0, 1.0f, 0, 0, 0,
     1.0f,  1.0f,  1.0f, 0, 1.0f, 0, 1.0f, 0,

    // bottom
    -1.0f,  -1.0f,  1.0f, 0, -1.0f, 0, 0, 1.0f,
    -1.0f,  -1.0f,  -1.0f, 0, -1.0f, 0, 0, 0,
     1.0f,  -1.0f,  1.0f, 0, -1.0f, 0, 1.0f, 1.0f,
     1.0f,  -1.0f,  1.0f, 0, -1.0f, 0, 1.0f, 1.0f,
    -1.0f,  -1.0f,  -1.0f, 0, -1.0f, 0, 0, 0,
     1.0f,  -1.0f,  -1.0f, 0, -1.0f, 0, 1.0f, 0,
};

// =============================================================================
// COMMAND LINE UTILITIES
// =============================================================================

void PrintHelp()
{
    const char* const help =
"am start -n com.nvidia.perfkit.samples/.NvPmSample [--esn help] [--es option1 value1] [--es option2 value2] ...\n"
"options:\n"
"  gles VERSION\n"
"       Create a gles context of VERSION version. VERSION is %d, %d or %d.\n"
"  mode MODE\n"
"       Sample counters using MODE. MODE is 'realtime' or 'experiment'.\n"
"       Realtime mode collects GPU and driver counters at each CPU frame\n"
"       boundary and prints the values to the console. Experiment mode collects\n"
"       counters for each draw call and dispatch by replaying the graphics\n"
"       frame many times.\n"
"  workload WORKLOAD\n"
"       Selects the type of workload to issue to the GPU. WORKLOAD is 'shader'\n"
"       'texture', 'blend', 'multiobjects', 'instance' or 'compute'\n"
"  outfile FILE\n"
"       Place output in the file 'FILE'. If outfile is not specified, the default is\n"
"       to output to logcat.\n"
"  frame NUM\n"
"       The frame number to start collecting realtime counters or to enter\n"
"       experiment mode.\n"
"  frame-count NUM\n"
"       The number of frames to collect realtime counters.\n";
    Print(help, NVPM_GL_PRECISION_SHADER_VERSION, NVPM_GL_INSTANCE_SHADER_VERSION, NVPM_GL_COMPUTE_SHADER_VERSION);
}

// -----------------------------------------------------------------------------

static int ParseCommandLine(android_app* pDroidApp)
{
    // set the cmd line info default values
    g_glversion = NVPM_GL_PRECISION_SHADER_VERSION;
    globals.samplemode  = SM_REALTIME;
    globals.workload    = GW_SHADER;
    globals.framestart  = 20;
    globals.framecount  = 100;
    globals.pfh         = stdout;
    globals.objcount    = 1;

    JNIEnv *env;
    pDroidApp->activity->vm->AttachCurrentThread(&env, 0);
    {
        jobject me = pDroidApp->activity->clazz;
        jclass acl = env->GetObjectClass(me); //class pointer of NativeActivity
        jmethodID giid = env->GetMethodID(acl, "getIntent", "()Landroid/content/Intent;");
        jobject intent = env->CallObjectMethod(me, giid); //Got our intent

        jclass icl = env->GetObjectClass(intent); //class pointer of Intent
        jmethodID gseid = env->GetMethodID(icl, "getStringExtra", "(Ljava/lang/String;)Ljava/lang/String;");
        jmethodID hasid = env->GetMethodID(icl, "hasExtra", "(Ljava/lang/String;)Z");

        jboolean bHelp = (jboolean) env->CallBooleanMethod(intent, hasid, env->NewStringUTF("help"));
        if (bHelp)
        {
            PrintHelp();
            exit(0);
        }

        jstring mode = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("mode"));
        if (mode)
        {
            const char *str = env->GetStringUTFChars(mode, 0);
            if (str)
            {
                if (strcasecmp(str, "realtime") == 0)
                {
                    globals.samplemode = SM_REALTIME;
                }
                else if (strcasecmp(str, "experiment") == 0)
                {
                    globals.samplemode = SM_EXPERIMENT;
                }
                else
                {
                    Print("unknown mode: %s\n",
                        str);
                    PrintHelp();
                    return 1;
                }
                env->ReleaseStringUTFChars(mode, str);
            }
        }

        jstring workload = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("workload"));
        if (workload)
        {
            const char *str = env->GetStringUTFChars(workload, 0);
            if (str)
            {
                if (strcasecmp(str, "shader") == 0)
                {
                    globals.workload = GW_SHADER;
                }
                else if (strcasecmp(str, "texture") == 0)
                {
                    globals.workload = GW_TEXTURE;
                }
                else if (strcasecmp(str, "blend") == 0)
                {
                    globals.workload = GW_BLEND;
                }
                else if (strcasecmp(str, "multiobjects") == 0)
                {
                    globals.workload = GW_MULTIOBJECTS;
                    globals.objcount = 2;
                }
                else if (strcasecmp(str, "instance") == 0)
                {
                    globals.workload = GW_INSTANCE;
                }
                else if (strcasecmp(str, "compute") == 0)
                {
                    globals.workload = GW_COMPUTE;
                }
                else
                {
                    Print("unknown workload: %s\n", str);
                    PrintHelp();
                    return 1;
                }
                env->ReleaseStringUTFChars(workload, str);
            }
        }

        jstring gles = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("gles"));
        if (gles)
        {
            const char *str = env->GetStringUTFChars(gles, 0);
            if (str)
            {
                g_glversion = atoi(str);
                if (g_glversion != NVPM_GL_PRECISION_SHADER_VERSION
                    && g_glversion != NVPM_GL_INSTANCE_SHADER_VERSION
                    && g_glversion != NVPM_GL_COMPUTE_SHADER_VERSION)
                {
                    Print("gl version should be %d, %d or %d\n", NVPM_GL_PRECISION_SHADER_VERSION, NVPM_GL_INSTANCE_SHADER_VERSION, NVPM_GL_COMPUTE_SHADER_VERSION);
                    PrintHelp();
                    return 1;
                }
                env->ReleaseStringUTFChars(gles, str);
            }
        }

        jstring outfile = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("outfile"));
        if (outfile)
        {
            const char *str = env->GetStringUTFChars(outfile, 0);
            if (str)
            {
                FILE* file = fopen(str, "w+");
                if (!file)
                {
                    Print("Cannot open %s for writing.\n", str);
                    PrintHelp();
                    return 1;
                }
                globals.pfh = file;
                env->ReleaseStringUTFChars(outfile, str);
            }
        }

        jstring frame = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("frame"));
        if (frame)
        {
            const char *str = env->GetStringUTFChars(frame, 0);
            if (str)
            {
                globals.framestart = atoi(str);
                env->ReleaseStringUTFChars(frame, str);
            }
        }

        jstring framecount = (jstring) env->CallObjectMethod(intent, gseid, env->NewStringUTF("frame-count"));
        if (framecount)
        {
            const char *str = env->GetStringUTFChars(framecount, 0);
            if (str)
            {
                globals.framecount = atoi(str);
                env->ReleaseStringUTFChars(framecount, str);
            }
        }
    }
    pDroidApp->activity->vm->DetachCurrentThread();

    if (globals.workload == GW_INSTANCE && g_glversion < NVPM_GL_INSTANCE_SHADER_VERSION)
    {
        Print("instance workload should use gl version %d above\n", NVPM_GL_INSTANCE_SHADER_VERSION);
        PrintHelp();
        return 1;
    }

    if (globals.workload == GW_COMPUTE && g_glversion < NVPM_GL_COMPUTE_SHADER_VERSION)
    {
        Print("compute workload should use gl version %d above\n", NVPM_GL_COMPUTE_SHADER_VERSION);
        PrintHelp();
        return 1;
    }

    return 0;
}

// ===========================================================================
// Print() - all printed messages go through here (makes it easy to disable)
// ===========================================================================

void Print(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    __android_log_vprint(ANDROID_LOG_INFO, "NvPmSample", fmt, ap);
    va_end(ap);
}

// =============================================================================
// NvPmApiInit() - load and initialize NvPmApi
// =============================================================================

bool NvPmApiInit()
{
    // NVPMINSTRUMENT
    // This code use the NvPmApiManager to load libNvPmApi.Core.so and query
    // the export table.
    NVPMCHECKEXIT(s_NvPmApiManager.Construct(L"libNvPmApi.Core.so"));

    // NVPMINSTRUMENT
    // Call NVPMInit once to initialize the library. If NVPMInit is called more
    // than once then the call will return NVPM_ERROR_ALREADY_INITIALIZED. Until
    // NVPMInit is called all other NVPMAPI calls will return
    // NVPM_ERROR_NOT_INITIALIZED.
    NVPMCHECKEXIT(s_NvPmApiManager.Api()->Init());

    return true;
}

// =============================================================================
// NvPmApiShutdown() - destroy all NvPmApi contexts and shut down NvPmApi
// =============================================================================

bool NvPmApiShutdown()
{
    if (!s_NvPmApiManager.Api())
    {
        return false;
    }

    // NVPMINSTRUMENT
    // Call NVPMShutdown to release device contexts.
    NVPMCHECKEXIT(s_NvPmApiManager.Api()->Shutdown());

    return true;
}

// =============================================================================
// NvPmApiCreateContext() - create a NvPmApi context for the OpenGL Context
// =============================================================================

bool NvPmApiCreateContext(APIContextHandle oglContext)
{
    // NVPMINSTRUMENT
    // Create a NVPMContext from a OpenGL or OpenGL context. The OpenGL
    // rendering context must be the thread's current rendering context.
    NVPMContext nvpmContext = 0;
    NVPMCHECKEXIT(s_NvPmApiManager.Api()->CreateContextFromOGLContext(oglContext, &globals.nvpmContext));

    return true;
}

// =============================================================================
// NvPmApiDestroyContext() - destroy a NvPmApi context for the OpenGL Context
// =============================================================================

bool NvPmApiDestroyContext()
{
    // NVPMINSTRUMENT
    // Destroy a NVPMContext for the OpenGL or OpenGL context. The OpenGL
    // rendering context must be the thread's current rendering context. All
    // NVPMAPI resources allocated for the context will be destroyed.
    NVPMCHECK(s_NvPmApiManager.Api()->DestroyContext(globals.nvpmContext), false);

    return true;
}

// =============================================================================
// LoadShader() - load 1 OpenGL shader
// =============================================================================

static void LoadShader(unsigned int sObj, const char *src, int srcLen)
{
    const char * source[1];
    int length[1];
    int compileStatus;

    source[0] = src;
    length[0] = srcLen;
    glShaderSource(sObj, (sizeof(length)/sizeof((length)[0])), source, length);
    glCompileShader(sObj);
    glGetShaderiv(sObj, GL_COMPILE_STATUS, &compileStatus);

    if (compileStatus != 1)
    {
        int infoLogLength, out;
        char *infoLog;

        glGetShaderiv(sObj, GL_INFO_LOG_LENGTH, &infoLogLength);
        infoLog = (char*)malloc(infoLogLength + 1);
        memset(infoLog, 0, infoLogLength + 1);
        glGetShaderInfoLog(sObj, infoLogLength, &out, infoLog);
        Print(">>>>>\n");
        Print(">>>>> Shader compilation failed!\n");
        Print(">>>>>\n");
        Print("%s\n", infoLog);
        free(infoLog);
    }
}

// =============================================================================
// InitGraphicsState() - initialize OpenGL state
// =============================================================================

static int InitGraphicsState(GraphicsInfo& info)
{
    glClearColor(0.2f, 0.4f, 0.8f, 1.0f);

    typedef void (* FPNGLCLEARDEPTHF)(GLfloat d);
    FPNGLCLEARDEPTHF glClearDepthfPtr = (FPNGLCLEARDEPTHF)GetGLProcAddress("glClearDepthf");
    CHECK(!glClearDepthfPtr, 1, "%s not supported!", "glClearDepthf");

    glClearDepthfPtr(1.0f);

    glDepthFunc(GL_LESS);
    glEnable(GL_DEPTH_TEST);

    // Init the VA
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(GLfloat), vert);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_TRUE, 8 * sizeof(GLfloat), vert + 3);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_TRUE, 8 * sizeof(GLfloat), vert + 6);
    glEnableVertexAttribArray(2);

    // Init program
    GLuint vsObj, fsObj;
    fsObj = glCreateShader(GL_FRAGMENT_SHADER);
    vsObj = glCreateShader(GL_VERTEX_SHADER);
    if (globals.workload == GW_INSTANCE)
    {
        strcat(vertexShaderInstanceSource,vertexShaderInstanceBody);
        LoadShader(vsObj, vertexShaderInstanceSource, sizeof(vertexShaderInstanceSource));
    }
    else
    {
        LoadShader(vsObj, vertexShaderSource, sizeof(vertexShaderSource));
    }
    LoadShader(fsObj, fragmentShaderSource, sizeof(fragmentShaderSource));
    info.graphicsProgram = glCreateProgram();
    glAttachShader(info.graphicsProgram, vsObj);
    glAttachShader(info.graphicsProgram, fsObj);
    glBindAttribLocation(info.graphicsProgram, 0, "position");
    glBindAttribLocation(info.graphicsProgram, 1, "normal");
    glBindAttribLocation(info.graphicsProgram, 2, "texcoord");
    glLinkProgram(info.graphicsProgram);
    info.graphicsSampler = glGetUniformLocation(info.graphicsProgram, "tex");
    info.graphicsOffset = glGetUniformLocation(info.graphicsProgram, "offset");

    // Init texture
    glGenTextures(1, &info.graphicsTex);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, info.graphicsTex);
    GLuint width = 1024;
    GLuint height = 1024;
    GLubyte* pByte = new GLubyte[width * height * 4];

    typedef void (* FPNGLTEXSTORAGE2D)(GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
    FPNGLTEXSTORAGE2D glTexStorage2DPtr = (FPNGLTEXSTORAGE2D)GetGLProcAddress("glTexStorage2D");

    for (size_t i = 0; i < height; ++i)
    {
        bool y = ((i / 32) % 2) == 0;
        for (size_t j = 0; j < width; ++j)
        {
            bool x = ((j / 32) % 2) == 0;
            pByte[4 * width * i + 4 * j + 0] = (x == y) ? 255 : 0;
            pByte[4 * width * i + 4 * j + 1] = (x == y) ? 255 : 0;
            pByte[4 * width * i + 4 * j + 2] = (x == y) ? 255 : 0;
            pByte[4 * width * i + 4 * j + 3] = 128;
        }
    }
    if (globals.workload == GW_COMPUTE)
    {
        CHECK(!glTexStorage2DPtr, 1, "%s not supported!", "glTexStorage2D");
        glTexStorage2DPtr(GL_TEXTURE_2D, 1, GL_RGBA8, width, height);
    }
    else
    {
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pByte);
    }
    delete []pByte;
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    if (globals.workload == GW_COMPUTE)
    {
        typedef void (* FPNGLBINDIMAGETEXTURE)(GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
        FPNGLBINDIMAGETEXTURE glBindImageTexturePtr = (FPNGLBINDIMAGETEXTURE)GetGLProcAddress("glBindImageTexture");
        CHECK(!glBindImageTexturePtr, 1, "%s not supported!", "glBindImageTexture");

        glDispatchComputePtr = (FPNGLDISPATCHCOMPUTE)GetGLProcAddress("glDispatchCompute");
        CHECK(!glDispatchComputePtr, 1, "%s not supported!", "glDispatchCompute");

        // compute program
        GLuint csObj = glCreateShader(GL_COMPUTE_SHADER);
        strcat(computeShaderSource,computeShaderBody);
        LoadShader(csObj, computeShaderSource, sizeof(computeShaderSource));
        info.computeProgram = glCreateProgram();
        glAttachShader(info.computeProgram, csObj);
        glLinkProgram(info.computeProgram);

        glBindImageTexturePtr(0, info.graphicsTex, 0, GL_FALSE, 0, GL_READ_ONLY, GL_RGBA8);

        GLuint outTex;
        glGenTextures(1, &outTex);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, outTex);
        CHECK(!glTexStorage2DPtr, 1, "%s not supported!", "glTexStorage2D");

        glTexStorage2DPtr(GL_TEXTURE_2D, 1, GL_RGBA8, width, height);
        glBindImageTexturePtr(1, outTex, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA8);
    }

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunShaderWorkload() - profile shader workload
// =============================================================================

static int RunShaderWorkload(GraphicsInfo& info)
{
    glUseProgram(info.graphicsProgram);
    glUniform1i(info.graphicsSampler, 0);

    MODE_WORK_BEGIN();
    glDrawArrays(GL_TRIANGLES, 0, 36);
    MODE_WORK_END();

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunTextureWorkload() - profile texture workload
// =============================================================================

static int RunTextureWorkload(GraphicsInfo& info)
{
    const int k_indexCount = 36;
    static GLushort indices[k_indexCount];
    static bool mipmap = false;
    if (!mipmap)
    {
        glGenerateMipmap(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, info.graphicsTex);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        mipmap = true;

        for (int i = 0; i < k_indexCount; ++i)
        {
            indices[i] = i;
        }
    }

    glUseProgram(info.graphicsProgram);
    glUniform1i(info.graphicsSampler, 0);

    MODE_WORK_BEGIN();
    glDrawElements(GL_TRIANGLES, k_indexCount, GL_UNSIGNED_SHORT, indices);
    MODE_WORK_END();

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunBlendWorkload() - profile blend workload
// =============================================================================

static int RunBlendWorkload(GraphicsInfo& info)
{
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    const int k_indexCount = 36;
    static GLushort indices[k_indexCount];
    static bool mipmap = false;
    if (!mipmap)
    {
        glGenerateMipmap(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, info.graphicsTex);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        mipmap = true;

        for (int i = 0; i < k_indexCount; ++i)
        {
            indices[i] = i;
        }
    }

    glUseProgram(info.graphicsProgram);
    glUniform1i(info.graphicsSampler, 0);

    MODE_WORK_BEGIN();
    glDrawRangeElements(GL_TRIANGLES, 0, k_indexCount - 1, k_indexCount, GL_UNSIGNED_SHORT, indices);
    MODE_WORK_END();

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunMultiObjectsWorkload() - profile draw multi objects workload
// =============================================================================

static int RunMultiObjectsWorkload(GraphicsInfo& info)
{
    glUseProgram(info.graphicsProgram);
    glUniform1i(info.graphicsSampler, 0);

    //draw multi objects
    for (int i = 0; i < globals.objcount; ++i)
    {
        MODE_WORK_BEGIN();
        if (i & 0x01)
        {
            glDrawArrays(GL_TRIANGLES, 0, 18);
        }
        else
        {
            glDrawArrays(GL_LINE_LOOP, 18, 18);
        }

        MODE_WORK_END();
    }

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunInstanceWorkload() - profile instance workload
// =============================================================================

static int RunInstanceWorkload(GraphicsInfo& info)
{
    const int k_indexCount = 36;
    static GLushort indices[k_indexCount];
    static bool initIndex = false;
    if (!initIndex)
    {
        initIndex = true;

        for (int i = 0; i < k_indexCount; ++i)
        {
            indices[i] = i;
        }
    }

    glUseProgram(info.graphicsProgram);
    glUniform1i(info.graphicsSampler, 0);

    static float m[5][3] = {
        { 0.0f,  0.0f, 0.0f},
        {-2.0f,  2.0f, 0.0f},
        {-2.0f, -2.0f, 0.0f},
        { 2.0f, -2.0f, 0.0f},
        { 2.0f,  2.0f, 0.0f}};
    glUniform3fv(info.graphicsOffset, 5, &m[0][0]);

    typedef void (* FPNGLDRAWARRAYSINSTANCED)(GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
    FPNGLDRAWARRAYSINSTANCED glDrawArraysInstancedPtr = (FPNGLDRAWARRAYSINSTANCED)GetGLProcAddress("glDrawArraysInstanced");
    CHECK(!glDrawArraysInstancedPtr, 1, "%s not supported!", "glDrawArraysInstanced");

    MODE_WORK_BEGIN();

    glDrawArraysInstancedPtr(GL_TRIANGLES, 0, k_indexCount, 5);
    MODE_WORK_END();

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// RunComputeWorkload() - profile compute workload
// =============================================================================

static int RunComputeWorkload(GraphicsInfo& info)
{
    glUseProgram(info.computeProgram);

    MODE_WORK_BEGIN();
    glDispatchComputePtr(512 / 16, 512 / 16, 1);
    MODE_WORK_END();

    if (CHECKGLERRORS())
    {
        return 1;
    }

    return 0;
}

// =============================================================================
// Render() - draw one frame
// =============================================================================

static int Render(GraphicsInfo& info)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    if (CHECKGLERRORS())
    {
        return 1;
    }

    switch (globals.workload)
    {
        case GW_SHADER:
            RunShaderWorkload(info);
            break;
        case GW_TEXTURE:
            RunTextureWorkload(info);
            break;
        case GW_BLEND:
            RunBlendWorkload(info);
            break;
        case GW_MULTIOBJECTS:
            RunMultiObjectsWorkload(info);
            break;
        case GW_INSTANCE:
            RunInstanceWorkload(info);
            break;
        case GW_COMPUTE:
            RunComputeWorkload(info);
            break;
        default:
            break;
    }

    SwapBuffers(globals.winInfo);
    if (CHECKGLERRORS())
    {
        return 1;
    }
    return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
bool Initialize(android_app* pDroidApp)
{
    int status = 0;

    globals.winInfo.nativeWindow = pDroidApp->window;

    status = ParseCommandLine(pDroidApp);
    CHECK(status != 0, false, "Error: %s", "Passing commandline");

    status = WinSysInitialize(globals.winInfo);
    CHECK(status != 0, false, "Error: %s", "Initializing win sys");

    status = InitGraphicsState(globals.graphicsInfo);
    CHECK(status != 0, false, "Error: %s", "InitGraphicsState");

    CHECK(!NvPmApiInit(), false, "Error: %s", "NvPmApi init");
    CHECK(!NvPmApiCreateContext(GetCurrentContext()), false, "Error: %s", "NvPmApiCreateContext");

    MODE_INIT();
    Print("NvPmSample initialized successfully ............");
    return true;
}

void Shutdown()
{
    if (globals.bInitialized)
    {
        globals.bInitialized = false;
        WinSysTerminate(globals.winInfo);
        NvPmApiDestroyContext();
        NvPmApiShutdown();
        if (globals.pfh)
        {
            fclose(globals.pfh);
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
void HandleAndroidCommand(android_app* pDroidApp, int32_t cmd)
{
    switch (cmd)
    {
    case APP_CMD_INIT_WINDOW:
        if (!globals.bInitialized)
        {
            globals.bInitialized = Initialize(pDroidApp);
        }
        break;

    case APP_CMD_TERM_WINDOW:
        {
            Shutdown();
        }
        break;
    }
}

// =============================================================================
// android_main() - Program starts here
// =============================================================================

void android_main(android_app* pDroidApp)
{
    // Needed so the glue code doesn't get stripped.
    app_dummy();

    pDroidApp->onAppCmd = HandleAndroidCommand;

    for (;;)
    {
        int ident;
        int fileDesc;
        int events;
        android_poll_source* pSource = NULL;

        while ((ident = ALooper_pollAll(0, &fileDesc, &events, (void**)&pSource)) >= 0)
        {
            if (pSource)
            {
                pSource->process(pDroidApp, pSource);
            }

            if (pDroidApp->destroyRequested)
            {
                Shutdown();
                // Stop the process
                exit(0);
            }
        }

        if (globals.bInitialized)
        {
            MODE_FRAME_BEGIN();
            Render(globals.graphicsInfo);
            MODE_FRAME_END();

            // Stop the activity if all the required frames complete
            if (globals.mode.IsComplete(&globals.mode))
            {
                Shutdown();
                // Stop the process
                exit(0);
            }
        }
    }
}


