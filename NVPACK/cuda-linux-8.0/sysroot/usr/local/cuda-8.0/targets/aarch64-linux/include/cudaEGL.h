/*
 * Copyright 2014 NVIDIA Corporation.  All rights reserved.
 *
 * NOTICE TO LICENSEE:
 *
 * This source code and/or documentation ("Licensed Deliverables") are
 * subject to NVIDIA intellectual property rights under U.S. and
 * international Copyright laws.
 *
 * These Licensed Deliverables contained herein is PROPRIETARY and
 * CONFIDENTIAL to NVIDIA and is being provided under the terms and
 * conditions of a form of NVIDIA software license agreement by and
 * between NVIDIA and Licensee ("License Agreement") or electronically
 * accepted by Licensee.  Notwithstanding any terms or conditions to
 * the contrary in the License Agreement, reproduction or disclosure
 * of the Licensed Deliverables to any third party without the express
 * written consent of NVIDIA is prohibited.
 *
 * NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
 * LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
 * SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  IT IS
 * PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.
 * NVIDIA DISCLAIMS ALL WARRANTIES WITH REGARD TO THESE LICENSED
 * DELIVERABLES, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY,
 * NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
 * NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
 * LICENSE AGREEMENT, IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY
 * SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
 * DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
 * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
 * OF THESE LICENSED DELIVERABLES.
 *
 * U.S. Government End Users.  These Licensed Deliverables are a
 * "commercial item" as that term is defined at 48 C.F.R. 2.101 (OCT
 * 1995), consisting of "commercial computer software" and "commercial
 * computer software documentation" as such terms are used in 48
 * C.F.R. 12.212 (SEPT 1995) and is provided to the U.S. Government
 * only as a commercial end item.  Consistent with 48 C.F.R.12.212 and
 * 48 C.F.R. 227.7202-1 through 227.7202-4 (JUNE 1995), all
 * U.S. Government End Users acquire the Licensed Deliverables with
 * only those rights set forth herein.
 *
 * Any use of the Licensed Deliverables in individual and commercial
 * software must include, in the user documentation and internal
 * comments to the code, the above Disclaimer and U.S. Government End
 * Users Notice.
 */

#ifndef CUDAEGL_H
#define CUDAEGL_H

/**
 * CUDA API versioning support
 */

#include "cuda.h"
#include "EGL/egl.h"
#include "EGL/eglext.h"


#if defined(CUDA_FORCE_API_VERSION)
    #if (CUDA_FORCE_API_VERSION == 3010)
        #define __CUDA_API_VERSION 3010
    #else
        #error "Unsupported value of CUDA_FORCE_API_VERSION"
    #endif
#else
    #define __CUDA_API_VERSION 6050
#endif /* CUDA_FORCE_API_VERSION */

#ifdef __cplusplus
extern "C" {
#endif

#if __CUDA_API_VERSION >= 6050

/**
  * \addtogroup CUDA_TYPES
  * @{
  */

/**
 * Maximum number of planes per frame
 */
#define MAX_PLANES 3

/**
  * CUDA EglFrame type - array or pointer
  */
typedef enum CUeglFrameType_enum {
    CU_EGL_FRAME_TYPE_ARRAY = 0,  /**< Frame type CUDA array */
    CU_EGL_FRAME_TYPE_PITCH = 1,  /**< Frame type pointer */
} CUeglFrameType;

/**
  * Resource location flags- sysmem or vidmem
  * If the producer is on sysmem and CU_EGL_RESOURCE_LOCATION_VIDMEM is set, it will involve
  * additional copy of the resource from sysmem to vidmem.
  */
typedef enum CUeglResourceLocationFlags_enum {
    CU_EGL_RESOURCE_LOCATION_SYSMEM   = 0x00,       /**< Resource location sysmem */
    CU_EGL_RESOURCE_LOCATION_VIDMEM   = 0x01        /**< Resource location vidmem */
} CUeglResourceLocationFlags;

/**
  * CUDA EGL Color Format - The different planar and multiplanar formats currently supported for CUDA_EGL interops.
  */
typedef enum CUeglColorFormat_enum {
    CU_EGL_COLOR_FORMAT_YUV420_PLANAR       = 0x00,   /**< Y, U, V in three surfaces, each in a separate surface, U/V width = 1/2 Y width, U/V height = 1/2 Y height. */
    CU_EGL_COLOR_FORMAT_YUV420_SEMIPLANAR   = 0x01,   /**< Y, UV in two surfaces (UV as one surface), width, height ratio same as YUV420Planar. */
    CU_EGL_COLOR_FORMAT_YUV422_PLANAR       = 0x02,  /**< Y, U, V  each in a separate  surface, U/V width = 1/2 Y width, U/V height = Y height. */
    CU_EGL_COLOR_FORMAT_YUV422_SEMIPLANAR   = 0x03,  /**< Y, UV in two surfaces, width, height ratio same as YUV422Planar. */
    CU_EGL_COLOR_FORMAT_RGB                 = 0x04,  /**< R/G/B three channels in one surface with RGB byte ordering. */
    CU_EGL_COLOR_FORMAT_BGR                 = 0x05,  /**< R/G/B three channels in one surface with BGR byte ordering. */
    CU_EGL_COLOR_FORMAT_ARGB                = 0x06,  /**< R/G/B/A four channels in one surface with ARGB byte ordering. */
    CU_EGL_COLOR_FORMAT_RGBA                = 0x07,  /**< R/G/B/A four channels in one surface with RGBA byte ordering. */
    CU_EGL_COLOR_FORMAT_L                   = 0x08,  /**< single luminance channel in one surface. */
    CU_EGL_COLOR_FORMAT_R                   = 0x09,  /**< single color channel in one surface. */
} CUeglColorFormat;

/**
 * CUDA EGLFrame structure Descriptor - structure defining one frame of EGL.
 *
 * Each frame may contain one or more planes depending on whether the surface  * is Multiplanar or not.
 */
typedef struct CUeglFrame_st {
    union {
        CUarray pArray[MAX_PLANES];     /**< Array of CUarray corresponding to each plane*/
        void*   pPitch[MAX_PLANES];     /**< Array of Pointers corresponding to each plane*/
    } frame;
    unsigned int width;                 /**< Width of first plane */
    unsigned int height;                /**< Height of first plane */
    unsigned int depth;                 /**< Depth of first plane */
    unsigned int pitch;                 /**< Pitch of first plane */
    unsigned int planeCount;            /**< Number of planes */
    unsigned int numChannels;           /**< Number of channels for the plane */
    CUeglFrameType frameType;           /**< Array or Pitch */
    CUeglColorFormat eglColorFormat;    /**< CUDA EGL Color Format*/
    CUarray_format cuFormat;            /**< CUDA Array Format*/
} CUeglFrame;

/**
  * CUDA EGLSream Connection
  */
typedef struct CUeglStreamConnection_st* CUeglStreamConnection;

/** @} */ /* END CUDA_TYPES */

/**
 * \file cudaEGL.h
 * \brief Header file for the EGL interoperability functions of the
 * low-level CUDA driver application programming interface.
 */

/**
 * \defgroup CUDA_EGL EGL Interoperability
 * \ingroup CUDA_DRIVER
 *
 * ___MANBRIEF___ EGL interoperability functions of the low-level CUDA
 * driver API (___CURRENT_FILE___) ___ENDMANBRIEF___
 *
 * This section describes the EGL interoperability functions of the
 * low-level CUDA driver application programming interface.
 *
 * @{
 */

/**
 * \brief Registers an EGL image
 *
 * Registers the EGLImageKHR specified by \p image for access by
 * CUDA. A handle to the registered object is returned as \p pCudaResource.
 * Additional Mapping/Unmapping is not required for the registered resource and
 * ::cuGraphicsResourceGetMappedEglFrame can be directly called on the \p pCudaResource.
 *
 * The application will be responsible for synchronizing access to shared objects.
 * The application must ensure that any pending operation which access the objects have completed
 * before passing control to CUDA. This may be accomplished by issuing and waiting for
 * glFinish command on all GLcontexts (for OpenGL and likewise for other APIs).
 * The application will be also responsible for ensuring that any pending operation on the
 * registered CUDA resource has completed prior to executing subsequent commands in other APIs
 * accesing the same memory objects.
 * This can be accomplished by calling cuCtxSynchronize or cuEventSynchronize (preferably).
 *
 * The surface's intended usage is specified using \p flags, as follows:
 *
 * - ::CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE: Specifies no hints about how this
 *   resource will be used. It is therefore assumed that this resource will be
 *   read from and written to by CUDA. This is the default value.
 * - ::CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY: Specifies that CUDA
 *   will not write to this resource.
 * - ::CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD: Specifies that
 *   CUDA will not read from this resource and will write over the
 *   entire contents of the resource, so none of the data previously
 *   stored in the resource will be preserved.
 *
 * The EGLImageKHR is an object which can be used to create EGLImage target resource. It is defined as a void pointer.
 * typedef void* EGLImageKHR
 *
 * \param pCudaResource   - Pointer to the returned object handle
 * \param image           - An EGLImageKHR image which can be used to create target resource.
 * \param flags           - Map flags
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_ALREADY_MAPPED,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuGraphicsEGLRegisterImage, ::cuGraphicsUnregisterResource,
 * ::cuGraphicsResourceSetMapFlags, ::cuGraphicsMapResources,
 * ::cuGraphicsUnmapResources
 */
CUresult CUDAAPI cuGraphicsEGLRegisterImage(CUgraphicsResource *pCudaResource, EGLImageKHR image, unsigned int flags);

/**
 * \brief Connect CUDA to EGLStream as a consumer.
 *
 * Connect CUDA as a consumer to EGLStreamKHR specified by \p stream.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.
 *
 * \param conn            - Pointer to the returned connection handle
 * \param stream          - EGLStreamKHR handle
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuEGLStreamConsumerConnect, ::cuEGLStreamConsumerDisconnect,
 * ::cuEGLStreamConsumerAcquireFrame, ::cuEGLStreamConsumerReleaseFrame
 */
CUresult CUDAAPI cuEGLStreamConsumerConnect(CUeglStreamConnection *conn, EGLStreamKHR stream);

/**
 * \brief Connect CUDA to EGLStream as a consumer with given flags.
 *
 * Connect CUDA as a consumer to EGLStreamKHR specified by \p stream with specified \p flags.
 *
 * The flags specify whether the consumer will be on system or video memory.
 * By default the consumer is on vidmem.
 * For applications having producer running on system and consumer running on video,
 * internal copies will be involved to move data from system to video memory.
 * API to another.
 * The surfaces's intented location is specified using \p flags, as follows:
 *
 * - ::CU_EGL_RESOURCE_LOCATION_SYSMEM:  Resource location sysmem.
 * - ::CU_EGL_RESOURCE_LOCATION_VIDMEM:  Resource location vidmem.
 *
 * \param conn              - Pointer to the returned connection handle
 * \param stream            - EGLStreamKHR handle
 * \param flags             - Flags denote intended location - system or video.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuEGLStreamConsumerConnect, ::cuEGLStreamConsumerDisconnect,
 * ::cuEGLStreamConsumerAcquireFrame, ::cuEGLStreamConsumerReleaseFrame
 */

CUresult CUDAAPI cuEGLStreamConsumerConnectWithFlags(CUeglStreamConnection *conn, EGLStreamKHR stream, unsigned int flags);

/**
 * \brief Disconnect CUDA as a consumer to EGLStream .
 *
 * Disconnect CUDA as a consumer to EGLStreamKHR.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.

 * \param conn            - Conection to disconnect.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuEGLStreamConsumerConnect, ::cuEGLStreamConsumerDisconnect,
 * ::cuEGLStreamConsumerAcquireFrame, ::cuEGLStreamConsumerReleaseFrame
 */
CUresult CUDAAPI cuEGLStreamConsumerDisconnect(CUeglStreamConnection *conn);

/**
 * \brief Acquire an image frame from the EGLStream with CUDA as a consumer.
 *
 * Acquire an image frame from EGLStreamKHR.
 * ::cuGraphicsResourceGetMappedEglFrame can be called on \p pCudaResource to get
 * ::CUeglFrame.
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.
 *
 * \param conn            - Connection on which to acquire
 * \param pCudaResource   - CUDA resource on which the stream frame will be mapped for use.
 * \param pStream         - CUDA stream on which acquire will be done.
 * \param timeout         - Desired timeout in usec.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 *
 * \sa ::cuEGLStreamConsumerConnect, ::cuEGLStreamConsumerDisconnect,
 * ::cuEGLStreamConsumerAcquireFrame, ::cuEGLStreamConsumerReleaseFrame
 */
CUresult CUDAAPI cuEGLStreamConsumerAcquireFrame(CUeglStreamConnection *conn,
                                                  CUgraphicsResource *pCudaResource, CUstream *pStream, unsigned int timeout);
/**
 * \brief Releases the last frame acquired from the EGLStream.
 *
 * Release the acquired image frame specified by \p pCudaResource to EGLStreamKHR.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.
 *
 * \param conn            - Connection on which to release
 * \param pCudaResource   - CUDA resource whose corresponding frame is to be released
 * \param pStream         - CUDA stream on which release will be done.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 *
 * \sa ::cuEGLStreamConsumerConnect, ::cuEGLStreamConsumerDisconnect,
 * ::cuEGLStreamConsumerAcquireFrame, ::cuEGLStreamConsumerReleaseFrame
 */
CUresult CUDAAPI cuEGLStreamConsumerReleaseFrame(CUeglStreamConnection *conn,
                                                  CUgraphicsResource pCudaResource, CUstream *pStream);

/**
 * \brief Connect CUDA to EGLStream as a producer.
 *
 * Connect CUDA as a producer to EGLStreamKHR specified by \p stream.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.
 *
 * \param conn   - Pointer to the returned connection handle
 * \param stream - EGLStreamKHR handle
 * \param width  - width of the image to be submitted to the stream
 * \param height - height of the image to be submitted to the stream
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuEGLStreamProducerConnect, ::cuEGLStreamProducerDisconnect,
 * ::cuEGLStreamProducerPresentFrame
 */
CUresult CUDAAPI cuEGLStreamProducerConnect(CUeglStreamConnection *conn, EGLStreamKHR stream,
                                             EGLint width, EGLint height);

/**
 * \brief Disconnect CUDA as a producer  to EGLStream .
 *
 * Disconnect CUDA as a producer to EGLStreamKHR.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.

 * \param conn            - Conection to disconnect.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 *
 * \sa ::cuEGLStreamProducerConnect, ::cuEGLStreamProducerDisconnect,
 * ::cuEGLStreamProducerPresentFrame
 */
CUresult CUDAAPI cuEGLStreamProducerDisconnect(CUeglStreamConnection *conn);

/**
 * \brief Present a CUDA eglFrame to the EGLStream with CUDA as a producer.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.

 * The ::CUeglFrame is defined as:
 * \code
 * typedef struct CUeglFrame_st {
 *     union {
 *         CUarray pArray[MAX_PLANES];
 *         void*   pPitch[MAX_PLANES];
 *     } frame;
 *     unsigned int width;
 *     unsigned int height;
 *     unsigned int depth;
 *     unsigned int pitch;
 *     unsigned int planeCount;
 *     unsigned int numChannels;
 *     CUeglFrameType frameType;
 *     CUeglColorFormat eglColorFormat;
 *     CUarray_format cuFormat;
 * } CUeglFrame;
 * \endcode
 *
 * \param conn            - Connection on which to present the CUDA array
 * \param eglframe        - CUDA Eglstream Proucer Frame handle to be sent to the consumer over EglStream.
 * \param pStream         - CUDA stream on which to present the frame.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 *
 * \sa ::cuEGLStreamProducerConnect, ::cuEGLStreamProducerDisconnect,
 * ::cuEGLStreamProducerReturnFrame
 */
CUresult CUDAAPI cuEGLStreamProducerPresentFrame(CUeglStreamConnection *conn,
                                                 CUeglFrame eglframe, CUstream *pStream);

/**
 * \brief Return the CUDA eglFrame to the EGLStream released by the consumer.
 *
 * The EGLStreamKHR is an EGL object that transfers a sequence of image frames from one
 * API to another.
 *
 * \param conn            - Connection on which to return
 * \param eglframe        - CUDA Eglstream Proucer Frame handle returned from the consumer over EglStream.
 * \param pStream         - CUDA stream on which to return the frame.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_INVALID_HANDLE,
 *
 * \sa ::cuEGLStreamProducerConnect, ::cuEGLStreamProducerDisconnect,
 * ::cuEGLStreamProducerPresentFrame
 */
CUresult CUDAAPI cuEGLStreamProducerReturnFrame(CUeglStreamConnection *conn,
                                                CUeglFrame *eglframe, CUstream *pStream);

/**
 * \brief Get an eglFrame through which to access a registered EGL graphics resource.
 *
 * Returns in \p *eglFrame an eglFrame pointer through which the registered graphics resource
 * \p resource may be accessed.
 * This API can only be called for EGL graphics resources.
 *
 * The ::CUeglFrame is defined as:
 * \code
 * typedef struct CUeglFrame_st {
 *     union {
 *         CUarray pArray[MAX_PLANES];
 *         void*   pPitch[MAX_PLANES];
 *     } frame;
 *     unsigned int width;
 *     unsigned int height;
 *     unsigned int depth;
 *     unsigned int pitch;
 *     unsigned int planeCount;
 *     unsigned int numChannels;
 *     CUeglFrameType frameType;
 *     CUeglColorFormat eglColorFormat;
 *     CUarray_format cuFormat;
 * } CUeglFrame;
 * \endcode
 *
 * If \p resource is not registered then ::CUDA_ERROR_NOT_MAPPED is returned.
 * *
 * \param eglFrame   - Returned eglFrame.
 * \param resource   - Registered resource to access.
 * \param index      - Index for cubemap surfaces.
 * \param mipLevel   - Mipmap level for the subresource to access.
 *
 * \return
 * ::CUDA_SUCCESS,
 * ::CUDA_ERROR_DEINITIALIZED,
 * ::CUDA_ERROR_NOT_INITIALIZED,
 * ::CUDA_ERROR_INVALID_CONTEXT,
 * ::CUDA_ERROR_INVALID_VALUE,
 * ::CUDA_ERROR_INVALID_HANDLE,
 * ::CUDA_ERROR_NOT_MAPPED
 *
 * \sa
 * ::cuGraphicsMapResources,
 * ::cuGraphicsSubResourceGetMappedArray,
 * ::cuGraphicsResourceGetMappedPointer
 */
CUresult CUDAAPI cuGraphicsResourceGetMappedEglFrame(CUeglFrame* eglFrame, CUgraphicsResource resource, unsigned int index, unsigned int mipLevel);

#endif

/** @} */ /* END CUDA_EGL */

#ifdef __cplusplus
};
#endif

#undef __CUDA_API_VERSION

#endif

