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



#ifndef CONVOLUTIONSEPARABLE_H
#define CONVOLUTIONSEPARABLE_H

#define KERNEL_RADIUS 8
#define KERNEL_LENGTH (2 * KERNEL_RADIUS + 1)

#define MIN_KERNEL_RADIUS 1
#define MAX_KERNEL_RADIUS 8

namespace gpu_convolution_separable
{
    class ConvolutionSeparable
    {
        public:
            ConvolutionSeparable();
            ~ConvolutionSeparable();

            // initialize global memory with input image data
            void init(int width, int height, unsigned int *hImage);
            // set convolution kernel
            void setConvolutionKernel(float *h_Kernel);
            // launch row convolution kernel
            void convolutionRowsGPU(int imageW,
                                    int imageH,
                                    int kernel_radius);
            // launch column convolution kernel
            void convolutionColumnsGPU(int imageW,
                                       int imageH,
                                       int kernel_radius);
            // write the final result back to host memory
            void copyToHost(unsigned int *processedData, int width, int height);
        private:
            // buffers
            uint *d_Input;
            uint *d_Buffer;
            uint *d_Output;
    };
}//namespace gpu_convolution_separable

#endif
