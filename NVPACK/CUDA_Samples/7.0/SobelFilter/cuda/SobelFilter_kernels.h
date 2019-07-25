////////////////////////////////////////////////////////////////////////////
//
// Copyright 1993-2014 NVIDIA Corporation.  All rights reserved.
//
// Please refer to the NVIDIA end user license agreement (EULA) associated
// with this source code for terms and conditions that govern your use of
// this software. Any use, reproduction, disclosure, or distribution of
// this software and related documentation outside the terms of the EULA
// is strictly prohibited.
//
////////////////////////////////////////////////////////////////////////////

#ifndef _SOBEL_FILTER_KERNEL_H_
#define _SOBEL_FILTER_KERNEL_H_

typedef unsigned char Pixel;

// global determines which filter to invoke
enum SobelDisplayMode
{
    SOBELDISPLAY_IMAGE = 0,
    SOBELDISPLAY_SOBELTEX,
    SOBELDISPLAY_SOBELSHARED
};


namespace gpu_sobel_filter
{
    class SobelFilter
    {
        public:
            SobelFilter();
            ~SobelFilter();
            // initialization of the textures here
            //void initFilter(int iw, int ih, Pixel *data, int Bpp);
            void setupTexture(int iw, int ih, Pixel *data, int Bpp);
            void deleteTexture(void);
            // sobel filter is applied here
            void sobelFilter(Pixel *odata, int iw, int ih, enum SobelDisplayMode mode, float fScale);
        private:
            // final result of applying a box filter
            unsigned char *d_result;

            enum SobelDisplayMode g_DisplayMode;
    };
}//namespace gpu_sobel_filter_

#endif

