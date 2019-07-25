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

#include <assert.h>
#include "convolutionSeparable.h"
#include <android/log.h>

#define APP_NAME "CUDA_CORE"

#define LOGD(...) ((void)__android_log_print(ANDROID_LOG_DEBUG,  \
                                             APP_NAME, \
                                             __VA_ARGS__))

// This will output the proper CUDA error strings in the event that a CUDA host call returns an error
#define checkCudaErrors(err)           __checkCudaErrors (err, __FILE__, __LINE__)

inline void __checkCudaErrors(cudaError err, const char *file, const int line)
{
    if (cudaSuccess != err)
    {
        LOGD("CUDA Runtime API error: %s", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

////////////////////////////////////////////////////////////////////////////////
// Convolution kernel storage
////////////////////////////////////////////////////////////////////////////////
__constant__ float c_Kernel[2 * MAX_KERNEL_RADIUS + 1];

namespace gpu_convolution_separable
{
    // convert floating point rgba color to 32-bit integer
    __device__ unsigned int rgbaFloatToInt(float4 rgba)
    {
        rgba.x = __saturatef(rgba.x);   // clamp to [0.0, 1.0]
        rgba.y = __saturatef(rgba.y);
        rgba.z = __saturatef(rgba.z);
        rgba.w = __saturatef(rgba.w);
        return ((unsigned int)(rgba.w * 255.0f) << 24) |
               ((unsigned int)(rgba.z * 255.0f) << 16) |
               ((unsigned int)(rgba.y * 255.0f) <<  8) |
               ((unsigned int)(rgba.x * 255.0f));
    }

    __device__ float4 rgbaIntToFloat(unsigned int c)
    {
        float4 rgba;
        rgba.x = (c & 0xff) * 0.003921568627f;       //  /255.0f;
        rgba.y = ((c>>8) & 0xff) * 0.003921568627f;  //  /255.0f;
        rgba.z = ((c>>16) & 0xff) * 0.003921568627f; //  /255.0f;
        rgba.w = ((c>>24) & 0xff) * 0.003921568627f; //  /255.0f;
        return rgba;
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Row convolution filter
    ////////////////////////////////////////////////////////////////////////////////
#define   ROWS_BLOCKDIM_X 16
#define   ROWS_BLOCKDIM_Y 4
#define ROWS_RESULT_STEPS 8
#define   ROWS_HALO_STEPS 1

    __global__ void convolutionRowsKernel(
        unsigned int *d_Dst,
        unsigned int *d_Src,
        int imageW,
        int imageH,
        int pitch,
        int kernel_radius
    )
    {
        __shared__ unsigned int s_Data[ROWS_BLOCKDIM_Y][(ROWS_RESULT_STEPS + 2 * ROWS_HALO_STEPS) * ROWS_BLOCKDIM_X];

        //Offset to the left halo edge
        const int baseX = (blockIdx.x * ROWS_RESULT_STEPS - ROWS_HALO_STEPS) * ROWS_BLOCKDIM_X + threadIdx.x;
        const int baseY = blockIdx.y * ROWS_BLOCKDIM_Y + threadIdx.y;

        d_Src += baseY * pitch + baseX;
        d_Dst += baseY * pitch + baseX;

        //Load main data
#pragma unroll

        for (int i = ROWS_HALO_STEPS; i < ROWS_HALO_STEPS + ROWS_RESULT_STEPS; i++)
        {
            s_Data[threadIdx.y][threadIdx.x + i * ROWS_BLOCKDIM_X] = d_Src[i * ROWS_BLOCKDIM_X];
        }

        //Load left halo
#pragma unroll

        for (int i = 0; i < ROWS_HALO_STEPS; i++)
        {
            s_Data[threadIdx.y][threadIdx.x + i * ROWS_BLOCKDIM_X] = (baseX >= -i * ROWS_BLOCKDIM_X) ? d_Src[i * ROWS_BLOCKDIM_X] : 0;
        }

        //Load right halo
#pragma unroll

        for (int i = ROWS_HALO_STEPS + ROWS_RESULT_STEPS; i < ROWS_HALO_STEPS + ROWS_RESULT_STEPS + ROWS_HALO_STEPS; i++)
        {
            s_Data[threadIdx.y][threadIdx.x + i * ROWS_BLOCKDIM_X] = (imageW - baseX > i * ROWS_BLOCKDIM_X) ? d_Src[i * ROWS_BLOCKDIM_X] : 0;
        }

        //Compute and store results
        __syncthreads();

#pragma unroll

        for (int i = ROWS_HALO_STEPS; i < ROWS_HALO_STEPS + ROWS_RESULT_STEPS; i++)
        {
            float4 sum = { 0.0f, 0.0f, 0.0f, 0.0f };

            //#pragma unroll
            for (int j = -kernel_radius; j <= kernel_radius; j++)
            {
                float4 temp = rgbaIntToFloat(s_Data[threadIdx.y][threadIdx.x + i * ROWS_BLOCKDIM_X + j]);

                sum.x += c_Kernel[kernel_radius - j] * temp.x;
                sum.y += c_Kernel[kernel_radius - j] * temp.y;
                sum.z += c_Kernel[kernel_radius - j] * temp.z;
                sum.w += c_Kernel[kernel_radius - j] * temp.w;
            }

            d_Dst[i * ROWS_BLOCKDIM_X] = rgbaFloatToInt(sum);
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Column convolution filter
    ////////////////////////////////////////////////////////////////////////////////
#define   COLUMNS_BLOCKDIM_X 16
#define   COLUMNS_BLOCKDIM_Y 8
#define COLUMNS_RESULT_STEPS 8
#define   COLUMNS_HALO_STEPS 1

    __global__ void convolutionColumnsKernel(
        unsigned int *d_Dst,
        unsigned int *d_Src,
        int imageW,
        int imageH,
        int pitch,
        int kernel_radius
    )
    {
        __shared__ unsigned int s_Data[COLUMNS_BLOCKDIM_X][(COLUMNS_RESULT_STEPS + 2 * COLUMNS_HALO_STEPS) * COLUMNS_BLOCKDIM_Y + 1];

        //Offset to the upper halo edge
        const int baseX = blockIdx.x * COLUMNS_BLOCKDIM_X + threadIdx.x;
        const int baseY = (blockIdx.y * COLUMNS_RESULT_STEPS - COLUMNS_HALO_STEPS) * COLUMNS_BLOCKDIM_Y + threadIdx.y;
        d_Src += baseY * pitch + baseX;
        d_Dst += baseY * pitch + baseX;

        //Main data
#pragma unroll

        for (int i = COLUMNS_HALO_STEPS; i < COLUMNS_HALO_STEPS + COLUMNS_RESULT_STEPS; i++)
        {
            s_Data[threadIdx.x][threadIdx.y + i * COLUMNS_BLOCKDIM_Y] = d_Src[i * COLUMNS_BLOCKDIM_Y * pitch];
        }

        //Upper halo
#pragma unroll

        for (int i = 0; i < COLUMNS_HALO_STEPS; i++)
        {
            s_Data[threadIdx.x][threadIdx.y + i * COLUMNS_BLOCKDIM_Y] = (baseY >= -i * COLUMNS_BLOCKDIM_Y) ? d_Src[i * COLUMNS_BLOCKDIM_Y * pitch] : 0;
        }

        //Lower halo
#pragma unroll

        for (int i = COLUMNS_HALO_STEPS + COLUMNS_RESULT_STEPS; i < COLUMNS_HALO_STEPS + COLUMNS_RESULT_STEPS + COLUMNS_HALO_STEPS; i++)
        {
            s_Data[threadIdx.x][threadIdx.y + i * COLUMNS_BLOCKDIM_Y]= (imageH - baseY > i * COLUMNS_BLOCKDIM_Y) ? d_Src[i * COLUMNS_BLOCKDIM_Y * pitch] : 0;
        }

        //Compute and store results
        __syncthreads();

        //#pragma unroll
        for (int i = COLUMNS_HALO_STEPS; i < COLUMNS_HALO_STEPS + COLUMNS_RESULT_STEPS; i++)
        {
            float4 sum = { 0.0f, 0.0f, 0.0f, 0.0f };

            //#pragma unroll
            for (int j = -kernel_radius; j <= kernel_radius; j++)
            {
                float4 temp = rgbaIntToFloat(s_Data[threadIdx.x][threadIdx.y + i * COLUMNS_BLOCKDIM_Y + j]);
                sum.x += c_Kernel[kernel_radius - j] * temp.x;
                sum.y += c_Kernel[kernel_radius - j] * temp.y;
                sum.z += c_Kernel[kernel_radius - j] * temp.z;
                sum.w += c_Kernel[kernel_radius - j] * temp.w;
            }

            d_Dst[i * COLUMNS_BLOCKDIM_Y * pitch] = rgbaFloatToInt(sum);
        }
    }


    ////////////////////////////////////////////////////////////////////////////////
    // ConvolutionSeparable Class implementation
    ////////////////////////////////////////////////////////////////////////////////

    ConvolutionSeparable::ConvolutionSeparable()
    {
    }

    ConvolutionSeparable::~ConvolutionSeparable()
    {
        // free device memory
        checkCudaErrors(cudaFree(d_Input));
        checkCudaErrors(cudaFree(d_Buffer));
        checkCudaErrors(cudaFree(d_Output));
    }

    // Allocating and initializing CUDA global memory with input image data
    void ConvolutionSeparable::init(int width, int height,  unsigned int *hImage)
    {
        checkCudaErrors(cudaMalloc((void **)&d_Input,   width * height * sizeof(unsigned int)));
        checkCudaErrors(cudaMalloc((void **)&d_Output,  width * height * sizeof(unsigned int)));
        checkCudaErrors(cudaMalloc((void **)&d_Buffer,  width * height * sizeof(unsigned int)));
        checkCudaErrors(cudaMemcpy(d_Input, hImage,    width * height * sizeof(unsigned int), cudaMemcpyHostToDevice));
    }

    // set the convolution kernel in constant memory
    void ConvolutionSeparable::setConvolutionKernel(float *h_Kernel)
    {
        checkCudaErrors(cudaMemcpyToSymbol(c_Kernel, h_Kernel, (2*MAX_KERNEL_RADIUS+1) * sizeof(float)));
    }

    // copy the final results back to the host memory
    void ConvolutionSeparable::copyToHost(unsigned int *processedData, int width, int height)
    {
        checkCudaErrors(cudaMemcpy(processedData, d_Output, width * height * sizeof(unsigned int), cudaMemcpyDeviceToHost));
    }

    // convolve with a column vector
    void ConvolutionSeparable::convolutionColumnsGPU(
        int imageW,
        int imageH,
        int kernel_radius
    )
    {
        assert(COLUMNS_BLOCKDIM_Y * COLUMNS_HALO_STEPS >= KERNEL_RADIUS);
        assert(imageW % COLUMNS_BLOCKDIM_X == 0);
        assert(imageH % (COLUMNS_RESULT_STEPS * COLUMNS_BLOCKDIM_Y) == 0);

        dim3 blocks(imageW / COLUMNS_BLOCKDIM_X, imageH / (COLUMNS_RESULT_STEPS * COLUMNS_BLOCKDIM_Y));
        dim3 threads(COLUMNS_BLOCKDIM_X, COLUMNS_BLOCKDIM_Y);

        convolutionColumnsKernel<<<blocks, threads>>>(
            d_Output,
            d_Buffer,
            imageW,
            imageH,
            imageW,
            kernel_radius
        );
        //    getLastCudaError("convolutionColumnsKernel() execution failed\n");
    }

    // convolve with a row vector
    void ConvolutionSeparable::convolutionRowsGPU(
        int imageW,
        int imageH,
        int kernel_radius
    )
    {
        assert(ROWS_BLOCKDIM_X * ROWS_HALO_STEPS >= KERNEL_RADIUS);
        assert(imageW % (ROWS_RESULT_STEPS * ROWS_BLOCKDIM_X) == 0);
        assert(imageH % ROWS_BLOCKDIM_Y == 0);

        dim3 blocks(imageW / (ROWS_RESULT_STEPS * ROWS_BLOCKDIM_X), imageH / ROWS_BLOCKDIM_Y);
        dim3 threads(ROWS_BLOCKDIM_X, ROWS_BLOCKDIM_Y);

        convolutionRowsKernel<<<blocks, threads>>>(
            d_Buffer,
            d_Input,
            imageW,
            imageH,
            imageW,
            kernel_radius
        );
        //    getLastCudaError("convolutionRowsKernel() execution failed\n");
    }
}
