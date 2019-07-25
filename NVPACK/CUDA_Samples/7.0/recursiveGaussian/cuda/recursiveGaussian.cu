/*
 * Copyright 1993-2014 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 *
 */

/*
    Recursive Gaussian filter
    sgreen 8/1/08

    This code sample implements a Gaussian blur using Deriche's recursive method:
    http://citeseer.ist.psu.edu/deriche93recursively.html

    This is similar to the box filter sample in the SDK, but it uses the previous
    outputs of the filter as well as the previous inputs. This is also known as an
    IIR (infinite impulse response) filter, since its response to an input impulse
    can last forever.

    The main advantage of this method is that the execution time is independent of
    the filter width.

    The GPU processes columns of the image in parallel. To avoid uncoalesced reads
    for the row pass we transpose the image and then transpose it back again
    afterwards.

    The implementation is based on code from the CImg library:
    http://cimg.sourceforge.net/
    Thanks to David Tschumperl� and all the CImg contributors!
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "recursiveGaussian.h"
#include "helper_math.h"

#include <android/log.h>

#define APP_NAME "CUDA_CORE"

#define LOGD(...) ((void)__android_log_print(ANDROID_LOG_DEBUG,  \
                                             APP_NAME, \
                                             __VA_ARGS__))
#define USE_SIMPLE_FILTER 0
#define BLOCK_DIM 16
#define CLAMP_TO_EDGE 1

#define checkCudaErrors(err)           __checkCudaErrors (err, __FILE__, __LINE__)

inline void __checkCudaErrors(cudaError err, const char *file, const int line)
{
    if (cudaSuccess != err)
    {
        LOGD("CUDA Runtime API error: %s", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

// This will output the proper error string when calling cudaGetLastError
#define getLastCudaError(msg)      __getLastCudaError (msg, __FILE__, __LINE__)

inline void __getLastCudaError(const char *errorMessage, const char *file, const int line)
{
    cudaError_t err = cudaGetLastError();

    if (cudaSuccess != err)
    {
        LOGD("CUDA error %s:%s", errorMessage, cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

namespace gpu_recursive_gaussian
{

    // Round a / b to nearest higher integer value
    int iDivUp(int a, int b)
    {
        return (a % b != 0) ? (a / b + 1) : (a / b);
    }


    // Transpose a 2D array
    __global__ void d_transpose(uint *odata, uint *idata, int width, int height)
    {
        __shared__ uint block[BLOCK_DIM][BLOCK_DIM+1];

        // read the matrix tile into shared memory
        unsigned int xIndex = blockIdx.x * BLOCK_DIM + threadIdx.x;
        unsigned int yIndex = blockIdx.y * BLOCK_DIM + threadIdx.y;

        if ((xIndex < width) && (yIndex < height))
        {
            unsigned int index_in = yIndex * width + xIndex;
            block[threadIdx.y][threadIdx.x] = idata[index_in];
        }

        __syncthreads();

        // write the transposed matrix tile to global memory
        xIndex = blockIdx.y * BLOCK_DIM + threadIdx.x;
        yIndex = blockIdx.x * BLOCK_DIM + threadIdx.y;

        if ((xIndex < height) && (yIndex < width))
        {
            unsigned int index_out = yIndex * height + xIndex;
            odata[index_out] = block[threadIdx.x][threadIdx.y];
        }
    }

    // convert floating point rgba color to 32-bit integer
    __device__ uint rgbaFloatToInt(float4 rgba)
    {
        rgba.x = __saturatef(rgba.x);   // clamp to [0.0, 1.0]
        rgba.y = __saturatef(rgba.y);
        rgba.z = __saturatef(rgba.z);
        rgba.w = __saturatef(rgba.w);
        return (uint(rgba.w*255)<<24) | (uint(rgba.z*255)<<16) | (uint(rgba.y*255)<<8) | uint(rgba.x*255);
    }

    // convert from 32-bit int to float4
    __device__ float4 rgbaIntToFloat(uint c)
    {
        float4 rgba;
        rgba.x = (c & 0xff) / 255.0f;
        rgba.y = ((c>>8) & 0xff) / 255.0f;
        rgba.z = ((c>>16) & 0xff) / 255.0f;
        rgba.w = ((c>>24) & 0xff) / 255.0f;
        return rgba;
    }

    /*
        simple 1st order recursive filter
        - processes one image column per thread

        parameters:
        id - pointer to input data (RGBA image packed into 32-bit integers)
        od - pointer to output data
        w  - image width
        h  - image height
        a  - blur parameter
    */

    __global__ void
    d_simpleRecursive_rgba(uint *id, uint *od, int w, int h, float a)
    {
        unsigned int x = blockIdx.x*blockDim.x + threadIdx.x;

        if (x >= w) return;

        id += x;    // advance pointers to correct column
        od += x;

        // forward pass
        float4 yp = rgbaIntToFloat(*id);  // previous output

        for (int y = 0; y < h; y++)
        {
            float4 xc = rgbaIntToFloat(*id);
            float4 yc = xc + a*(yp - xc);   // simple lerp between current and previous value
            *od = rgbaFloatToInt(yc);
            id += w;
            od += w;    // move to next row
            yp = yc;
        }

        // reset pointers to point to last element in column
        id -= w;
        od -= w;

        // reverse pass
        // ensures response is symmetrical
        yp = rgbaIntToFloat(*id);

        for (int y = h-1; y >= 0; y--)
        {
            float4 xc = rgbaIntToFloat(*id);
            float4 yc = xc + a*(yp - xc);
            *od = rgbaFloatToInt((rgbaIntToFloat(*od) + yc)*0.5f);
            id -= w;
            od -= w;  // move to previous row
            yp = yc;
        }
    }

    /*
        recursive Gaussian filter

        parameters:
        id - pointer to input data (RGBA image packed into 32-bit integers)
        od - pointer to output data
        w  - image width
        h  - image height
        a0-a3, b1, b2, coefp, coefn - filter parameters
    */

    __global__ void d_recursiveGaussian_rgba(uint *id, uint *od, int w, int h,
                                             float a0, float a1, float a2, float a3,
                                             float b1, float b2, float coefp, float coefn)
    {
        unsigned int x = blockIdx.x*blockDim.x + threadIdx.x;

        if (x >= w) return;

        id += x;    // advance pointers to correct column
        od += x;

        // forward pass
        float4 xp = make_float4(0.0f);  // previous input
        float4 yp = make_float4(0.0f);  // previous output
        float4 yb = make_float4(0.0f);  // previous output by 2
#if CLAMP_TO_EDGE
        xp = rgbaIntToFloat(*id);
        yb = coefp*xp;
        yp = yb;
#endif

        for (int y = 0; y < h; y++)
        {
            float4 xc = rgbaIntToFloat(*id);
            float4 yc = a0*xc + a1*xp - b1*yp - b2*yb;
            *od = rgbaFloatToInt(yc);
            id += w;
            od += w;    // move to next row
            xp = xc;
            yb = yp;
            yp = yc;
        }

        // reset pointers to point to last element in column
        id -= w;
        od -= w;

        // reverse pass
        // ensures response is symmetrical
        float4 xn = make_float4(0.0f);
        float4 xa = make_float4(0.0f);
        float4 yn = make_float4(0.0f);
        float4 ya = make_float4(0.0f);
#if CLAMP_TO_EDGE
        xn = xa = rgbaIntToFloat(*id);
        yn = coefn*xn;
        ya = yn;
#endif

        for (int y = h-1; y >= 0; y--)
        {
            float4 xc = rgbaIntToFloat(*id);
            float4 yc = a2*xn + a3*xa - b1*yn - b2*ya;
            xa = xn;
            xn = xc;
            ya = yn;
            yn = yc;
            *od = rgbaFloatToInt(rgbaIntToFloat(*od) + yc);
            id -= w;
            od -= w;  // move to previous row
        }
    }

    RecursiveGaussian::RecursiveGaussian()
    {
    }

    // free global memory
    RecursiveGaussian::~RecursiveGaussian()
    {
        checkCudaErrors(cudaFree(d_img));
        checkCudaErrors(cudaFree(d_temp));
        checkCudaErrors(cudaFree(d_result));
    }

    // initialize global memory with input image data
    void RecursiveGaussian::init(int width, int height,uint *h_img)
    {
        unsigned int size = width * height * sizeof(unsigned int);

        // allocate device memory
        checkCudaErrors(cudaMalloc((void **) &d_img, size));
        checkCudaErrors(cudaMalloc((void **) &d_temp, size));
        checkCudaErrors(cudaMalloc((void **) &d_result, size));
        checkCudaErrors(cudaMemcpy(d_img, h_img, size, cudaMemcpyHostToDevice));
    }

    // launch transpose kernel
    void RecursiveGaussian::transpose(uint *d_src, uint *d_dest, uint width, int height)
    {
        dim3 grid(iDivUp(width, BLOCK_DIM), iDivUp(height, BLOCK_DIM), 1);
        dim3 threads(BLOCK_DIM, BLOCK_DIM, 1);
        d_transpose<<< grid, threads >>>(d_dest, d_src, width, height);
        getLastCudaError("Kernel execution failed");
    }

    /*
        Perform Gaussian filter on a 2D image using CUDA

        Parameters:
        h_dest   - pointer to destination image in host memory
        width    - image width
        height   - image height
        sigma    - sigma of Gaussian
        order    - filter order (0, 1 or 2)
        nthreads - number of threads
    */

    void RecursiveGaussian::gaussianFilterRGBA(uint *h_dest, int width, int height,
                                               float sigma, int order, int nthreads)
    {
        // compute filter coefficients
        const float
        nsigma = sigma < 0.1f ? 0.1f : sigma,
        alpha = 1.695f / nsigma,
        ema = (float)std::exp(-alpha),
        ema2 = (float)std::exp(-2*alpha),
        b1 = -2*ema,
        b2 = ema2;

        float a0 = 0, a1 = 0, a2 = 0, a3 = 0, coefp = 0, coefn = 0;

        switch (order)
        {
            case 0:
                {
                    const float k = (1-ema)*(1-ema)/(1+2*alpha*ema-ema2);
                    a0 = k;
                    a1 = k*(alpha-1)*ema;
                    a2 = k*(alpha+1)*ema;
                    a3 = -k*ema2;
                }
                break;

            case 1:
                {
                    const float k = (1-ema)*(1-ema)/ema;
                    a0 = k*ema;
                    a1 = a3 = 0;
                    a2 = -a0;
                }
                break;

            case 2:
                {
                    const float
                    ea = (float)std::exp(-alpha),
                    k = -(ema2-1)/(2*alpha*ema),
                    kn = (-2*(-1+3*ea-3*ea*ea+ea*ea*ea)/(3*ea+1+3*ea*ea+ea*ea*ea));
                    a0 = kn;
                    a1 = -kn*(1+k*alpha)*ema;
                    a2 = kn*(1-k*alpha)*ema;
                    a3 = -kn*ema2;
                }
                break;

            default:
                LOGD("gaussianFilter: invalid order parameter!");
                return;
        }

        coefp = (a0+a1)/(1+b1+b2);
        coefn = (a2+a3)/(1+b1+b2);

        // process columns
#if USE_SIMPLE_FILTER
        d_simpleRecursive_rgba<<< iDivUp(width, nthreads), nthreads >>>(d_img, d_temp, width, height, ema);
#else
        d_recursiveGaussian_rgba<<< iDivUp(width, nthreads), nthreads >>>(d_img, d_temp, width, height, a0, a1, a2, a3, b1, b2, coefp, coefn);
#endif
        getLastCudaError("Kernel execution failed");

        transpose(d_temp, d_result, width, height);
        getLastCudaError("transpose: Kernel execution failed");

        // process rows
#if USE_SIMPLE_FILTER
        d_simpleRecursive_rgba<<< iDivUp(height, nthreads), nthreads >>>(d_result, d_temp, height, width, ema);
#else
        d_recursiveGaussian_rgba<<< iDivUp(height, nthreads), nthreads >>>(d_result, d_temp, height, width, a0, a1, a2, a3, b1, b2, coefp, coefn);
#endif
        getLastCudaError("Kernel execution failed");

        transpose(d_temp, d_result, height, width);

        // write back final result to host memory
        unsigned int size = width * height * sizeof(unsigned int);
        checkCudaErrors(cudaMemcpy(h_dest, d_result, size, cudaMemcpyDeviceToHost));
    }
}
